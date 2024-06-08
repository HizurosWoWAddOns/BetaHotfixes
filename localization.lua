
local L,addon,ns = {},...;

ns.L=setmetatable(L,{__index=function(t,k) local n = tostring(k); rawset(t,k,n); return n; end});

-- BetaHotfixes_Options.lua
L.AddOnLoaded = "AddOn loaded...";
L.AddOnDesc = "";

L.MinimapIcon = "Minimap icon";
L.ClientInfo = "Client info";
L.AddOnInfo = "AddOn info";
L.AllHotfixesWillBeDisabled = "All hotfixes will be automatically disabled for any new build version!";

L.DebugMode = "Debug mode";
L.DebugModeDesc = "";
L.DebugModePrint = "Chat window";
L.DebugModeConsole = "Console";
L.HomepageGit = "Git repository"

-- BetaHotfixes.lua
L.BuildChanged = "New build, new round... All hotfixes disabled!"

-- BetaHotfixes_DataBroker.lua
L.ShortAccessMenu = "Short access menu";
L.LeftClick = "Left click";
L.RightClick = "Right click";
L.CloseMenu = "Close menu";

-- modules/languages.lua
L.LanguageChanged = "You have changed the languages. That requires a restart of your client!"
L.LanguageLauncher = "It is recommended to change the language via the launcher.";
L.textLocaleDE = "German interface"
L.audioLocaleDE = "German sounds"
L.LangRequiredRestart = "Language changes requires a restart of the client!"

-- modules/worldmap.lua
L.GreenTexture = "Green textures fix";
L.GreenTextureDesc = "Fix the problem with missing textures on worldmap. [Green Hell Of Missing Textures]";

L.WorldMapFerryMaster = "World map - Ferry Master icons"
L.WorldMapFerryMasterDesc = "Replacing flight master icons on the world map for ferry masters. (alliance only?)"

-- modules/bugreporter.lua
L.BugReporter = "Bug Reporter"

L.BugReporterStopGlow = "Bug Reporter - Glow fix"
L.BugReporterStopGlowDesc = "Disable annoying button glow on Bug Reporter window"

L.BugReporterAlpha = "Transparency"
L.BugReporterAlphaDesc = "Adjust transparency of the Bug Reporter window"

-- modules/chatwindow.lua
L.ChatWindow = "Chat window";
L.ChatWindowUnlockFix = "Unlock chat window fix";
L.ChatWindowUnlockFixDesc = "Fix the problem to unlock undocked chat windows";

-- modules/devtools.lua
L.GreenMapDump = "Green map dump";
L.GreenMapDumpDesc = "Save importent data about current map to SavedVariables and display some parts in chat window";
L.GreenMapDumpError1 = "Only works with open world map";

-- modules/guild.lua
L.GuildWindow = "Old guild window"
L.GuildWindowDesc = "Open/Close the old guild window"

L.GuildRecruitment = "Guild - Recruitment scroll fix"
L.GuildRecruitmentDesc = "Fix update problem of the recruitment list"

if LOCALE_deDE then
	L.BuildChanged = "Neuer Build, neue Runde... Alle Hotfixes sind deaktiviert!";
	L.LanguageChanged = "Du hast die Sprache geändert. Das erfordert einen Neustart deines Spiels!"
	L.LanguageLauncher = "Es wird empfohlen, die Sprache über den Launcher zu ändern.";
	L.AllHotfixesWillBeDisabled = "Alle Hotfixes werden automatisch deaktiviert bei jeder neuen Build Version!";

	L.AddOnLoaded = "AddOn geladen...";
	L.AddOnDesc = "Dieses AddOn behebt oder umgeht einige Probleme, die von Blizzard versehendlich eingebaut wurden oder deren Beseitigung wahrscheinlich erst zum Ende der Beta vorgenommen werden.";

	L.LangRequiredRestart = "Sprachänderungen erfordern das neustarten des Spiels."
	L.textLocaleDE = "Deutsche Benutzeroberfläche"
	L.audioLocaleDE = "Deutsche Stimmen"

	--L.WorldMap
	L.WorldMapGreenTexture = "Weltkarte - Grüne Texturen fix";
	L.WorldMapGreenTextureDesc = "Behebt das Problem der fehlenden Texturen der Weltkarte. [Grüne Hölle der fehlenden Texturen]";

	L.WorldMapFerryMaster = "Weltkarte - Fährmeister Symbole"
	L.WorldMapFerryMasterDesc = "Ersetzt Flugmeistersymbole auf der Weltkarte für Fährmeister. (Nur Allianz? Fand leider keine ähnliches Taxi-System auf Hordeseite)"

	L.BugReporter = "Bug Reporter"

	L.BugReporterStopGlow = "Bug Reporter - Glühfix"
	L.BugReporterStopGlowDesc = "Deaktiviert das nervige Glühen der Buttons am Bug Reporter Fenster"

	L.BugReporterAlpha = "Transparenz"
	L.BugReporterAlphaDesc = "Ändert die Transparenz des Bug Reporter Fensters"

	L.FeedbackGlowLabel = "Bug Reporter - Glühfix";
	L.FeebackGlowDesc = "Behebet das nervive Glühen der Buttons am kleinen Bug Reporter Fenster";

	L.ChatWindow = "Chatfenster";

	L.ChatWindowUnlockFix = "Chatfenster freigeben Fix";
	L.ChatWindowUnlockFixDesc = "Behebt das Problem nicht angedockte Chatfenster wieder freigeben zu können.";

	L.GreenMapDump = "Green map dump";
	L.GreenMapDumpDesc = "Speichert die wichtigesten Daten der aktuellen Karte in SavedVariables und zeigt einen Teil auch gleich im Chatfenster an";
	L.GreenMapDumpError1 = "Geht nur mit geöffneter Weltkarte";

	L.GuildWindow = "Altes Gildenfenster"
	L.GuildWindowDesc = "Öffnet/Schließt das alte Gildenfenster"

	L.GuildRecruitment = "Gilde - Rekrutierung Scroll Fix"
	L.GuildRecruitmentDesc = "Behebet das Aktuallisierungsproblem der Rekrutierungsliste"

	L.ShortAccessMenu = "Schnellzugriffsmenü";
	L.LeftClick = "Linksklick";
	L.RightClick = "Rechtsklick";
	L.CloseMenu = "Menü schließen";

	L.DebugModePrint = "Chatfenster";
	L.DebugModeConsole = "Console";
end
