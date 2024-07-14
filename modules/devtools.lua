
local addon, ns = ...;
local L,C,module = ns.L,WrapTextInColorCode;
if ns.interfaceVersion<110000 then return end

local modName,modLabel = "devtools",L.DevTools; -- GreenMapDumpLabel -- worldmap_dump
local _C_Map_GetMapArtLayerTextures = C_Map.GetMapArtLayerTextures;
local _C_MapExplorationInfo_GetExploredMapTextures = C_MapExplorationInfo.GetExploredMapTextures;
local uiMapIDs = {} -- filled by function

BetaHotfixes_MapControls_Mixin = {};


function BetaHotfixes_MapControls_Mixin:OnLoad()
	self.backdropInfo = BACKDROP_DIALOG_32_32;
	self:ApplyBackdrop();

	hooksecurefunc(WorldMapFrame,"OnMapChanged",function()
		self.currentIndex = false;
		self.currentID = WorldMapFrame:GetMapID();
		self.num:SetText(self.currentID);
		for i=1, #uiMapIDs do
			if self.currentID==uiMapIDs[i] then
				self.currentIndex=i;
				break;
			end
		end
		if not self.currentIndex then
			self.currentIndex = 1;
		end
	end);
end

function BetaHotfixes_MapControls_Mixin:OnShow()
	wipe(uiMapIDs);
	for i=2213, 4000 do
		if C_Map.GetMapInfo(i) then
			tinsert(uiMapIDs,i);
		end
	end
end

function BetaHotfixes_MapControls_Mixin:PrevMap()
	self.currentIndex = self.currentIndex - 1;
	if self.currentIndex==0 then
		self.currentIndex = #uiMapIDs;
	end
	--ns.debug(self.currentIndex,uiMapIDs[self.currentIndex]);
	WorldMapFrame:SetMapID(uiMapIDs[self.currentIndex]);
end

function BetaHotfixes_MapControls_Mixin:NextMap()
	self.currentIndex = self.currentIndex + 1;
	if self.currentIndex>#uiMapIDs then
		self.currentIndex = 1;
	end
	--ns.debug(self.currentIndex,uiMapIDs[self.currentIndex]);
	WorldMapFrame:SetMapID(uiMapIDs[self.currentIndex]);
end

function BetaHotfixes_MapControls_Mixin:DumpMap()
	if not WorldMapFrame:IsShown() then
		ns.print(L.GreenMapDump,"",L.GreenMapDumpError1);
		return;
	end

	local mapID = WorldMapFrame:GetMapID();
	local mapInfo = C_Map.GetMapInfo(mapID);
	local mapLevels = C_Map.GetMapLevels(mapID);
	local layers = C_Map.GetMapArtLayers(mapID);
	local data = {"id-"..mapID};

	local textures = {};
	for layerIndex,layerInfo in ipairs(layers)do
		textures[layerIndex] = _C_Map_GetMapArtLayerTextures(mapID, layerIndex); -- map textures
		tinsert(data,"l-"..layerIndex.."-"..textures[layerIndex][1]);
	end

	local exploration = _C_MapExplorationInfo_GetExploredMapTextures(mapID); -- exploration textures
	if exploration then
		for explorationIndex, explorationInfo in ipairs(exploration) do
			tinsert(data,"e-"..explorationIndex.."-"..explorationInfo.fileDataIDs[1]);
		end
	end

	ns.print("Map dumped...",unpack(data));

	if BetaHotfixDB.MapDumps==nil then
		BetaHotfixDB.MapDumps={};
	end

	data.textures = textures;
	data.exploration = exploration;
	BetaHotfixDB.MapDumps[mapID] = data;
end


module = {
	label = modLabel,

	options = {
		devtools = {
			{type="execute", name=L.GreenMapDump, desc = L.GreenMapDumpLabelDesc, func=mapdump},
			{type="execute", name="MapControl", func=function() BetaHotfixes_MapControls:SetShown(not BetaHotfixes_MapControls:IsShown()) end}
		}
	}
};

ns.modules[modName] = module;

