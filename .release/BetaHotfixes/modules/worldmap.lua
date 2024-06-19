
local addon, ns = ...;
local L,C,module = ns.L,WrapTextInColorCode;
if ns.interfaceVersion<90000 then return end

local gsub = gsub
local modName,label = "worldmap",WORLD_MAP; -- worldmap_hotfix
local path,enabled = "Interface/AddOns/BetaHotfixes/media/WorldMap/";
local replaceTextures,replaceTaxiNodes = {},{};

local C_Map_GetMapArtLayerTextures_Orig = C_Map.GetMapArtLayerTextures;
local function C_Map_GetMapArtLayerTextures_Replacement(mapID,layerIndex)
	if BetaHotfixDB["greentexture-uiMapId-"..mapID] then
		local data = ns.WorldMapData(mapID,layerIndex);
		ns.print("hooked","C_Map.GetMapArtLayerTextures",mapID,layerIndex,data);
		if data then
			if replaceTextures[mapID]==nil then
				replaceTextures[mapID] = {[layerIndex]={}};
			elseif replaceTextures[mapID][layerIndex]==nil then
				replaceTextures[mapID][layerIndex] = {};
			end
			for i=data[1], data[2] do
				tinsert(replaceTextures[mapID][layerIndex],path..data[3].."/"..data[4]:format(i));
			end
		end
		if replaceTextures and replaceTextures[mapID] and replaceTextures[mapID][layerIndex] then
			return replaceTextures[mapID][layerIndex];
		end
	end
	return C_Map_GetMapArtLayerTextures_Orig(mapID,layerIndex);
	--[[
	if textures and textures[1] then
		if BetaHotfixDB.modules[modName].boralus and mapID==1161 and #textures<150 then
			local tmp = {};
			for i=1, 150 do
				tinsert(tmp,path.."boraluscity/boraluscity"..i);
			end
			textures = tmp;
		elseif BetaHotfixDB.modules[modName].greentextures then
			if ns.WorldMapData then
				replaceTextures = ns.WorldMapData();
				ns.WorldMapData = nil;
			end
			for i,id in pairs(textures) do
				if replaceTextures[id] then
					textures[i] = path..replaceTextures[id];
				end
			end
		end
	end
	--return textures;
	]]
end
C_Map.GetMapArtLayerTextures = C_Map_GetMapArtLayerTextures_Replacement;

local C_MapExplorationInfo_GetExploredMapTextures_Orig = C_MapExplorationInfo.GetExploredMapTextures;
local function C_MapExplorationInfo_GetExploredMapTextures_Replacement(mapID)
	ns.print("hooked","C_MapExplorationInfo.GetExploredMapTextures");
	local data = C_MapExplorationInfo_GetExploredMapTextures_Orig(mapID);
	if BetaHotfixDB.modules[modName].greentextures and data then
		for areaIndex=1, #data do
			if data[areaIndex].fileDataIDs and data[areaIndex].fileDataIDs[1] then
				for i,id in pairs(data[areaIndex].fileDataIDs) do
					if replaceTextures[id] then
						data[areaIndex].fileDataIDs[i] = path..replaceTextures[id];
					end
				end
			end
		end
	end
	return data;
end
--C_MapExplorationInfo.GetExploredMapTextures = C_MapExplorationInfo_GetExploredMapTextures_Replacement

local C_TaxiMap_GetTaxiNodesForMap_Orig = C_TaxiMap.GetTaxiNodesForMap;
local function C_TaxiMap_GetTaxiNodesForMap_Replacement(...)
	ns.print("hooked","C_TaxiMap.GetTaxiNodesForMap");
	local taxinodes = C_TaxiMap_GetTaxiNodesForMap_Orig(...);

	if BetaHotfixDB.modules[modName].ferrymaster then
		for i=1, #taxinodes do
			if taxinodes[i] and taxinodes[i].nodeID and replaceTaxiNodes[taxinodes[i].nodeID] then
				taxinodes[i].atlasName=nil;
				taxinodes[i].textureIndex=replaceTaxiNodes[taxinodes[i].nodeID];
			end
		end
	end

	return taxinodes;
end
--C_TaxiMap.GetTaxiNodesForMap = C_TaxiMap_GetTaxiNodesForMap_Replacement

