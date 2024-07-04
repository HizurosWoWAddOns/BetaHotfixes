
local addon, ns = ...;
local L,C,module = ns.L,WrapTextInColorCode;

local AC = LibStub("AceConfig-3.0");
local ACD = LibStub("AceConfigDialog-3.0");

local function AddClientInfo(order,label,key)
	return {type="description", order=order, width="normal", fontSize="medium", name = C(label,"ffeedd00")..":|n"..ns[key] .. (key=="buildVersion" and "|n"..C("("..ns.buildDate..")","ff999999") or "")};
end

local function AddOnMetadata(info)
	local key = info[#info];
	if key:match("X%-.*URL") then
		return C_AddOns.GetAddOnMetadata(addon,key);
	end
	return C(key:gsub("X%-",""),"ffffd100")..": "..C_AddOns.GetAddOnMetadata(addon,key);
end

local function opt(info,value)
	local key,key2,key3 = info[#info],info[#info-1],#info==3;
	if value~=nil then
		if key=="minimap" then
			BetaHotfixDB.minimap.hide = not value;
			ns.LDBI:Refresh(addon);
			return;
		elseif key:find("^cvar_") then
			local cvar = {strsplit("_",key)};
			SetCVar(cvar[2],cvar[3]);
			if key:find("^cvar_.*Locale_.*$") then
				ns.print(L.LanguageChanged);
			end
			return;
		elseif key3 then
			BetaHotfixDB.modules[key2][key] = value;
			ns.modules[key2].on_toggle(key,true);
			return;
		end
		BetaHotfixDB[key] = value;
	elseif key=="minimap" then
		return not BetaHotfixDB.minimap.hide;
	elseif key:find("^cvar_") then
		local cvar = {strsplit("_",key)};
		return GetCVar(cvar[2])==cvar[3];
	elseif key3 then
		return BetaHotfixDB.modules[key2][key];
	end
	return BetaHotfixDB[key];
end

local options = {
	name = addon,
	type = "group",
	get = opt, set = opt,
	childGroups = "tab",
	args = {
		info = {
			type = "description", order = 0, fontSize="medium",
			name = L.AddOnDesc
		},
		general = {
			type = "group", order = 1,
			name = GENERAL,
			args = {

				client = {
					type = "group", order = 1, inline = true,
					name = C(L.ClientInfo,"ff33bbff"),
					args = {
						version = AddClientInfo(1,GAME_VERSION_LABEL,"wowVersion"),
						build = AddClientInfo(2,"Build","buildVersion"),
						interface = AddClientInfo(3,"Interface","interfaceVersion")
					}
				},

				addon = {
					type = "group", order = 2, inline = true,
					name = C(L.AddOnInfo,"ff33bbff"),
					args = {
						["Version"] = {type="description", order=1, fontSize="medium", name=AddOnMetadata},
						["Author"] = {type="description", order=2, fontSize="medium", name=AddOnMetadata},
						["X-Info"] = {type="description", order=3, fontSize="medium", name=AddOnMetadata},
						["X-URL"] = {type="input", order=4, width="full", name=L.Homepage, get = AddOnMetadata },
						["X-GIT-URL"] = {type="input", order=5, width="full", name=L.HomepageGit, get = AddOnMetadata }
					}
				},

				minimap = {
					type = "toggle", order = 3,
					name = L.MinimapIcon
				},

				debug_mode = {
					type = "select", order = 4,
					name = L.DebugMode,
					values = {
						off = VIDEO_OPTIONS_DISABLED,
						print = L.DebugModePrint,
						console = L.DebugModeConsole
					}
				},

			}
		},
		modules = {
			type = "group", order = 2,
			name = "Hotfixes",
			--hidden = updateModules,
			childGroups = "tree",
			args = {
				info = {
					type = "description", order = 0, fontSize = "medium",
					name = L.AllHotfixesWillBeDisabled
				}
			}
		},
		misc = {
			type = "group", order = 3,
			name = CALENDAR_TYPE_OTHER,
			args = {}
		}
	}
};

function ns.Options_AddModule(modName,modData)
	local modLabel = modData.label;
	local modOptions = modData.options;
	ns.debug("?",modName,modLabel,type(modOptions.on_addoptions));
	if modOptions.hotfix then
		options.args.modules.args[modName] = { type="group", inline=true, name=C(modLabel,"ff33bbff"), args=modOptions.hotfix };
	end
	if modOptions.misc then
		options.args.misc.args[modName] = { type="group", inline=true, name=C(modLabel,"ff33bbff"), args=modOptions.misc };
	end
	if modData.on_addoptions then
		modData.on_addoptions();
	end
end

function ns.Options_Init()
	local reset = false;

	if BetaHotfixDB==nil then
		BetaHotfixDB = {modules={}};
	elseif BetaHotfixDB.modules==nil then
		BetaHotfixDB.modules = {};
	end

	if BetaHotfixDB.build~=ns.buildVersion then
		-- disabling for new build, a good time to look for changes...
		-- new build is not better? reenabling what you need... :)
		BetaHotfixDB.build=ns.buildVersion;
		reset = true;
	end

	for modName,modData in pairs(ns.modules)do
		if modData.options and modData.options.defaults then
			if BetaHotfixDB.modules[modName]==nil then
				BetaHotfixDB.modules[modName] = {};
			end
			if reset and modData.options.new_build_reset then
				local t=type(modData.options.new_build_reset)
				if t=="function" then
					modData.options.new_build_reset();
				elseif t=="table" then --?
					for i,v in ipairs(modData.options.new_build_reset)do
						BetaHotfixDB.modules[modName][v]=nil;
					end
				end
			end
			for k,v in pairs(modData.options.defaults)do
				if BetaHotfixDB.modules[modName][k]==nil then
					BetaHotfixDB.modules[modName][k]=v;
				end
			end
		end
	end

	AC:RegisterOptionsTable(addon, options);
	ACD:AddToBlizOptions(addon);

	return not reset;
end
