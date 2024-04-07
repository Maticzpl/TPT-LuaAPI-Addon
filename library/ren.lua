---@meta
---@diagnostic disable:lowercase-global
---@diagnostic disable:duplicate-set-field

---@alias DisplayMode
---|0 Velocity
---|1 Pressure
---|2 Persistent
---|3 Fire
---|4 Blob
---|5 Heat
---|6 Fancy
---|7 Nothing
---|8 Heat Gradient
---|9 Life Gradient
---|10 Alternate Velocity 

--TODO: Lua annotation types for stuff below maybe?

-- The renderer api can be used to control how the simulation in TPT gets rendered. You can set render / display modes, and change things related to the HUD / grid mode. Some renderer related functions are in the legacy tpt.* api.<br>
-- ren.* is an alias for renderer.* and can be used to write things shorter. 
renderer = {
    --#### These should be used in lua graphics functions to set how particles will be drawn. Effects like fire, glowing, and flares are set here. How a particle is actually rendered depends on the current render and display modes.<br>
    PMODE           = 0x00000FFF,	    --> A bitmask which can be used to check if a particle has any PMODEs set.<br>
    --#### These should be used in lua graphics functions to set how particles will be drawn. Effects like fire, glowing, and flares are set here. How a particle is actually rendered depends on the current render and display modes.<br>
    PMODE_NONE	    = 0x00000000,	    --> Don't draw a point where a particle is at all. Unused.<br>
    --#### These should be used in lua graphics functions to set how particles will be drawn. Effects like fire, glowing, and flares are set here. How a particle is actually rendered depends on the current render and display modes.<br>
    PMODE_FLAT	    = 0x00000001,	    --> Draw a basic pixel, overwriting the color under it. Given by default to everything unless overridden, Doesn't support cola.<br>
    --#### These should be used in lua graphics functions to set how particles will be drawn. Effects like fire, glowing, and flares are set here. How a particle is actually rendered depends on the current render and display modes.<br>
    PMODE_BLOB	    = 0x00000002,	    --> Draw a blob like in blob mode. Everything is given this in blob display mode, but can be set manually.<br>
    --#### These should be used in lua graphics functions to set how particles will be drawn. Effects like fire, glowing, and flares are set here. How a particle is actually rendered depends on the current render and display modes.<br>
    PMODE_BLUR	    = 0x00000004,	    --> Blur effect, used in fancy display mode. Given to all liquids without a graphics functions by default, if not this isn't set.<br>
    --#### These should be used in lua graphics functions to set how particles will be drawn. Effects like fire, glowing, and flares are set here. How a particle is actually rendered depends on the current render and display modes.<br>
    PMODE_GLOW	    = 0x00000008,	    --> Glow effect, used in elements like DEUT and TRON in fancy display mode, also given to radioactive elements.<br>
    --#### These should be used in lua graphics functions to set how particles will be drawn. Effects like fire, glowing, and flares are set here. How a particle is actually rendered depends on the current render and display modes.<br>
    PMODE_SPARK	    = 0x00000010,	    --> Draws a very light sparkle around a particle.<br>
    --#### These should be used in lua graphics functions to set how particles will be drawn. Effects like fire, glowing, and flares are set here. How a particle is actually rendered depends on the current render and display modes.<br>
    PMODE_FLARE	    = 0x00000020,	    --> Draws a flare around a particle, used by BOMB.<br>
    --#### These should be used in lua graphics functions to set how particles will be drawn. Effects like fire, glowing, and flares are set here. How a particle is actually rendered depends on the current render and display modes.<br>
    PMODE_LFLARE	= 0x00000040,	    --> Very large and bright flare, used by DEST when it hits something.<br>
    --#### These should be used in lua graphics functions to set how particles will be drawn. Effects like fire, glowing, and flares are set here. How a particle is actually rendered depends on the current render and display modes.<br>
    PMODE_ADD	    = 0x00000080,	    --> Like PMODE_FLAT, but adds color to a pixel, instead of overwriting it.<br>
    --#### These should be used in lua graphics functions to set how particles will be drawn. Effects like fire, glowing, and flares are set here. How a particle is actually rendered depends on the current render and display modes.<br>
    PMODE_BLEND	    = 0x00000100,	    --> Basically the same thing as PMODE_ADD, but has better OpenGL support<br>
    --#### These should be used in lua graphics functions to set how particles will be drawn. Effects like fire, glowing, and flares are set here. How a particle is actually rendered depends on the current render and display modes.<br>
    PSPEC_STICKMAN	= 0x00000200,	    --> Used by stickmen. Won't do anything unless the element actually is a stickman.<br>
    --#### These should be used in lua graphics functions to set how particles will be drawn. Effects like fire, glowing, and flares are set here. How a particle is actually rendered depends on the current render and display modes.<br>
    OPTIONS	        = 0x0000F000,	    --> A bitmask which can be used to check if a particle has any display options set.<br>
    --#### These should be used in lua graphics functions to set how particles will be drawn. Effects like fire, glowing, and flares are set here. How a particle is actually rendered depends on the current render and display modes.<br>
    NO_DECO	        = 0x00001000,	    --> Prevents decoration from being shown on an element.<br>
    --#### These should be used in lua graphics functions to set how particles will be drawn. Effects like fire, glowing, and flares are set here. How a particle is actually rendered depends on the current render and display modes.<br>
    DECO_FIRE	    = 0x00002000,	    --> Allows decoration to be drawn onto the fire effect. All gasses have this on by default.<br>
    --#### These should be used in lua graphics functions to set how particles will be drawn. Effects like fire, glowing, and flares are set here. How a particle is actually rendered depends on the current render and display modes.<br>
    FIREMODE	    = 0x00FF0000,	    --> A bitmask which can be used to check if a particle has any fire graphics set.<br>
    --#### These should be used in lua graphics functions to set how particles will be drawn. Effects like fire, glowing, and flares are set here. How a particle is actually rendered depends on the current render and display modes.<br>
    FIRE_ADD	    = 0x00010000,	    --> Adds a weak fire effect around an element. Does not support many colors like FIRE_BLEND does.<br>
    --#### These should be used in lua graphics functions to set how particles will be drawn. Effects like fire, glowing, and flares are set here. How a particle is actually rendered depends on the current render and display modes.<br>
    FIRE_BLEND	    = 0x00020000,	    --> Adds a strong fire effect around an element. All gasses have this on by default.<br>
    --#### These should be used in lua graphics functions to set how particles will be drawn. Effects like fire, glowing, and flares are set here. How a particle is actually rendered depends on the current render and display modes.<br>
    FIRE_SPARK 	    = 0x00040000, 	    --> Adds a moderate fire effect around an element. Used by SPRK. 
    --#### These should be used in lua graphics functions to set how particles will be drawn. Effects like fire, glowing, and flares are set here. How a particle is actually rendered depends on the current render and display modes.<br>
    EFFECT	        = 0xFF000000,	    --> A bitmask which can be used to check if a particle has any special effects set.<br>
    --#### These should be used in lua graphics functions to set how particles will be drawn. Effects like fire, glowing, and flares are set here. How a particle is actually rendered depends on the current render and display modes.<br>
    EFFECT_GRAVIN	= 0x01000000,	    --> Adds a PRTI effect. Won't work unless .life and .ctype are set properly in an update function.<br>
    --#### These should be used in lua graphics functions to set how particles will be drawn. Effects like fire, glowing, and flares are set here. How a particle is actually rendered depends on the current render and display modes.<br>
    EFFECT_GRAVOUT	= 0x02000000,	    --> Adds a PRTO effect. Won't work unless .life and .ctype are set properly in an update function.<br>
    --#### These should be used in lua graphics functions to set how particles will be drawn. Effects like fire, glowing, and flares are set here. How a particle is actually rendered depends on the current render and display modes.<br>
    EFFECT_LINES	= 0x04000000,	    --> Used by SOAP to draw lines between attached SOAP particles. Ignored by everything else.<br>
    --#### These should be used in lua graphics functions to set how particles will be drawn. Effects like fire, glowing, and flares are set here. How a particle is actually rendered depends on the current render and display modes.<br>
    EFFECT_DBGLINES	= 0x08000000,	    --> Draw lines between particles of the same type with similar temperatures. Used by WIFI and portals to draw lines between particles of the same channel when in debug mode.<br>

    --#### These are the values used and returned by ren.renderMode. They are combinations of the above values, and sometimes overlap. All source definitions also include OPTIONS and PSPEC_STICKMAN (so that options can always be set and stickmen are always rendered), but they are not listed here.<br>
    --> In source code `PMODE_SPARK | PMODE_FLARE | PMODE_LFLARE`<br>
    --> Used in all display modes except for heat, nothing, heat gradient, and life gradient. Turns on all basic effects like flares and portal effects.<br>
    RENDER_EFFE	= nil,   
    --#### These are the values used and returned by ren.renderMode. They are combinations of the above values, and sometimes overlap. All source definitions also include OPTIONS and PSPEC_STICKMAN (so that options can always be set and stickmen are always rendered), but they are not listed here.<br>
    --> In source code `PMODE_BLEND | FIREMODE`	<br>
    --> Used in fire, blob, and fancy display modes. Turns on all fire effects.<br>
    RENDER_FIRE	= 0x3f380,   
    --#### These are the values used and returned by ren.renderMode. They are combinations of the above values, and sometimes overlap. All source definitions also include OPTIONS and PSPEC_STICKMAN (so that options can always be set and stickmen are always rendered), but they are not listed here.<br>
    --> In source code `PMODE_ADD | PMODE_BLEND`	<br>
    --> Used in fancy display mode, so that radioactive elements glow.<br>
    RENDER_GLOW	= 0xf388,   
    --#### These are the values used and returned by ren.renderMode. They are combinations of the above values, and sometimes overlap. All source definitions also include OPTIONS and PSPEC_STICKMAN (so that options can always be set and stickmen are always rendered), but they are not listed here.<br>
    --> In source code `PMODE_ADD | PMODE_BLEND`	<br>
    --> Used in fancy display mode, to turn on the liquid blur effect.<br>
    RENDER_BLUR	= 0xf384,   
    --#### These are the values used and returned by ren.renderMode. They are combinations of the above values, and sometimes overlap. All source definitions also include OPTIONS and PSPEC_STICKMAN (so that options can always be set and stickmen are always rendered), but they are not listed here.<br>
    --> In source code `PMODE_ADD | PMODE_BLEND`	<br>
    --> Causes every particle to get PMODE_BLOB.<br>
    RENDER_BLOB	= 0xf382,   
    --#### These are the values used and returned by ren.renderMode. They are combinations of the above values, and sometimes overlap. All source definitions also include OPTIONS and PSPEC_STICKMAN (so that options can always be set and stickmen are always rendered), but they are not listed here.<br>
    --> In source code `PMODE_ADD | PMODE_BLEND | EFFECT_LINES`	<br>
    --> Used by every single display mode, turns on PMODE_FLAT so particles get displayed.<br>
    RENDER_BASC	= 0x400f381,   
    --#### These are the values used and returned by ren.renderMode. They are combinations of the above values, and sometimes overlap. All source definitions also include OPTIONS and PSPEC_STICKMAN (so that options can always be set and stickmen are always rendered), but they are not listed here.<br>
    --> In source code `PMODE_FLAT`	<br>
    --> Not used at all, but would make sure at least each individual pixel gets drawn.<br>
    RENDER_NONE	= 0xf201,   

    --#### These are the values used and returned by ren.displayMode. They can be set together, although no official display mode does this.<br>
    --> Cracker air display mode, used in alternate velocity display.<br>
    DISPLAY_AIRC =	0x00000001,	
    --#### These are the values used and returned by ren.displayMode. They can be set together, although no official display mode does this.<br>
    --> Used by pressure display mode.<br>
    DISPLAY_AIRP =	0x00000002,	
    --#### These are the values used and returned by ren.displayMode. They can be set together, although no official display mode does this.<br>
    --> Used by velocity display mode.<br>
    DISPLAY_AIRV =	0x00000004,	
    --#### These are the values used and returned by ren.displayMode. They can be set together, although no official display mode does this.<br>
    --> Used by heat display mode.<br>
    DISPLAY_AIRH =	0x00000008,	
    --#### These are the values used and returned by ren.displayMode. They can be set together, although no official display mode does this.<br>
    --> A bitmask which can be used to check if an air display mode is set.<br>
    DISPLAY_AIR	 =  0x0000000F,	
    --#### These are the values used and returned by ren.displayMode. They can be set together, although no official display mode does this.<br>
    --> Used by fancy display mode, turns on gravity lensing, causing newtonian gravity areas to bend light.<br>
    DISPLAY_WARP =	0x00000010,	
    --#### These are the values used and returned by ren.displayMode. They can be set together, although no official display mode does this.<br>
    --> Used by persistent display mode.<br>
    DISPLAY_PERS =	0x00000020,	
    --#### These are the values used and returned by ren.displayMode. They can be set together, although no official display mode does this.<br>
    --> Doesn't do anything at all, unless maybe OpenGL is on. Unclear what it does even then.<br>
    DISPLAY_EFFE =	0x00000040,	

    --#### These are the values used and returned by ren.colorMode. Only one can be set at a time, and they control which types of colors particles are drawn in.<br>
    --> Default colors, nothing gets changed.<br>
    COLOUR_DEFAULT = nil,	    
    --#### These are the values used and returned by ren.colorMode. Only one can be set at a time, and they control which types of colors particles are drawn in.<br>
    --> Render elements in heat display colors. Pink = hottest, Blue = coldest.<br>
    COLOUR_HEAT = nil,	        
    --#### These are the values used and returned by ren.colorMode. Only one can be set at a time, and they control which types of colors particles are drawn in.<br>
    --> Render elements in a greyscale gradient dependent on .life value.<br>
    COLOUR_LIFE = nil,	  
    --#### These are the values used and returned by ren.colorMode. Only one can be set at a time, and they control which types of colors particles are drawn in.<br>
    --> Render elements normally, but with a slight greyscale gradient dependent on a particle's temperature.<br>
    COLOUR_GRAD = nil,	
    --#### These are the values used and returned by ren.colorMode. Only one can be set at a time, and they control which types of colors particles are drawn in.<br>
    --> Remove all color changes from elements, elements get rendered in whichever color their element button is.<br>
    COLOUR_BASC = nil,	        
}


