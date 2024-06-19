
local addon, ns = ...;
local L,C = ns.L,WrapTextInColorCode;
ns.modules = {};
ns.wowVersion, ns.buildVersion, ns.buildDate, ns.interfaceVersion = GetBuildInfo()

local frame = CreateFrame("frame",addon.."Frame");
local curTT,tMetaData,options;
local on,off = C(VIDEO_OPTIONS_ENABLED:lower(),"ff00ff00"),C(VIDEO_OPTIONS_DISABLED:lower(),"ffff4444");

do
	local addon_short = "BH";
	local colors = {"82c5ff","00ff00","ff6060","44ffff","ffff00","ff8800","ff44ff","ffffff"};
	local function colorize(...)
		local t,c,a1 = {tostringall(...)},1,...;
		if type(a1)=="boolean" then tremove(t,1); end
		if a1~=false then
			tinsert(t,1,"|cff82c5ff"..((a1==true and addon_short) or (a1=="||" and "||") or addon).."|r"..(a1~="||" and HEADER_COLON or ""));
			c=2;
		end
		for i=c, #t do
			if not t[i]:find("\124c") then
				t[i],c = "|cff"..colors[c]..t[i].."|r", c<#colors and c+1 or 1;
			end
		end
		return unpack(t);
	end
	function ns.print(...)
		print(colorize(...));
	end
	function ns.debug(...)
		--print(colorize("<debug>",...));
		ConsolePrint(date("|cff999999%X|r"),colorize(...));
	end
end

function ns.toggleModule(modName,startup)
	if modName==true then
		for modName in pairs(ns.modules) do
			if ns.modules[modName].state == nil then
				ns.modules[modName].state = false;
			end
			ns.toggleModule(modName,true);
		end
	elseif modName and ns.modules[modName] and (not ns.modules[modName].hidden) then
		if not startup then
			BetaHotfixDB.modules[modName] = not BetaHotfixDB.modules[modName];
		end
		if ns.modules[modName].state ~= BetaHotfixDB.modules[modName] then
			ns.modules[modName].state = ns.modules[modName].func(BetaHotfixDB.modules[modName]);
		end
	end
end

frame:SetScript("OnEvent",function(self,event,...)
	local name = ...;
	if event=="ADDON_LOADED" and addon==... then
		ns.print(L.AddOnLoaded);
		if not ns.Options_Init() then
			ns.print("||","|cffff4444"..L.BuildChanged.."|r");
		end

		ns.DataBroker_Init();

		for modName,modData in pairs(ns.modules) do
			-- register options
			if modData.options then
				ns.Options_AddModule(modName,modData);
			end
		end
	elseif event=="PLAYER_LOGIN" then
		for modName,modData in pairs(ns.modules) do
			print(modName)
			if modData[event] then
				modData[event]()
			end
		end
	end
	-- module events
	if self.modEvents and self.modEvents[event] then
		for i=1, #self.modEvents[event] do
			ns.modules[self.modEvents[event][i]].events[event](...);
		end
	end
end);

frame:RegisterEvent("ADDON_LOADED");
frame:RegisterEvent("PLAYER_LOGIN");
