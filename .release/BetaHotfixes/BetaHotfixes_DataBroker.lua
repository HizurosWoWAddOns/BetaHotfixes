
local addon, ns = ...;
local L,C,module = ns.L,WrapTextInColorCode;

local ACD = LibStub("AceConfigDialog-3.0");
local LDB,menu,_ = {},CreateFrame("frame",addon.."Menu",UIParent,"UIDropDownMenuTemplate");
LDB.Lib = LibStub("LibDataBroker-1.1");
LDB.IconLib = LibStub("LibDBIcon-1.0");

local curTT,tMetaData,options;
local headers = {"Hotfix","Misc","DevTools"};
local on,off = C(VIDEO_OPTIONS_ENABLED,"ff00ff00"),C(VIDEO_OPTIONS_DISABLED,"ffff0000");

local menuList,menuSeparator = {},{
	text="", icon="Interface\\Common\\UI-TooltipDivider-Transparent",
	hasArrow=false, dist=0, isTitle=true, isUninteractable=true, notCheckable=true, iconOnly=true,
	tCoordLeft=0, tCoordRight=1, tCoordTop=0, tCoordBottom=1, tSizeX=0, tSizeY=8, tFitDropDownSizeX=true,
	iconInfo={tCoordLeft=0, tCoordRight=1, tCoordTop=0, tCoordBottom=1, tSizeX=0, tSizeY=8, tFitDropDownSizeX=true}
};

local function menuListSortByLabel(a,b)
	return a.label < b.label;
end

function LDB.IconCreatedCallback(self,cbEvent,ldbIconFrame,ldbIconName)
	if ldbIconName==addon and self.ldbIconChanged==nil then
		local highlight, overlay, background, icon = ldbIconFrame:GetRegions();
		overlay:SetAtlas("worldquest-tracker-ring",false);
		overlay:SetSize(34,34);
		overlay:ClearAllPoints();
		overlay:SetPoint("CENTER");
		background:SetSize(25,25);
		icon:SetSize(18,18);
		icon:ClearAllPoints();
		icon:SetPoint("CENTER");
		self.ldbIconChanged=true;
	end
end

local function MenuEntryToggle(self)
	local mod,key = unpack(self.arg1);
	BetaHotfixDB.modules[mod][key] = not BetaHotfixDB.modules[mod][key];
	if ns.modules[mod].on_toggle then
		ns.modules[mod].on_toggle(key,true);
	end
end

local function MenuEntryChecked(self)
	local mod,key = unpack(self.arg1);
	return BetaHotfixDB.modules[mod][key];
end

local function sortByOrder(a,b)
	local a,b = tonumber(a.order) or 100,tonumber(b.order) or 100;
	return a<b;
end

local function entries2tooltip(g,k,v,target)
	--if modData.options and modData.options.defaults
	--tt:AddDoubleLine(C(v.label,"ffffffff"),BetaHotfixDB.modules[k] and on or off);
	if g==1 then
		target:AddDoubleLine(C(v.name,"ffffffff"),BetaHotfixDB.modules[v.mod][v.key] and on or off);
	end
end

local types = {toggle=1, execute=1};
local function entries2menuList(g,i,v,info)
	if i==1 then
		UIDropDownMenu_AddSeparator(1);
		info.text = C(headers[g],"ff44aaff");
		info.isTitle=true;
		info.notCheckable=1;
		UIDropDownMenu_AddButton(info);
		info.isTitle=nil;
		info.disabled=nil;
	end
	if v.type=="toggle" then
		info.text = v.name;
		info.func = MenuEntryToggle;
		info.isNotRadio=1;
		info.notCheckable=nil;
		info.checked=MenuEntryChecked;
		info.arg1={v.mod,v.key};
		info.keepShownOnClick=true;
	elseif v.type=="execute" then
		info.text = v.name;
		info.notCheckable=1;
		info.func=v.func;
		info.arg1={v.mod,v.key};
	end
	if v.desc then
		info.tooltipTitle = v.name;
		info.tooltipText = v.desc;
		info.tooltipWhileDisabled = 1;
		info.tooltipOnButton = 1;
	end
	UIDropDownMenu_AddButton(info);

	-- clear
	info.keepShownOnClick=nil;
	info.isTitle=nil;
	info.isNotRadio=1;
	info.disabled=nil;
	info.notCheckable=nil;
	info.tooltipTitle=nil;
	info.tooltipText=nil;
	info.tooltipWhileDisabled=nil;
	info.tooltipOnButton=nil;
	info.func=nil;
	info.arg1=nil;
	info.checked=nil;