--```
--table ren.renderModes()
--ren.renderModes(table newModes)
--```
--If called with no arguments, returns a table containing the currently activated render modes. If called with a table argument, turns on all the render modes specified in the table. Render modes are typically used to change the way all particles render, display modes set extra added effects.<br>
--Print out all current render modes in hex:<br>
--```
--for k,v in pairs(ren.renderModes()) do
--	print(k,"0x"..bit.tohex(v))
--end
-->>1, 0x00fff380; 2, 0xff00f270; 3, 0x0400f381
--```
--Set the current render mode to a weird form of blob display<br>
--```
--ren.renderModes({ren.RENDER_BLOB, ren.RENDER_EFFE})
--```
---@param newModes integer[]  
function renderer.renderModes(newModes)
end
---@return integer[]
function renderer.renderModes()
end


--```
--table ren.displayModes()
--ren.displayModes(table newModes)
--```
--Works exactly like rennder.renderModes(). If called with no arguments, returns a table containing the currently activated display modes. If called with a table argument, turns on all the display modes specified in the table. Render modes are typically used to change the way all particles render, display modes set extra added effects.<br>
--Print out all current display modes in hex:<br>
--```
--for k,v in pairs(ren.displayModes()) do
--	print(k,"0x"..bit.tohex(v))
--end
-->>1, 0x00000002; 2, 0x00000010
--```
--Set the current display mode to persistent with cracker velocity display<br>
--```
--ren.displayModes({ren.DISPLAY_AIRC, ren.DISPLAY_PERS})
--```
---@param newModes integer[]  
function renderer.displayModes(newModes)
end
---@return integer[]
function renderer.displayModes()
end

