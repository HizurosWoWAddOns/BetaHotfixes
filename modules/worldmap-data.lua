
local addon,ns = ...;
local worldmap,exploration,taxiNodes = {},{},{};

function ns.WorldMapData(uiMapId,layer)
	if worldmap[uiMapId] then
		return worldmap[uiMapId][layer];
	end
end

function ns.GetWorldMapIDs()
	local t = {};
	for id in pairs(worldmap)do
		tinsert(t,id);
	end
	return t;
end

function ns.ExplorationData(uiMapId)
	if exploration[uiMapId] then
		return exploration[uiMapId];
	end
end

function ns.GetExplorationMapIDs()
	local t = {};
	for id in pairs(exploration)do
		tinsert(t,id);
	end
	return t;
end

function ns.GetTaxiNodeReplacement(nodeId)
	return taxiNodes[nodeId];
end

function ns.CountTaxiNodes()
	local c=0;
	for id in pairs(taxiNodes)do
		c=c+1;
	end
	return c;
end

-----------------------------
-- WorldMap texture layers --
-----------------------------

--[[
worldmap[2213] = {{1,150,"nerubar","nerubar%d.blp"}}; -- immer noch grün
worldmap[2214] = {{1,150,"earthenworks","earthenworks%d.blp"}};
worldmap[2215] = {{1,150,"arathorcanyons","arathorcanyons%d.blp"}};
worldmap[2216] = {{1,150,"nerubar_lower","nerubar_lower%d.blp"}};
worldmap[2248] = {{1,150,"khazalgar","khazalgar%d.blp"}}; -- immer noch grün
worldmap[2249] = {{1,12,"delve_fungarian_01","delve_fungarian_01a%d.blp"}};
worldmap[2250] = {{1,12,"delve_kobolds_01","delve_kobolds_01a%d.blp"}};
worldmap[2251] = {{1,12,"delve_kobolds_02","delve_kobolds_02a%d.blp"}};
worldmap[2255] = {{1,150,"azjkahet","azjkahet%d.blp"}};
worldmap[2256] = {{1,150,"azjkahet_lower","azjkahet_lower%d.blp"}};
worldmap[2259] = {{1,12,"delve_kobyss_02","delve_kobyss_02a%d.blp"}}; -- immer noch grün
worldmap[2269] = {{1,12,"delve_earthcrawl_01","delve_earthcrawl_01a%d.blp"}};
worldmap[2270] = {{1,150,"nerubar","nerubar%d.blp"}};
worldmap[2271] = {{1,150,"khazalgar","khazalgar%d.blp"}};
worldmap[2272] = {{1,150,"earthenworks","earthenworks%d.blp"}}; -- immer noch grün
worldmap[2273] = {{1,150,"arathorcanyons","arathorcanyons%d.blp"}}; -- immer noch grün
--worldmap[2274] = {{1,150,"11_continent","11_continent%d.blp"}}; -- immer noch grün
worldmap[2276] = {{1,150,"11_continent","11_continent%d.blp"}}; -- immer noch grün
worldmap[2274] = worldmap[2276]
worldmap[2277] = {{1,12,"delve_nightfall_01","delve_nightfall_01a%d.blp"}};
worldmap[2291] = {{1,12,"nerubianpalaceraid","nerubianpalaceraid_b%d.blp"}};
worldmap[2292] = {{1,12,"nerubianpalaceraid","nerubianpalaceraid_a%d.blp"}};
worldmap[2293] = {{1,12,"nerubianpalaceraid","nerubianpalaceraid_c%d.blp"}};
worldmap[2294] = {{1,12,"nerubianpalaceraid","nerubianpalaceraid_d%d.blp"}};
worldmap[2295] = {{1,12,"nerubianpalaceraid","nerubianpalaceraid_e%d.blp"}};
worldmap[2296] = {{1,12,"nerubianpalaceraid","nerubianpalaceraid_f%d.blp"}};
worldmap[2298] = {{1,12,"nerubianpalaceraid","nerubianpalaceraid_b%d.blp"}};
worldmap[2299] = {{1,12,"delve_evolvednerubian_01","delve_evolvednerubian_01a%d.blp"}};
worldmap[2300] = {{1,12,"delve_kobyss_01","delve_kobyss_01a%d.blp"}}; -- immer noch grün
worldmap[2301] = {{1,12,"delve_kobyss_01","delve_kobyss_01a%d.blp"}};
worldmap[2302] = {{1,12,"delve_nerubian_02","delve_nerubian_02a%d.blp"}};
worldmap[2303] = {{1,12,"darkflamecleft","darkflamecleft%d.blp"}}; -- immer noch grün
worldmap[2304] = {{1,12,"darkflamecleft","darkflamecleft%d.blp"}};
worldmap[2305] = {{1,12,"dalaran_scenario","dalaran_scenario_a%d.blp"}};
worldmap[2306] = {{1,12,"dalaran_scenario","dalaran_scenario_b%d.blp"}};
worldmap[2307] = {{1,12,"dalaran_scenario","dalaran_scenario_c%d.blp"}};
worldmap[2308] = {{1,12,"sacredflame","sacredflame_a%d.blp"}};
worldmap[2309] = {{1,12,"sacredflame","sacredflame_b%d.blp"}};
worldmap[2310] = {{1,12,"delve_skitteringbreach_01","delve_skitteringbreach_01a%d.blp"}};
worldmap[2311] = {{1,150,"hallowfall_spreadinglight","hallowfall_spreadinglight%d.blp"}};
worldmap[2312] = {{1,12,"delve_myomancer_01","delve_myomancer_01a%d.blp"}};
worldmap[2314] = {{1,12,"delve_kobyss_02","delve_kobyss_02a%d.blp"}};
worldmap[2315] = {{1,12,"rookerydungeon","rookerydungeon_a%d.blp"}};
worldmap[2316] = {{1,12,"rookerydungeon","rookerydungeon_b%d.blp"}};
worldmap[2317] = {{1,12,"rookerydungeon","rookerydungeon_c%d.blp"}};
worldmap[2318] = {{1,12,"rookerydungeon","rookerydungeon_d%d.blp"}};
worldmap[2319] = {{1,12,"rookerydungeon","rookerydungeon_e%d.blp"}};
worldmap[2320] = {{1,12,"rookerydungeon","rookerydungeon_f%d.blp"}};
worldmap[2322] = {{1,12,"hallofawakening","earthenstarter%d.blp"}};
worldmap[2328] = {{1,150,"khazalgar_proscenium","khazalgar_proscenium%d.blp"}};
worldmap[2330] = {{1,12,"sacredflame","sacredflame_a%d.blp"}}; -- immer noch grün
worldmap[2335] = {{1,12,"cinderbrewmeadery","cinderbrew_meadery%d.blp"}};
worldmap[2339] = {{1,150,"dornogal","dornogal%d.blp"}};
worldmap[2341] = {{1,12,"stonevault_foundry","stonevault_foundry_a%d.blp"}};
worldmap[2344] = {{1,12,"cityofthreadsdungeon","cityofthreadsdungeon_b%d.blp"}};
worldmap[2345] = {{1,12,"earthenbatleground","earthenbattleground%d.blp"}};
worldmap[2347] = {{1,12,"delve_nerubian_04","delve_nerubian_04a%d.blp"}};
worldmap[2348] = {{1,12,"delve_zekvirslair_01","delve_zekvirslair_01_a%d.blp"}};
--]]