end

local function collectEntries(func,target)
	local group = {{},{},{}};
	for modName,modData in pairs(ns.modules)do
		if modData.options then
			if modData.options.hotfix then
				table.sort(modData.options.hotfix,sortByOrder);
				for k,v in pairs(modData.options.hotfix) do
					if types[v.type] then
						local v = CopyTable(v);
						v.mod=modName;
						v.key=k
						tinsert(group[1],v);
					end
				end
			end
			if modName~="languages" and modData.options.misc then
				table.sort(modData.options.misc,sortByOrder);
				for k,v in pairs(modData.options.misc) do
					if types[v.type] then
						local v = CopyTable(v);
						v.mod=modName;
						v.key=k
						tinsert(group[2],v);
					end
				end
			end
			if modData.options.devtools and BetaHotfixDB.debug_mode then
				table.sort(modData.options.devtools,sortByOrder);
				for k,v in pairs(modData.options.devtools) do
					if types[v.type] then
						local v = CopyTable(v);
						v.mod=modName;
						v.key=k
						tinsert(group[3],v);
					end
				end
			end
		end
	end

	for g=1, #group do
		if #group[g]>0 then
			local header = true;
			for i,v in pairs(group[g])do
				func(g,i,v,target)
			end
		end
	end
end

local function DropDownMenu_Initialize()
	local info = UIDropDownMenu_CreateInfo();
	info.notCheckable = 1;

	info.text = addon.." - "..L.ShortAccessMenu;
	info.notCheckable = 1;
	info.isTitle = true;
	UIDropDownMenu_AddButton(info);

	collectEntries(entries2menuList,info);

	UIDropDownMenu_AddSeparator(1);

	info.text = L.CloseMenu;
	info.func = function()end;
	info.notCheckable = 1;
	UIDropDownMenu_AddButton(info);
end

function ns.DataBroker_Init()
	LDB.Object = LDB.Lib:NewDataObject(addon,{
		type	= "launcher",
		icon	= 648632,
		label	= addon,
		text	= addon,
		OnTooltipShow = function(tt)
			curTT = tt;
			tt:AddLine(addon);
			tt:AddLine(" ");
			collectEntries(entries2tooltip,tt);
			tt:AddLine(" ");
			tt:AddDoubleLine(C(L.LeftClick,"ff00ff00")..":",C(L.ShortAccessMenu,"ff00aaff"));
			tt:AddDoubleLine(C(L.RightClick,"ff00ff00")..":",C(OPTIONS,"ff00aaff"));
		end,
		OnClick = function(self, button)
			if button=="LeftButton" then
				if curTT then
					curTT:Hide();
				end
				UIDropDownMenu_Initialize(menu, DropDownMenu_Initialize, "MENU");
				ToggleDropDownMenu(1, nil, menu, self, 0, 0);
			else
				if ACD.OpenFrames[addon]~=nil then
					ACD:Close(addon);
				else
					ACD:Open(addon);
				end
			end
		end
	});

	if BetaHotfixDB.minimap==nil then
		BetaHotfixDB.minimap={hide=false,minimapPos=185};
	end

	LDB.IconLib.RegisterCallback(LDB, "LibDBIcon_IconCreated", "IconCreatedCallback");
	LDB.IconLib:Register(addon, LDB.Object, BetaHotfixDB.minimap);
end