--```
--number ren.colorMode
--ren.colorMode(number colourMode)
--```
--This function takes one optional integer and sets which colour modes the currently appIying render mode uses. If the function is called with no arguments, it returns the current colour mode as an integer as well.<br>
--A colour mode is basically a description of how particles are drawn. The other details which are considered when particles are drawn are fire mode, pixel mode and effect mode (rare cases like portals).<br>
---@return integer
function renderer.colorMode() 
end
---@param colorMode integer  
function renderer.colorMode(colorMode) 
end
--```
--number ren.colourMode()
--ren.colourMode(number colourMode)
--```
--This function takes one optional integer and sets which colour modes the currently appIying render mode uses. If the function is called with no arguments, it returns the current colour mode as an integer as well.<br>
--A colour mode is basically a description of how particles are drawn. The other details which are considered when particles are drawn are fire mode, pixel mode and effect mode (rare cases like portals).<br>
--### **REPLACED BY `ren.colorMode`**
---@deprecated
---@return integer
function renderer.colourMode() 
end
--### **REPLACED BY `ren.colorMode`**
---@deprecated
---@param colourMode integer  
function renderer.colourMode(colourMode) 
end

--```
--number ren.grid()
--ren.grid(number gridSize)
--```
--If called with no arguments, returns the current grid size (normally set with 'g'). Grid sizes range from 0 (no grid) to 9. Each size increases the number of pixels between lines by 4.<br>
--If an argument is passed in, sets the current grid size. There are no checks to make sure it is in the valid range, but if negative numbers are passed in it may cause strange behavior.<br>
---@param gridSize integer  
function renderer.grid(gridSize)
end
---@return integer
function renderer.grid()
end