local function opt(info,value)
	local modName = info[#info];
	if value~=nil then
		BetaHotfixDB.worldmap[modName] = value;
		return;
	end
	return BetaHotfixDB.worldmap[modName];
end

local function flagIt(info)
	local key = info[#info];
	if key=="flagAll" then
		local args = module.options.hotfix.worldmap.args
		ns.debug(key)
		for k in pairs(args)do
			if k:match("greentexture-uiMapId-%d") then
				print(k)
			end
		end
	elseif key=="flagNone" then
		ns.debug(key)
		local args = module.options.hotfix.worldmap.args
		for k in pairs(args)do
			if k:match("greentexture-uiMapId-%d") then
			end
		end
	end
end

module = {
	label = label,
	--get=opt,
	--set=opt,
	options = {
		hotfix = {
			header1 = {
				type = "header", order = 1,
				name = L.GreenTexture,
			},
			desc1 = {
				type = "description", order=2, fontSize="medium",
				name = L.GreenTextureDesc
			},
			worldmap = {
				type="group", order=3, inline=true,
				name=C(WORLD_MAP,"ffeedd00"),
				args = {
					info = {
						type = "description", order = 0, fontSize="large",
						name = L.WorldMapEmpty
					},

					flagAll = { type = "execute", name = ALL, order=1, func = flagIt, hidden = true },
					flagNone = { type = "execute", name = NONE, order=2, func = flagIt, hidden = true },
					-- filled by function
				}
			},
			exploration = {
				type="group", order=4, inline=true,
				name=L.Exploration,desc=C(L.ExplorationDesc,"ffeedd00"),
				args = {
					info = {
						type = "description", order = 0, fontSize="large",
						name = L.ExplorationEmpty
					}
					-- filled by function
				}
			},
			--[[
			header2 = {
				type = "header", order=5,
				name = L.IconReplacements
			},
			desc2 = {
				type = "description", order=6,
				name = L.IconReplacementsDesc
			}
			ferrymaster = {
				type="toggle", order=7, width="full", descStyle="inline",
				name=L.WorldMapFerryMaster,desc=C(L.WorldMapFerryMasterDesc,"ffeedd00")
			},
			--]]
		},
		defaults = {
			ferrymaster = false
		},
		new_build_reset = {
			"ferrymaster"
		}
	},
}

function module.on_addoptions()
	ns.debug("?","worldmap","add-option");
	local t = ns.GetWorldMapIDs();
	if #t>0 then
		local args = module.options.hotfix.worldmap.args;
		local count = 0;
		for i=1, #t do
			local info = C_Map.GetMapInfo(t[i]) or {name=UNKNOWN};
			local key = "greentexture-uiMapId-"..t[i]
			args[key] = {
				type = "toggle",
				name = info.name,
				order = 10+count,
			}
			module.options.defaults[key] = false;
			tinsert(module.options.new_build_reset,key);
			count=count+1;
		end
		args.info.hidden = count~=0
		--args.flagAll.hidden = count==0
		--args.flagNone.hidden = count==0
	else
		module.options.hotfix.worldmap.disabled = true;
	end

	local t = ns.GetExplorationMapIDs();
	if #t>0 then
		local args = module.options.hotfix.exploration.args;
		for i=1, #t do
			local info = C_Map.GetMapInfo(t[i]) or {name=UNKNOWN};
			local key = "exploration-uiMapId-"..t[i]
			args[key] = {
				type = "toggle",
				name = info.name
			}
			module.options.defaults[key] = false;
			tinsert(module.options.new_build_reset,key);
		end
	else
		module.options.hotfix.exploration.disabled = true;
	end

	--if ns.CountTaxiNodes()==0 then
	--	module.options.hotfix.ferrymaster.disabled = true;
	--end
end

function module.on_toggle(optName,showDisabled)
	local label;
	local key,id = optName:match("^(.*)%-uiMapId%-(%d+)$");
	id = tonumber(id);
	--[[
	if key=="greentexture" and id then
		label = "WorldMapGreenTexture";
	elseif key=="exploration" and id then
		label = "ExplorationGreenTexture";
	elseif optName=="ferrymaster" then
		label = "WorldMapFerryMaster";
	end
	if label and (showDisabled or BetaHotfixDB.modules[modName][optName]) then
		ns.print_status(L[label],BetaHotfixDB.modules[modName][optName]);
	end
	--]]
end

ns.modules[modName] = module;
