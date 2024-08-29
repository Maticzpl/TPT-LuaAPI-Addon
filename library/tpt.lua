---@meta
---@diagnostic disable:lowercase-global
---@diagnostic disable:duplicate-set-field

---@alias WallType
---|0 WL_ERASE	
---|1 WL_WALLELEC	
---|2 WL_EWALL	
---|3 WL_DETECT	
---|4 WL_STREAM	
---|5 WL_FAN		
---|6 WL_ALLOWLIQUID
---|7 WL_DESTROYALL
---|8 WL_WALL		
---|9 WL_ALLOWAIR	
---|10 WL_ALLOWPOWDER
---|11 WL_ALLOWALLELEC
---|12 WL_EHOLE	
---|13 WL_ALLOWGAS	
---|14 WL_GRAV		
---|15 WL_ALLOWENERGY
---|16 WL_BLOCKAIR	
---|17 WL_ERASEALL	
---|18 WL_STASIS	

---@alias ElemFuncReplace
---|1 Call after original
---|2 Overwrite original
---|3 Call before original

-- *This page describes an old version of TPT's Lua API, most of which is unsuitable for new scripts. For the new API, see[ Powder Toy Lua API](https://powdertoy.co.uk/Wiki/W/Powder_Toy_Lua_API.html).*<br>
-- You may open the Lua Console by hitting the [`] key. (Also known as the tilde [~] key, or the [¬] key) [click here to view key](http://www.bittbox.com/wp-content/uploads/2007/12/tilde_illustrator_1.jpg)<br>
-- You may be used to this style of console commands: !set type dust metl. This can be useful, but Lua is an entire programming language that can do much more powerful things. The equivalent command in TPT's Lua is `tpt.set_property("type", "metl", "dust")` (see [Lua#tpt.set_property](https://powdertoy.co.uk/Wiki/W/Lua.html#tpt.set_property) )<br>
-- This page describes the TPT Lua API, not the Lua language itself. But, you may research Lua on your own. If you're a beginner, look at this: [http://www.lua.org/pil/](http://www.lua.org/pil/) . If more advanced, a list of all the functions is here: [http://www.lua.org/manual/5.1/](http://www.lua.org/manual/5.1/)<br>
-- Also, FeynmanTechnologies has written a tutorial on some of the most basic Lua features here: [https://powdertoy.co.uk/Discussions/Thread/View.html?Thread=17801](https://powdertoy.co.uk/Discussions/Thread/View.html?Thread=17801)<br>
-- The Lua Console provides the ability to create scripts using Lua, a very simple scripting language. With the ability to script with Lua, users are now able to create simple modifications to the game without editing source code. For information on how to run scripts, see [Running Lua Scripts](https://powdertoy.co.uk/Wiki/W/Running_Lua_Scripts.html) <br>
tpt = {}

--Draw text to the screen (for one frame, only useful in scripts)<br>
--### **REPLACED BY `gfx.drawText`**
---@param x integer  
---@param y integer  
---@param text string  
---@deprecated
function tpt.drawtext(x, y, text)
end
---@param x integer  
---@param y integer  
---@param text string  
---@param red   integer  
---@param green integer  
---@param blue  integer  
---@param alpha integer?
---@deprecated
function tpt.drawtext(x, y, text, red, green, blue, alpha)
end

--Create a particle at location.<br>
--```
--tpt.create(number x, number y, string type)
--```
--Returns the index of the newly created particle.<br>
--### **REPLACED BY `sim.partCreate`**
---@param x integer  
---@param y integer  
---@param type string  
---@return integer
---@deprecated
function tpt.create(x, y, type)
end

--Sets the paused state of the game.<br>
--The number argument is either 0 or 1, where 1 means the game will be paused, and 0 will unpause the game. If you don't pass in any arguments, the command will return an integer, either 0 or 1, about whether the game is currently paused.<br>
--**Examples:**<br>
-- - Pause the game:<br>
--```
--tpt.set_pause(1)
--```
-- - Get if the game is paused currently:<br>
--```
--tpt.set_pause() == 1
--```
--### **REPLACED BY `sim.paused`**
---@deprecated
---@param state integer  
function tpt.set_pause(state)
end
---@deprecated
---@return integer
function tpt.set_pause()
end

--Toggles pause.<br>
--Returns 1 if paused after execution and 0 otherwise<br>
--### **REPLACED BY `sim.paused`**
---@deprecated
---@return integer
function tpt.toggle_pause()
end

--Set the visibility state of the console.<br>
--The number argument can be either 0 or 1, where 1 means the console will be opened, and 0 will close the console. If you don't pass in any arguments, the command will return an integer, either 0 or 1, about whether the console is currently opened.<br>
--**Examples:**<br>
-- - Open the console:<br>
--```
--tpt.set_console(1)
--```
-- - Get if the console is currently open:<br>
--```
--tpt.set_console() == 1
--```
--### **REPLACED BY `interface.console`**
---@deprecated
---@param state integer  
function tpt.set_console(state)
end
--### **REPLACED BY `interface.console`**
---@deprecated
---@return integer
function tpt.set_console()
end


--Log a message to the console<br>
function tpt.log(...)
end

--Sets or resets pressure in the pressure map to some pressure. I sometimes imagine how much I can repeat the word "pressure" inside a sentence before it becomes gibberish.<br>
--Default values:<br>
--x = 0<br>
--y = 0<br>
--width = XRES/CELL = 612 / 4 = 153<br>
--height= YRES/CELL = 384 / 4 = 96<br>
--value = 0<br>
--
--**Examples:**<br>
-- - Reset pressure everywhere:<br>
--```
--tpt.set_pressure()
--```
-- - Set pressure at (100,100) (for a 1x1 rectangle to only use one wallpixel) to 200:<br>
--```
--tpt.set_pressure(100,100,1,1,200)
--```
-- - Set pressure everywhere to 200:<br>
--```
--tpt.set_pressure(nil,nil,nil,nil,200)
--```
--### **REPLACED BY `sim.pressure`**
---@deprecated
---@param x integer  
---@param y integer  
---@param width integer  
---@param height integer  
---@param value number  
function tpt.set_pressure(x, y, width, height, value)
end
---@deprecated
function tpt.set_pressure()
end

--Sets Newtonian Gravity at a position or area to some value.<br>
--Default values:<br>
--x = 0<br>
--y = 0<br>
--width = XRES/CELL = 612 / 4 = 153<br>
--height = YRES/CELL = 384 / 4 = 96<br>
--value = 0<br>
--
--**Examples:**<br>
-- - Reset gravity at point (150, 150):<br>
--```
--tpt.set_gravity(150, 150)
--```
-- - Reset gravity from (100,100) to (300,300):<br>
--```
--tpt.set_gravity(100, 100, 200, 200)
--```
-- - Set the entire stage's gravity to 1000:<br>
--```
--tpt.set_gravity(nil, nil, nil, nil, 1000)
--```
--### **REPLACED BY `sim.gravityMass`, `sim.gravityField`**
---@deprecated
---@param x integer  
---@param y integer  
---@param width integer  
---@param height integer  
---@param value number?
function tpt.set_gravity(x, y, width, height, value)
end
---@deprecated
---@param x integer  
---@param y integer  
function tpt.set_gravity(x, y)
end

--TODO: are reset functions with area args deprecated???

--Thoroughly resets Newtonian gravity on a given point.<br>
--Instead of tpt.set_gravity which only modifies `sim->gravmap`, this code modifies `sim->gravp`, `sim->gravx` and `sim->gravy`.<br>
--Mmm, gravy.<br>
--Default values:<br>
--x = 0<br>
--y = 0<br>
--width = XRES/CELL = 612 / 4 = 153<br>
--height = YRES/CELL = 384 / 4 = 96<br>
--**Examples:**<br>
-- - Thoroughly reset gravity at point (150, 150):<br>
--```
--tpt.reset_gravity_field(150, 150)
--```
-- - Reset gravity from (100,100) to (300,300):<br>
--```
--tpt.reset_gravity_field(100, 100, 200, 200)
--```
--### **REPLACED BY `sim.resetGravityField`**
---@deprecated
---@param x integer  
---@param y integer  
---@param width integer  
---@param height integer  
function tpt.reset_gravity_field(x, y, width, height)
end
--### **REPLACED BY `sim.resetGravityField`**
---@deprecated
---@param x integer  
---@param y integer  
function tpt.reset_gravity_field(x, y)
end

--Sets velocity (both x and y) in a given region or point to 0.<br>
--Default values:<br>
--x = 0<br>
--y = 0<br>
--width = XRES/CELL = 612 / 4 = 153<br>
--height = YRES/CELL = 384 / 4 = 96<br>
--**Examples:**<br>
-- - Reset velocity everywhere:<br>
--```
--tpt.reset_velocity()
--```
-- - Reset velocity in the point (100,100):<br>
--```
--tpt.reset_velocity(100,100,1,1)
--```
--### **REPLACED BY `sim.resetVelocity`**
---@deprecated
---@param x integer  
---@param y integer  
---@param width integer  
---@param height integer  
function tpt.reset_velocity(x, y, width, height)
end
--### **REPLACED BY `sim.resetVelocity`**
---@deprecated
function tpt.reset_velocity()
end

--Removes electrified wires from the simulation, resetting to the original material<br>
--### **REPLACED BY `sim.resetSpark`**
---@deprecated
function tpt.reset_spark() end


--Sets various properties of particles for given criteria<br>
--### **REPLACED BY `sim.partProperty`**
---@deprecated
---@param property string  
---@param value any  
function tpt.set_property(property, value)
end
--### **REPLACED BY `sim.partProperty`**
---@deprecated
---@param property string  
---@param value any  
---@param type string  
function tpt.set_property(property, value, type)
end
--### **REPLACED BY `sim.partProperty`**
---@deprecated
---@param property string  
---@param value any  
---@param index number  
function tpt.set_property(property, value, index)
end
--### **REPLACED BY `sim.partProperty`**
---@deprecated
---@param property string  
---@param value any  
---@param index number  
---@param type string  
function tpt.set_property(property, value, index, type)
end
--### **REPLACED BY `sim.partProperty`**
---@deprecated
---@param property string  
---@param value any  
---@param x number  
---@param y number  
function tpt.set_property(property, value, x, y)
end
--### **REPLACED BY `sim.partProperty`**
---@deprecated
---@param property string  
---@param value any  
---@param x number  
---@param y number  
---@param type string  
function tpt.set_property(property, value, x, y, type)
end
--### **REPLACED BY `sim.partProperty`**
---@deprecated
---@param property string  
---@param value any  
---@param x number  
---@param y number  
---@param width number  
---@param height number  
function tpt.set_property(property, value, x, y, width, height)
end
--### **REPLACED BY `sim.partProperty`**
---@deprecated
---@param property string  
---@param value any  
---@param x number  
---@param y number  
---@param width number  
---@param height number  
---@param type string  
function tpt.set_property(property, value, x, y, width, height, type)
end

--### **REPLACED BY `sim.partProperty`**
---@deprecated
---@param property string  
---@param index integer  
function tpt.get_property(property, index)
end
--### **REPLACED BY `sim.partProperty`**
---@deprecated
---@param property string  
---@param x integer  
---@param y integer  
function tpt.get_property(property, x, y)
end

--Sets the wall at a position. Uses wall/air map coordinates. Divide the actual coordinate by 4 to get the wall coordinate. So to set the wall at (100, 200), pass 100/4 for x and 200/4 for y.<br>
--### **REPLACED BY `sim.wallMap`**
---@deprecated
---@param x integer  
---@param y integer  
---@param walltype WallType|integer  
function tpt.set_wallmap(x, y, walltype)
end
---@deprecated
---@param x integer  
---@param y integer  
---@param width integer  
---@param height integer  
---@param walltype WallType|integer    
function tpt.set_wallmap(x, y, width, height, walltype)
end
---@deprecated
---@param x integer  
---@param y integer  
---@param width integer  
---@param height integer  
---@param fanVelocityX number  
---@param fanVelocityY number  
---@param walltype WallType|integer    
function tpt.set_wallmap(x, y, width, height, walltype, fanVelocityX, fanVelocityY)
end

--Gets the wall at a position. Uses wall/air map coordinates. Divide the actual coordinate by 4 to get the wall coordinate. So to set the wall at (100, 200), pass 100/4 for x and 200/4 for y.<br>
--### **REPLACED BY `sim.wallMap`**
---@deprecated
---@param x integer  
---@param y integer  
---@return integer
function tpt.get_wallmap(x,y) end

--Sets the "electricity" flag for a wall at a position. This flag is usually set when walls are sparked. The value is decremented by 1 every frame, just like SPRK .life, and when it reaches 0 the wall is "unsparked". Uses wall/air map coordinates. Divide the actual coordinate by 4 to get the wall coordinate. So to set the wall at (100, 200), pass 100/4 for x and 200/4 for y.<br>
--### **REPLACED BY `sim.elecMap`**
---@deprecated
---@param x integer  
---@param y integer  
---@param walltype WallType|integer  
function tpt.set_elecmap(x, y, walltype)
end
---@deprecated
---@param x integer  
---@param y integer  
---@param width integer  
---@param height integer  
---@param walltype WallType|integer    
function tpt.set_elecmap(x, y, width, height, walltype)
end

--Gets the "electricity" flag for a wall at a position. This flag is usually set when walls are sparked. Uses wall/air map coordinates. Divide the actual coordinate by 4 to get the wall coordinate. So to set the wall at (100, 200), pass 100/4 for x and 200/4 for y.<br>
--### **REPLACED BY `sim.elecMap`**
---@deprecated
---@param x integer  
---@param y integer  
function tpt.get_elecmap(x, y)
end

--Draws a pixel on the screen (for one frame, only useful in scripts)<br>
--### **REPLACED BY `gfx.drawPixel`**
---@deprecated
---@param x integer  
---@param y integer  
function tpt.drawpixel(x, y)
end
---@deprecated
---@param x integer  
---@param y integer  
---@param red integer  
---@param green integer  
---@param blue integer  
---@param alpha integer?  
function tpt.drawpixel(x, y, red, green, blue, alpha)
end

--Draws a rectangle on the screen (for one frame, only useful in scripts)<br>
--### **REPLACED BY `gfx.drawRect`**
---@param x integer  
---@param y integer  
---@param width integer  
---@param height integer  
---@deprecated
function tpt.drawrect(x, y, width, height)
end
---@param x integer  
---@param y integer  
---@param width integer  
---@param height integer  
---@param red integer  
---@param green integer  
---@param blue integer  
---@deprecated
function tpt.drawrect(x, y, width, height, red, green, blue)
end
---@param x integer  
---@param y integer  
---@param width integer  
---@param height integer  
---@param red integer  
---@param green integer  
---@param blue integer  
---@param alpha integer  
---@deprecated
function tpt.drawrect(x, y, width, height, red, green, blue, alpha)
end

--Draws a filled in rectangle on the screen (for one frame, only useful in scripts)<br>
--Because tpt.fillrect is slightly broken in tpt, the coordinates will be off. It fills the rectangle from (x+1, y+1) to (x+w-1, y+h-1)<br>
--### **REPLACED BY `gfx.fillRect`**
---@param x integer  
---@param y integer  
---@param width integer  
---@param height integer  
---@deprecated
function tpt.fillrect(x, y, width, height)
end
---@param x integer  
---@param y integer  
---@param width integer  
---@param height integer  
---@param red integer  
---@param green integer  
---@param blue integer  
---@param alpha integer?
---@deprecated
function tpt.fillrect(x, y, width, height, red, green, blue, alpha)
end

--Draws a line on the screen (for one frame, only useful in scripts). The line starts at point (x1, y1) and ends at point (x2,y2).<br>
--### **REPLACED BY `gfx.drawLine`**
---@param x1 number  
---@param y1 number  
---@param x2 number  
---@param y2 number  
---@deprecated
function tpt.drawline(x1, y1, x2, y2)
end
---@param x1 number  
---@param y1 number  
---@param x2 number  
---@param y2 number  
---@param red integer  
---@param green integer  
---@param blue integer  
---@param alpha integer?  
---@deprecated
function tpt.drawline(x1, y1, x2, y2, red, green, blue, alpha)
end

--Measures (in pixels) the width of a given string. Returns a number.<br>
--### **REPLACED BY `gfx.textSize`**
---@param text string  
---@return integer
---@deprecated
function tpt.textwidth(text)
end

--Returns the current username.<br>
---@return string
function tpt.getUserName() 
end

--Returns the current username.<br>
--### **REPLACED BY ``**
---@deprecated
---@return string
function tpt.get_name() 
end

--Delete a specific particle, or a particle at a location.<br>
--### **REPLACED BY `sim.partKill`**
---@param index integer  
---@deprecated
function tpt.delete(index)
end
---@param x integer  
---@param y integer  
---@deprecated
function tpt.delete(x, y)
end

--Ask the user to input some text. Returns a string of what ever the user says. The argument "text" is pre-entered text (optional).<br>
--### **REPLACED BY `ui.beginInput`**
---@deprecated
---@param title string?  
---@param message string?  
---@param text string?  
---@return string
function tpt.input(title, message, text)
end

--Display an OK-Only message box with a title and message.<br>
--### **REPLACED BY `ui.beginMessageBox`**
---@deprecated
---@param title string?  
---@param message string?  
function tpt.message_box(title, message)
end

--Display an confirm message box with a title and message. Returns true if the button with button_name is clicked, returns false if Cancel is clicked.<br>
--### **REPLACED BY `ui.beginConfirm`**
---@deprecated
---@param title string?  
---@param message string?  
---@param button_name string?  
---@return boolean
function tpt.confirm(title, message,button_name)
end

--Returns the number of particles currently on the screen.<br>
--### **REPLACED BY `sim.NUM_PARTS`**
---@deprecated
---@return integer
function tpt.get_numOfParts() 
end

--Start the iterator for receiving all indices of the particles. (Used to help get particle indices, see tpt.next_getPartIndex)<br>
--### **REPLACED BY `sim.parts`**
---@deprecated
function tpt.start_getPartIndex() end

--Jump to the next available particle index. Returns false if the iterator has reached the end of all particle indecies. Returns true if a new index was available. (Used to help get particle indecies, see tpt.getPartIndex)<br>
--### **REPLACED BY `sim.parts`**
---@return boolean
---@deprecated
function tpt.next_getPartIndex()         
end

--Get the current index iterator.<br>
--Index code example:<br>
--```
--	 tpt.start_getPartIndex()
--	 while tpt.next_getPartIndex() do
--	    local index = tpt.getPartIndex()
--	    if tpt.get_property("ctype",index) == 21 then
--	       tpt.set_property("ctype","sing",index)
--	    end
--	 end
--```
--These functions are made obsolete by the function sim.parts(). That allows you to use Lua's iterators.<br>
--### **REPLACED BY `sim.parts`**
---@return integer
---@deprecated
function tpt.getPartIndex() end

--Set HUD visibility.<br>
--Does the same thing as pressing the H key normally. The number argument can be either 0 or 1, where 1 will show the HUD, and 0 will hide the HUD. If you don't pass in any arguments, the command will return an integer, either 0 or 1, about whether the HUD is visible right now.<br>
--### **REPLACED BY `ren.hud()`**
---@deprecated
---@param state integer  
function tpt.hud(state) end
---@deprecated
---@return integer
function tpt.hud() end

--Sets Newtonian Gravity on and off.<br>
--Does the same thing as Ctrl+N in normal gameplay.<br>
--The number argument can be either 0 or 1, where 1 will enable Newtonian Gravity, and 0 will disable Newtonian Gravity. If you don't pass in any arguments, the command will return an integer, either 0 or 1, about whether Newtonian Gravity is turned on at the given moment.<br>
--### **REPLACED BY `sim.newtonianGravity`**
---@deprecated
---@param state integer  
function tpt.newtonian_gravity(state) end
---@deprecated
---@return integer
function tpt.newtonian_gravity() end

--Toggles Ambient Heat state.<br>
--The number argument can be either 0 or 1, where 1 will enable Ambient Heat, 0 will disable it. If you don't pass in any arguments, the command will return an integer, either 0 or 1, about whether Ambient Heat is turned on at the given moment.<br>
--### **REPLACED BY `sim.ambientHeatSim`**
---@deprecated
---@param state integer  
function tpt.ambient_heat(state) end
---@deprecated
---@return integer
function tpt.ambient_heat() end

--Changes activated menu. If you don't pass in any arguments, the command will return the currently active menu.<br>
--The menu IDs are detailed here: https://powdertoy.co.uk/Wiki/W/Element_Properties.html#Menu_sections<br>
--**Example:**<br>
--```
--tpt.active_menu(elem.SC_EXPLOSIVE)
--```
--### **REPLACED BY `ui.activeMenu`**
---@deprecated
---@param menu integer  
function tpt.active_menu(menu) end
---@deprecated
---@return integer
function tpt.active_menu() end

--```
--boolean tpt.menu_enabled(number menuID)
--```
--Returns true if a menu section is enabled.<br>
--### **REPLACED BY `ui.menuEnabled`**
---@deprecated
---@param menuID integer  
---@return boolean
function tpt.menu_enabled(menuID) end
--```
--tpt.menu_enabled(number menuID, boolean enabled)
--```
--If provided a boolean, will set if a menu section is enabled.<br>
--### **REPLACED BY `ui.menuEnabled`**
---@deprecated
---@param menuID integer  
---@param enabled boolean  
function tpt.menu_enabled(menuID, enabled) end


--```
--number tpt.num_menus()
--```
--Returns the number of menus.<br>
--The optional onlyEnabled boolean is true by default.<br>
--### **REPLACED BY `ui.numMenus`**
---@deprecated
---@return integer
function tpt.num_menus() end
--```
--number tpt.num_menus(boolean onlyEnabled)
--```
--### **REPLACED BY `ui.numMenus`**
---@deprecated
---@param onlyEnabled boolean  
---@return integer
function tpt.num_menus(onlyEnabled) end

--Toggle drawing decorations.<br>
--The number argument can be either 0 or 1, where 1 will enable decorations, and 0 will disable them. If you don't pass in any arguments, the command will return an integer, either 0 or 1, about whether decorations are turned on at the given moment.<br>
--### **REPLACED BY `ren.decorations`**
---@param state integer  
---@deprecated
function tpt.decorations_enable(state)
end
---@return integer
---@deprecated
function tpt.decorations_enable() end


--Changes activated display mode.<br>
--There's 11 display modes, detailed here https://github.com/ThePowderToy/The-Powder-Toy/blob/f54189a97f6d80181deb4f6d952ccf10f0e59ccf/src/graphics/Renderer.cpp#L2587-L2644<br>
--Note that the order of display modes is shifted by 1 making velocity mode first and alternative velocity last.
-- ---
--**Display Modes:**<br>
-- - 0 = Velocity
-- - 1 = Pressure
-- - 2 = Persistent
-- - 3 = Fire
-- - 4 = Blob
-- - 5 = Heat
-- - 6 = Fancy
-- - 7 = Nothing
-- - 8 = Heat Gradient
-- - 9 = Life Gradient
-- - 10 = Alternate Velocity
--### **REPLACED BY `ren.useDisplayPreset()`**
---@deprecated
---@param display DisplayMode  
function tpt.display_mode(display)
end

--Displays an error message box.<br>
--### **REPLACED BY `ui.beginThrowError()`**
---@deprecated
---@param text string  
function tpt.throw_error(text)
end

--Toggles Heat Simulation.<br>
--The number argument can be either 0 or 1, where 1 will enable heat, and 0 will disable it. If you don't pass in any arguments, the command will return an integer, either 0 or 1, about whether heat is turned on at the given moment.<br>
--It's usually wise not to disable this, as there are practically no saves left that need the compatibility mode in order to work. Nevertheless this option exists.<br>
--### **REPLACED BY `sim.heatSim`**
---@deprecated
---@param state integer  
function tpt.heat(state)
end
---@deprecated
---@return integer
function tpt.heat() end

--Changes the strength of the games glowing effects. `tpt.setfire(1)` is default.<br>
--### **REPLACED BY `ren.fireSize()`**
---@deprecated
---@param strength number  
function tpt.setfire(strength)  
end

--Sets the "debug mode". It works using bitmasks, so you can turn on multiple debug features at the same time.<br>
--Setting 0x1 will display info on the number of particles on the screen.<br>
--Setting 0x2 will draw a graph showing the percentages of each type of element on the screen.<br>
--Setting 0x4 will display useful information when you draw lines using shift.<br>
--Setting 0x8 enables subframe particle debugging. Use alt+f to step one particle at a time. Use shift+f to step up to the particle underneath the mouse. When not over a particle, it advances to the end of the frame.<br>
--### **REPLACED BY `tpt.debug`**
---@deprecated
---@param mode integer  
function tpt.setdebug(mode)
end

--Sets the "debug mode". It works using bitmasks, so you can turn on multiple debug features at the same time.<br>
--Setting 0x1 will display info on the number of particles on the screen.<br>
--Setting 0x2 will draw a graph showing the percentages of each type of element on the screen.<br>
--Setting 0x4 will display useful information when you draw lines using shift.<br>
--Setting 0x8 enables subframe particle debugging. Use alt+f to step one particle at a time. Use shift+f to step up to the particle underneath the mouse. When not over a particle, it advances to the end of the frame.<br>
---@param mode integer  
function tpt.debug(mode)
end
--Sets the "debug mode". It works using bitmasks, so you can turn on multiple debug features at the same time.<br>
--Setting 0x1 will display info on the number of particles on the screen.<br>
--Setting 0x2 will draw a graph showing the percentages of each type of element on the screen.<br>
--Setting 0x4 will display useful information when you draw lines using shift.<br>
--Setting 0x8 enables subframe particle debugging. Use alt+f to step one particle at a time. Use shift+f to step up to the particle underneath the mouse. When not over a particle, it advances to the end of the frame.<br>
---@return integer  
function tpt.debug()
end

--Changes the upper FPS limit the program will run at. This value is<br>
--60 by default.<br>
--Don't set it too high, it'll eat all your CPU speed and make the game too responsive! Don't also set it too low, since UI and everything related to it uses the same FPS, so you'll find buttons and stuff not working.<br>
--If you don't pass in any arguments, it will return the current fps cap. If you set the fpscap to 2, this will uncap the framerate.<br>
--### **REPLACED BY `tpt.fpsCap`**
---@deprecated
---@param fpscap number  
function tpt.setfpscap(fpscap)
end
--### **REPLACED BY `tpt.fpsCap`**
---@deprecated
---@return number
function tpt.setfpscap() end

--Changes the upper FPS limit the program will run at. This value is<br>
--60 by default.<br>
--Don't set it too high, it'll eat all your CPU speed and make the game too responsive! Don't also set it too low, since UI and everything related to it uses the same FPS, so you'll find buttons and stuff not working.<br>
--If you don't pass in any arguments, it will return the current fps cap. If you set the fpscap to 2, this will uncap the framerate.<br>
---@param fpscap number  
function tpt.fpsCap(fpscap)
end
---@return number
function tpt.fpsCap() end

--**This function is DEPRECATED in TPT 98.0 and can only be used to install script manager**<br>
--This function rejects all input, unless the arguments are those commonly used to install script manager. It is kept only so that old installation instructions still work. Please use tpt.installScriptManager instead. 
--```
--tpt.getscript(1, "autorun.lua", 1) 
--```
---@deprecated
---@param id integer  
---@param name string  
---@param runImmediately integer?  
---@param confirm integer?  
function tpt.getscript(id, name, runImmediately, confirm) end

--```
--tpt.installScriptManager() 
--```
-- Downloads script manager and installs it to TPT's shared data folder as autorun.lua. It will be immediately run, and run on all subsequent launches too.
function tpt.installScriptManager() 
end

--Changes a few special properties as to what size the game renders at.<br>
--Scale is a multiplier by which every pixel shall get multiplied at, currently it can either be 1 (612x384) or 2 (1224x768).<br>
--Full screen is a toggle (0 or 1) that enables "kiosk mode", which basically scales the game up to fill the screen and makes the rest of the edge black.<br>
--### **REPLACED BY `ui.windowSize`**
---@deprecated
---@param scale integer  
---@param fullscreen integer  
function tpt.setwindowsize(scale, fullscreen)
end

--### **REPLACED by `simulation.waterEqualisation`**<br>
--Toggles water equalization. Returns current state.<br>
--```
--number tpt.watertest()
--```
---@return integer
---@deprecated
function tpt.watertest() 
end

--Takes a screenshot of the current screen, minus the menu and HUD.<br>
--**Screenshot format:**<br>
--0 - png<br>
--1 - bmp<br>
--2 - ppm<br>
--**Examples:**<br>
--`tpt.screenshot(1,1)` - take fullscreen screenshot in bmp format<br>
--`tpt.screenshot(1,2)` - take fullscreen screenshot in ppm format<br>
---@param fullscreen integer
---@param screenshot_format integer
function tpt.screenshot(fullscreen,screenshot_format)
end

--Records each drawn frame and saves them all in a unique folder inside a folder called "recordings" in the .ppm format.<br>
--Returns the name of the folder inside the "recordings" folder.<br>
--The record argument if true will start recording and if false will stop recording.<br>
--```
--number tpt.record(boolean record)
--```
---@param record boolean  
---@return integer
function tpt.record(record) end

--Returns an element's number. For example, it would return 28 for dmnd. If passed a number it will return the name instead.<br>
--### **REPLACED BY `elem.getByName`**
---@deprecated
---@param elementname string  
---@return integer
function tpt.element(elementname)
end
--TODO: Is this one deprecated?
---@param elementid integer  
---@return string
function tpt.element(elementid)
end

--Allows you to replace or add on to an element's update function.<br>
--Write a function like normal, and then put its name into this command. Use `tpt.element("...")` or `tpt.el.dust.id` for el_number.<br>
--If replace is set to 1, the new function will be called after the original update function.<br>
--If replace is set to 2, the original function will be overwritten.<br>
--If replace is set to 3, the new function will be called before the original update function.<br>
--Replace automatically defaults to 1.<br>
--new function arguments: index, x, y, surround_space, nt<br>
--Returns: return 1 from your function if the particle is killed.<br>
--### **REPLACED BY `elem.property`**
---@deprecated
---@param newfunction function  
---@param el_number integer  
---@param replace ElemFuncReplace?  
function tpt.element_func(newfunction, el_number, replace)
end

--Allows you to replace an element's graphics function. Write a function like normal, and then put its name into this command. Use tpt.el.(name of element to change).id for el_number.<br>
--
--Function arguments: index, colr, colg, colb<br>
--Returns: cache, pixel_mode, cola, colr, colg, colb, firea, firer, fireg, and fireb.<br>
--
--Set cache to 1 if you don't want the function to ever be called again, preventing lag. Don't do this if you need the way your element looks to change depending on its properties.<br>
--colr/g/b are the red, green, and blue colors of your element. firea/r/g/b set the fire colors, but pixel_mode needs to be set to 0x00022000 for them to work.<br>
--The pixel mode values you can use are:<br>
--```
--PMODE_NONE	0x00000000 --prevents anything from being drawn
--PMODE_FLAT	0x00000001 --draw a basic pixel, overwriting the color under it. Doesn't support cola.
--PMODE_BLOB	0x00000002 --adds a blobby effect, like you were using blob (5) display mode
--PMODE_BLUR	0x00000004 --used in liquids in fancy display mode
--PMODE_GLOW	0x00000008 --Glow effect, used in elements like DEUT and TRON in fancy display mode
--PMODE_SPARK	0x00000010 -- used for things such as GBMB at first, dimmer than other modes
--PMODE_FLARE	0x00000020 --BOMB and other similar elements, brighter than PMODE_SPARK
--PMODE_LFLARE	0x00000040 --brightest spark mode, used when DEST hits something
--PMODE_ADD	0x00000080 --like PMODE_FLAT, but adds color to a pixel, instead of overwriting it.
--PMODE_BLEND	0x00000100 --basically the same thing as PMODE_ADD, but has better OpenGL support
--PSPEC_STICKMAN	0x00000200 --does nothing, because the stickmen won't get drawn unless it actually is one
--NO_DECO		0x00001000 --prevents decoration from showing on the element (used in LCRY)
--DECO_FIRE	0x00002000 --Allow decoration to be drawn on using the fire effect (gasses have this set)
--FIRE_ADD	0x00010000 --adds a weak fire effect around the element (ex. LAVA/LIGH)
--FIRE_BLEND	0x00020000 --adds a stronger fire effect around the element, default for gasses
--EFFECT_GRAVIN	0x01000000 --adds a PRTI effect. Might take some coding in an update function to get it to work properly, PRTI uses life and ctype to create the effects
--EFFECT_GRAVOUT	0x02000000 --adds a PRTO effect. Might take some coding in an update function to get it to work properly, PRTI uses life and ctype to create the effects
--```
--You can combine them in any way you want, you probably need more than one anyway. Radioactive elements default to PMODE_FLAT+PMODE_GLOW, liquids to PMODE_FLAT+PMODE_BLUR, and gasses to FIRE_BLEND+DECO_FIRE, with a firea of 125 and firer/g/b of colr/g/b divided by 2<br>
--See this for a picture of what they look like:<br>
--https://powdertoy.co.uk/Wiki/W/File:Particle_Drawing_Modes.png.html<br>
--### **REPLACED by `elem.property`**<br>
---@param newfunction function  
---@param el_number integer  
---@deprecated
function tpt.graphics_func(newfunction, el_number)
end

--Returns contents of the clipboard.<br>
--### **REPLACED by `platform.clipboardCopy`**<br>
---@return string
---@deprecated
function tpt.get_clipboard() 
end

--Copy to clipboard.<br>
--### **REPLACED by `platform.clipboardPaste`**<br>
---@param text string  
---@deprecated
function tpt.set_clipboard(text)
end

--tpt.setdrawcap<br>
--Changes the rate that particle graphics and the UI render to the screen. This is separate from the fpscap, which only affects the simulation. The drawcap allows TPT to skip drawing every frame. This may increase the framerate in some instances.<br>
--The default is set to the maximum refresh rate of all attached monitors.<br>
--### **REPLACED BY `tpt.drawCap`**
---@deprecated
---@param drawcap integer  
function tpt.setdrawcap(drawcap) end

--```
--tpt.drawCap(drawCap)
--```
--Changes the rate that particle graphics and the UI render to the screen. This is separate from the fpscap, which only affects the simulation. The drawcap allows TPT to skip drawing every frame. This may increase the framerate in some instances.<br>
--The default is set to the maximum refresh rate of all attached monitors.<br>
---@param drawCap integer  
function tpt.drawCap(drawCap) end
--```
--drawCap = tpt.drawCap()
--```
--Changes the rate that particle graphics and the UI render to the screen. This is separate from the fpscap, which only affects the simulation. The drawcap allows TPT to skip drawing every frame. This may increase the framerate in some instances.<br>
--The default is set to the maximum refresh rate of all attached monitors.<br>
---@return integer  
function tpt.drawCap() end


--Returns true if perfect circle brush is enabled.<br>
--If provided with a boolean, will change if its enabled.<br>
--If perfect circle brush is disabled, the circle brush will have single pixels sticking out on the sides.<br>
--```
--boolean tpt.perfectCircleBrush()
--```
--```
--tpt.perfectCircleBrush(boolean enabled)
--```
--### **REPLACED by `interface.perfectCircleBrush`**<br>
---@deprecated
---@return boolean    
function tpt.perfectCircleBrush() end
--### **REPLACED by `interface.perfectCircleBrush`**<br>
---@deprecated
---@param enabled boolean  
function tpt.perfectCircleBrush(enabled) end

---@return string
function tpt.compatChunk()
end

--### **REPLACED BY `evt.register(evt.tick, ...)`**
---@deprecated
function tpt.register_step(f)
end

--### **REPLACED BY `evt.unregister(evt.tick, ...)`**
---@deprecated
function tpt.unregister_step(f)
end

--### **REPLACED BY `evt.register(evt.mousedown, ...) and apparently other events`**
---@deprecated
function tpt.register_mouseclick(f)
end

--### **REPLACED BY `evt.unregister(evt.mousedown, ...) and apparently other events`**
---@deprecated
function tpt.unregister_mouseclick(f)
end

--### **REPLACED BY `evt.register(evt.mousedown, ...) and apparently other events`**
---@deprecated
function tpt.register_mouseevent(f)
end

--### **REPLACED BY `evt.unregister(evt.mousedown, ...) and apparently other events`**
---@deprecated
function tpt.unregister_mouseevent(f)
end

--### **REPLACED BY `evt.register(evt.keypress, ...) and apparently other events`**
---@deprecated
function tpt.register_keypress(f)
end

--### **REPLACED BY `evt.unregister(evt.keypress, ...) and apparently other events`**
---@deprecated
function tpt.unregister_keypress(f)
end


--### **REPLACED BY `tpt.log`**
---@deprecated
function print(...)
end

-- Particle type selected under LMB<br>
--### **REPLACED by `interface.activeTool`**<br>
---@deprecated
---@type string
tpt.selectedl = nil
-- Particle type selected under RMB<br>
--### **REPLACED by `interface.activeTool`**<br>
---@deprecated
---@type string
tpt.selectedr = nil
-- Particle type selected under MMB<br>
--### **REPLACED by `interface.activeTool`**<br>
---@deprecated
---@type string
tpt.selecteda = nil
--### **REPLACED by `interface.activeTool`**<br>
---@deprecated
---@type string
tpt.selectedreplace = nil

--Brush X size<br>
--### **REPLACED by `interface.brushRadius`**<br>
---@deprecated
---@type integer
tpt.brushx = 0
--Brush Y size<br>
--### **REPLACED by `interface.brushRadius`**<br>
---@deprecated
---@type integer
tpt.brushy = 0
--Brush shape ID (0 circle, 1 square, 2 triangle)<br>
--### **REPLACED by `interface.brushID`**<br>
---@deprecated
---@type integer
tpt.brushID = 0

--### **REPLACED by `elem.property`**<br>
---@deprecated
tpt.el = {}

--### **REPLACED by `elem.property`**<br>
---@deprecated
tpt.eltransition = {}

--### **REPLACED by `sim.partProperty` / `sim.parts`**<br>
---@deprecated
tpt.parts = {}