--```
--renderer.hud(enabled)
--```
--Controls if the hud is shown or not.<br>
--  - `enabled`: boolean flag that specifies if the HUD is enabled or not.
---@param enabled boolean
function renderer.hud(enabled)
end
--```
--enabled = renderer.hud()
--```
--Controls if the hud is shown or not.<br>
--  - `enabled`: boolean flag that specifies if the HUD is enabled or not.
---@return boolean
function renderer.hud()
end

--```
--renderer.decorations(enabled)
--```
--Controls whether the decorations layer is enabled.<br> 
--  - `enabled`: boolean true/false flag that specifies whether deco is on or off.
---@param enabled boolean
function renderer.decorations(enabled)
end
--```
--enabled = renderer.decorations()
--```
--Controls whether the decorations layer is enabled.<br> 
--  - `enabled`: boolean true/false flag that specifies whether deco is on or off.
---@return boolean
function renderer.decorations()
end

--```
--renderer.fireSize(size)
--```
--Controls intensity of fire effects. The default is 1. Other values may cause glitchy graphics such as CELL borders appearing in fire effects.<br> 
--  - `size`: floating point value that specifies the fire intensity.
---@param size number
function renderer.fireSize(size)
end
--```
--size = renderer.fireSize()
--```
--Controls intensity of fire effects. The default is 1. Other values may cause glitchy graphics such as CELL borders appearing in fire effects.<br> 
--  - `size`: floating point value that specifies the fire intensity.
---@return number
function renderer.fireSize()
end

