---@meta
---@diagnostic disable:lowercase-global
---@diagnostic disable:duplicate-set-field

platform = {}

--Returns the platform the game's xecutable is compiled for.
---@return "WIN64" | "WIN32" | "LIN64" | "LIN32" | "MACOSARM" | "MACOSX" | "UNKNOWN"
function platform.platform() end

--Returns the target triplet for the game's executable containing the CPU family, the OS name and C environment separated by dashes<br>
--Possible return values:
-- * For CPU family: https://mesonbuild.com/Reference-tables.html#cpu-families
-- * For OS name: https://mesonbuild.com/Reference-tables.html#operating-system-names
-- * For C environment:
-- > * msvc
-- > * mingw
-- > * macos
-- > * bionic
-- > * gnu
---@return string
function platform.ident() end

--Returns information about the build
---@deprecated
---@return "SSE3"|"SSE2"|"SSE"|"NO"
function platform.build() end

--Returns release type (S - Snapshot, B - Beta, R - Release)
---@return "S"|"B"|"R"
function platform.releaseType() end

--Returns path to tpt executable
---@return string
function platform.exeName() end

--Restarts the game
function platform.restart() end

--Opens link in default system browser
---@param URI string
function platform.openLink(URI) end

--"Copies" or returns text from clipboard
---@return string
function platform.clipboardCopy() end

--"Pastes" text to clipboard
---@param text string
function platform.clipboardPaste(text) end

plat = platform
