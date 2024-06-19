
local addon, ns = ...;
local L,C,module = ns.L,WrapTextInColorCode;
if ns.interfaceVersion<90000 then return end

local modName,modLabel = "languages", LANGUAGE

module = {
	label = modLabel,

	options = {
		misc = {
			info_restart = {
				type = "description", order = 1, fontSize = "medium",
				name = C(L.LangRequiredRestart,"ffff4444")
			},
			info_launcher = {
				type = "description", order = 2, fontSize = "medium",
				name = C(L.LanguageLauncher,"ffeedd00")
			},
			cvar_textLocale_deDE = {
				type = "toggle", order = 3, width = "full",
				name = L.textLocaleDE
			},
			cvar_audioLocale_deDE = {
				type = "toggle", order = 4, width = "full",
				name = L.audioLocaleDE
			}
		}
	}
}

ns.modules[modName] = module;