--```
--renderer.useDisplayPreset(preset)
--```
--Loads a standard display preset, as if you pressed a number key.<br>
--  - `preset`: The preset to enable.<br>
--Presets start at 0, so preset 0 is velocity display, and preset 3 is fire display. Most presets match the order of the in-game shortcuts, except for life gradient display - preset 9, and alternate velocity display - preset 10. 
---@param preset DisplayMode
function renderer.useDisplayPreset(preset)
end

--```
--number ren.debugHUD()
--ren.debugHUD(number debugSetting)
--```
--If called with no arguments, returns a 0 or a 1 representing whether the debug HUD (normally set with 'd') is on or off. If a number is passed in, turns the debug HUD on or off.<br>
--### **REPLACED BY `ren.debugHud`**
---@deprecated
---@param debugSetting integer  
function renderer.debugHUD(debugSetting)
end
--### **REPLACED BY `ren.debugHud`**
---@deprecated
---@return integer
function renderer.debugHUD()
end

--```
--number ren.debugHud()
--ren.debugHud(number debugSetting)
--```
--If called with no arguments, returns a 0 or a 1 representing whether the debug HUD (normally set with 'd') is on or off. If a number is passed in, turns the debug HUD on or off.<br>
---@param debugSetting integer  
function renderer.debugHud(debugSetting)
end
---@return integer
function renderer.debugHud()
end

--```
--number ren.showBrush()
--ren.showBrush(number brushSetting)
--```
--If called with no arguments, returns a 0 or a 1 representing whether the brush is currently shown. If a number is passed in, disables rendering the brush. This function is intended for recording scripts which want to hide the brush and other hud elements.<br>
--
---@param brushSetting integer  
function renderer.showBrush(brushSetting)
end
---@return integer
function renderer.showBrush()
end

--Not documented by the wiki. See this link in case it has been already added<br>
--https://powdertoy.co.uk/Wiki/W/Lua_API:Renderer.html#renderer.depth3d<br>
function renderer.depth3d(...) end

--```
--ren.zoomEnabled(boolean zoomState)
--boolean ren.zoomEnabled()
--```
--If called with no arguments, returns a boolean indicating whether the zoom window is open or not. If a number is passed in, it shows or hides the zoom window<br>
---@param zoomState boolean  
function renderer.zoomEnabled(zoomState)
end
---@return boolean
function renderer.zoomEnabled()
end

--```
--number, number, number, number ren.zoomWindow()
--ren.zoomWindow(number x, number y, number zoomFactor)
--```
--The zoom window displays the magnified image. If called with no arguments, returns 4 numbers: left top corner X position, left top corner Y position, the zoom factor and the inner window size in pixels. If arguments are passed then the zoom window will be moved to the specified X and Y coordinates (from its top left corner) and change its zoom factor.<br>
---@param x integer  
---@param y integer  
---@param zoomFactor integer  
function renderer.zoomWindow(x, y, zoomFactor) 
end
---@return integer x, integer y, integer zoomFactor, number windowSize
function renderer.zoomWindow() 
end

--```
--number, number, number ren.zoomScope()
--ren.zoomScope(number x, number y, number size)
--```
--The zoom scope defines the area where to zoom in. If called with no arguments, returns 3 numbers: left top corner X position, left top corner Y position and its size. If arguments are passed then the zoom scope will be moved to the specified X and Y coordinates (from its top left corner). It will also make it span the amount of pixels specified by the 'size' argument equally in width and height.<br>
---@return integer x, integer y, integer size
function renderer.zoomScope() 
end
---@param x integer  
---@param y integer  
---@param size integer  
function renderer.zoomScope(x, y, size) 
end

ren = renderer