worldmap[2214] = {{1,150,"earthenworks","earthenworks%d.blp"}}
worldmap[2248] = {{1,150,"isleofdorn","isleofdorn%d.blp"}}
worldmap[2249] = {{1,12,"delve_fungarian_01","delve_fungarian_01a%d.blp"}}
worldmap[2250] = {{1,12,"delve_kobolds_01","delve_kobolds_01a%d.blp"}}
worldmap[2251] = {{1,12,"delve_kobolds_02","delve_kobolds_02a%d.blp"}}
worldmap[2269] = {{1,12,"delve_earthcrawl_01","delve_earthcrawl_01a%d.blp"}}
worldmap[2277] = {{1,12,"delve_nightfall_01","delve_nightfall_01a%d.blp"}}
worldmap[2291] = {{1,12,"nerubianpalaceraid","nerubianpalaceraid_b%d.blp"}}
worldmap[2292] = {{1,12,"nerubianpalaceraid","nerubianpalaceraid_a%d.blp"}}
worldmap[2293] = {{1,12,"nerubianpalaceraid","nerubianpalaceraid_c%d.blp"}}
worldmap[2294] = {{1,12,"nerubianpalaceraid","nerubianpalaceraid_d%d.blp"}}
worldmap[2295] = {{1,12,"nerubianpalaceraid","nerubianpalaceraid_e%d.blp"}}
worldmap[2296] = {{1,12,"nerubianpalaceraid","nerubianpalaceraid_f%d.blp"}}
worldmap[2299] = {{1,12,"delve_evolvednerubian_01","delve_evolvednerubian_01a%d.blp"}}
worldmap[2301] = {{1,12,"delve_kobyss_01","delve_kobyss_01a%d.blp"}}
worldmap[2302] = {{1,12,"delve_nerubian_02","delve_nerubian_02a%d.blp"}}
worldmap[2310] = {{1,12,"delve_skitteringbreach_01","delve_skitteringbreach_01a%d.blp"}}
worldmap[2311] = {{1,150,"hallowfall_spreadinglight","hallowfall_spreadinglight%d.blp"}}
worldmap[2314] = {{1,12,"delve_kobyss_02","delve_kobyss_02a%d.blp"}}
worldmap[2328] = {{1,150,"khazalgar_proscenium","khazalgar_proscenium%d.blp"}}
worldmap[2339] = {{1,150,"dornogal","dornogal%d.blp"}}
worldmap[2343] = {{1,150,"nerubardungeon","nerubardungeon_a%d.blp"}}
worldmap[2344] = {{1,12,"nerubardungeon","nerubardungeon_b%d.blp"}}
worldmap[2347] = {{1,12,"delve_nerubian_04","delve_nerubian_04a%d.blp"}}
worldmap[2348] = {{1,12,"delve_zekvirslair_01","delve_zekvirslair_01_a%d.blp"}}
worldmap[2367] = {{1,12,"vaultofmemory","vaultofmemory%d.blp"}}


--[[if LOCALE_deDE then
	ns.isGreen = {
		[2213] = 1,[2216] = 1,[2249] = 1,[2250] = 1,
		[2251] = 1,[2255] = 1,[2256] = 1,[2259] = 1,
		[2269] = 1,[2270] = 1,[2277] = 1,[2291] = 1,
		[2292] = 1,[2293] = 1,[2294] = 1,[2295] = 1,
		[2296] = 1,[2298] = 1,[2299] = 1,[2300] = 1,
		[2301] = 1,[2302] = 1,[2310] = 1,[2311] = 1,
		[2312] = 1,[2314] = 1,[2328] = 1,[2343] = 1,
		[2344] = 1,[2347] = 1,[2348] = 1,[2357] = 1,
		[2358] = 1,[2359] = 1,
	}
else]]
	ns.isGreen = {}
	for k in pairs(worldmap) do
		ns.isGreen[k]=1;
	end
--end

-- missing
-- 2343 -- khaz algar / nerub'ar / city of threads





