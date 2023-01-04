---@meta
---@diagnostic disable:lowercase-global
---@diagnostic disable:duplicate-set-field

--If you want to disable deprecation warning, put the line below in yoru file (with three dashes instead of 2)
--@diagnostic disable:deprecated

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

-- tpt.*
--#region

    tpt = {
        -- Particle type selected under LMB  
        ---@type string
        selectedl = nil,
        -- Particle type selected under RMB  
        ---@type string
        selectedr = nil,
        -- Particle type selected under MMB  
        ---@type string
        selecteda = nil,
        
        ---@type string
        selectedreplace = nil,

        --Brush X size  
        ---@type integer
        brushx = 0,
        --Brush Y size  
        ---@type integer
        brushy = 0,
        --Brush shape ID (0 circle, 1 square, 2 triangle)  
        ---@type integer
        brushID = 0,
    }

    --Draw text to the screen (for one frame, only useful in scripts)  
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

    --Create a particle at location. 
    --``` 
    --tpt.create(number x, number y, string type)  
    --``` 
    --Returns the index of the newly created particle.  
    --### **REPLACED BY `sim.partCreate`**
    ---@param x integer  
    ---@param y integer  
    ---@param type string  
    ---@return integer
    ---@deprecated
    function tpt.create(x, y, type)
    end

    --Sets the paused state of the game.   
    --The number argument is either 0 or 1, where 1 means the game will be paused, and 0 will unpause the game. If you don't pass in any arguments, the command will return an integer, either 0 or 1, about whether the game is currently paused.   
    --**Examples:** 
    -- - Pause the game:   
    --```  
    --tpt.set_pause(1)  
    --```  
    -- - Get if the game is paused currently:   
    --```  
    --tpt.set_pause() == 1  
    --```  
    ---@param state integer  
    function tpt.set_pause(state)
    end
    ---@return integer
    function tpt.set_pause()
    end

    --Toggles pause. 
    --Returns 1 if paused after execution and 0 otherwise    
    ---@return integer
    function tpt.toggle_pause() end

    --Set the visibility state of the console.   
    --The number argument can be either 0 or 1, where 1 means the console will be opened, and 0 will close the console. If you don't pass in any arguments, the command will return an integer, either 0 or 1, about whether the console is currently opened.  
    --**Examples:**  
    -- - Open the console:   
    --```  
    --tpt.set_console(1)  
    --```  
    -- - Get if the console is currently open:  
    --```   
    --tpt.set_console() == 1  
    --```  
    ---@param state integer  
    function tpt.set_console(state)
    end
    ---@return integer
    function tpt.set_console()
    end


    --Log a message to the console  
    ---@param text string  
    function tpt.log(text)
    end

    --Sets or resets pressure in the pressure map to some pressure. I sometimes imagine how much I can repeat the word "pressure" inside a sentence before it becomes gibberish.  
    --Default values:  
    --x = 0  
    --y = 0  
    --width = XRES/CELL = 612 / 4 = 153  
    --height= YRES/CELL = 384 / 4 = 96  
    --value = 0  
    --
    --**Examples:**  
    -- - Reset pressure everywhere:   
    --```  
    --tpt.set_pressure()  
    --```  
    -- - Set pressure at (100,100) (for a 1x1 rectangle to only use one wallpixel) to 200:   
    --```  
    --tpt.set_pressure(100,100,1,1,200)  
    --```  
    -- - Set pressure everywhere to 200:   
    --```  
    --tpt.set_pressure(nil,nil,nil,nil,200)  
    --```  
    ---@param x integer  
    ---@param y integer  
    ---@param width integer  
    ---@param height integer  
    ---@param value number  
    function tpt.set_pressure(x, y, width, height, value)
    end
    function tpt.set_pressure()
    end

    --Sets Newtonian Gravity at a position or area to some value.   
    --Default values:  
    --x = 0  
    --y = 0  
    --width = XRES/CELL = 612 / 4 = 153  
    --height = YRES/CELL = 384 / 4 = 96  
    --value = 0  
    --
    --**Examples:**  
    -- - Reset gravity at point (150, 150): 
    --```    
    --tpt.set_gravity(150, 150)  
    --```  
    -- - Reset gravity from (100,100) to (300,300): 
    --```    
    --tpt.set_gravity(100, 100, 200, 200)   
    --```  
    -- - Set the entire stage's gravity to 1000:   
    --```  
    --tpt.set_gravity(nil, nil, nil, nil, 1000)  
    --```  
    ---@param x integer  
    ---@param y integer  
    ---@param width integer  
    ---@param height integer  
    ---@param value number?
    function tpt.set_gravity(x, y, width, height, value)
    end
    ---@param x integer  
    ---@param y integer  
    function tpt.set_gravity(x, y)
    end

    --Thoroughly resets Newtonian gravity on a given point.   
    --Instead of tpt.set_gravity which only modifies `sim->gravmap`, this code modifies `sim->gravp`, `sim->gravx` and `sim->gravy`. 
    --Mmm, gravy.  
    --Default values:  
    --x = 0  
    --y = 0  
    --width = XRES/CELL = 612 / 4 = 153  
    --height = YRES/CELL = 384 / 4 = 96  
    --**Examples:**  
    -- - Thoroughly reset gravity at point (150, 150):   
    --```  
    --tpt.reset_gravity_field(150, 150)  
    --```  
    -- - Reset gravity from (100,100) to (300,300):   
    --```  
    --tpt.reset_gravity_field(100, 100, 200, 200) 
    --```  
    ---@param x integer  
    ---@param y integer  
    ---@param width integer  
    ---@param height integer  
    function tpt.reset_gravity_field(x, y, width, height)
    end
    ---@param x integer  
    ---@param y integer  
    function tpt.reset_gravity_field(x, y)
    end

    --Sets velocity (both x and y) in a given region or point to 0.  
    --Default values:  
    --x = 0  
    --y = 0  
    --width = XRES/CELL = 612 / 4 = 153  
    --height = YRES/CELL = 384 / 4 = 96  
    --**Examples:**  
    -- - Reset velocity everywhere:   
    --```  
    --tpt.reset_velocity()  
    --```  
    -- - Reset velocity in the point (100,100): 
    --```    
    --tpt.reset_velocity(100,100,1,1)  
    --```  
    ---@param x integer  
    ---@param y integer  
    ---@param width integer  
    ---@param height integer  
    function tpt.reset_velocity(x, y, width, height)
    end
    function tpt.reset_velocity()
    end

    --Removes electrified wires from the simulation, resetting to the original material  
    function tpt.reset_spark() end

    --TODO: figure out if any of those are intengers

    --Sets various properties of particles for given criteria  
    ---@param property string  
    ---@param value any  
    function tpt.set_property(property, value)
    end
    ---@param property string  
    ---@param value any  
    ---@param type string  
    function tpt.set_property(property, value, type)
    end
    ---@param property string  
    ---@param value any  
    ---@param index number  
    function tpt.set_property(property, value, index)
    end
    ---@param property string  
    ---@param value any  
    ---@param index number  
    ---@param type string  
    function tpt.set_property(property, value, index, type)
    end
    ---@param property string  
    ---@param value any  
    ---@param x number  
    ---@param y number  
    function tpt.set_property(property, value, x, y)
    end
    ---@param property string  
    ---@param value any  
    ---@param x number  
    ---@param y number  
    ---@param type string  
    function tpt.set_property(property, value, x, y, type)
    end
    ---@param property string  
    ---@param value any  
    ---@param x number  
    ---@param y number  
    ---@param width number  
    ---@param height number  
    function tpt.set_property(property, value, x, y, width, height)
    end
    ---@param property string  
    ---@param value any  
    ---@param x number  
    ---@param y number  
    ---@param width number  
    ---@param height number  
    ---@param type string  
    function tpt.set_property(property, value, x, y, width, height, type)
    end

    ---@param property string  
    ---@param index integer  
    function tpt.get_property(property, index)
    end
    ---@param property string  
    ---@param x integer  
    ---@param y integer  
    function tpt.get_property(property, x, y)
    end

    --Sets the wall at a position. Uses wall/air map coordinates. Divide the actual coordinate by 4 to get the wall coordinate. So to set the wall at (100, 200), pass 100/4 for x and 200/4 for y.  
    ---@param x integer  
    ---@param y integer  
    ---@param walltype WallType|integer  
    function tpt.set_wallmap(x, y, walltype)
    end
    ---@param x integer  
    ---@param y integer  
    ---@param width integer  
    ---@param height integer  
    ---@param walltype WallType|integer    
    function tpt.set_wallmap(x, y, width, height, walltype)
    end
    ---@param x integer  
    ---@param y integer  
    ---@param width integer  
    ---@param height integer  
    ---@param fanVelocityX number  
    ---@param fanVelocityY number  
    ---@param walltype WallType|integer    
    function tpt.set_wallmap(x, y, width, height, walltype, fanVelocityX, fanVelocityY)
    end

    --Gets the wall at a position. Uses wall/air map coordinates. Divide the actual coordinate by 4 to get the wall coordinate. So to set the wall at (100, 200), pass 100/4 for x and 200/4 for y.  
    ---@param x integer  
    ---@param y integer  
    ---@return integer
    function tpt.get_wallmap(x,y) end

    --Sets the "electricity" flag for a wall at a position. This flag is usually set when walls are sparked. The value is decremented by 1 every frame, just like SPRK .life, and when it reaches 0 the wall is "unsparked". Uses wall/air map coordinates. Divide the actual coordinate by 4 to get the wall coordinate. So to set the wall at (100, 200), pass 100/4 for x and 200/4 for y.  
    ---@param x integer  
    ---@param y integer  
    ---@param walltype WallType|integer  
    function tpt.set_elecmap(x, y, walltype)
    end
    ---@param x integer  
    ---@param y integer  
    ---@param width integer  
    ---@param height integer  
    ---@param walltype WallType|integer    
    function tpt.set_elecmap(x, y, width, height, walltype)
    end

    --Gets the "electricity" flag for a wall at a position. This flag is usually set when walls are sparked. Uses wall/air map coordinates. Divide the actual coordinate by 4 to get the wall coordinate. So to set the wall at (100, 200), pass 100/4 for x and 200/4 for y.  
    ---@param x integer  
    ---@param y integer  
    function tpt.get_elecmap(x, y)
    end

    --Draws a pixel on the screen (for one frame, only useful in scripts)  
    ---@param x integer  
    ---@param y integer  
    function tpt.drawpixel(x, y)
    end
    ---@param x integer  
    ---@param y integer  
    ---@param red integer  
    ---@param green integer  
    ---@param blue integer  
    ---@param alpha integer?  
    function tpt.drawpixel(x, y, red, green, blue, alpha)
    end

    --Draws a rectangle on the screen (for one frame, only useful in scripts)  
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

    --Draws a filled in rectangle on the screen (for one frame, only useful in scripts)  
    --Because tpt.fillrect is slightly broken in tpt, the coordinates will be off. It fills the rectangle from (x+1, y+1) to (x+w-1, y+h-1)  
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

    --Draws a line on the screen (for one frame, only useful in scripts). The line starts at point (x1, y1) and ends at point (x2,y2).  
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

    --Measures (in pixels) the width of a given string. Returns a number.  
    --### **REPLACED BY `gfx.textSize`**
    ---@param text string  
    ---@return integer
    ---@deprecated
    function tpt.textwidth(text)
    end

    --Returns the current username.  
    ---@return string
    function tpt.get_name() 
    end

    --Delete a specific particle, or a particle at a location.  
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

    --Ask the user to input some text. Returns a string of what ever the user says. The argument "text" is pre-entered text (optional).  
    ---@param title string?  
    ---@param message string?  
    ---@param text string?  
    ---@return string
    function tpt.input(title, message, text)
    end

    --Display an OK-Only message box with a title and message.  
    ---@param title string?  
    ---@param message string?  
    function tpt.message_box(title, message)
    end

    --Display an confirm message box with a title and message. Returns true if the button with button_name is clicked, returns false if Cancel is clicked.  
    ---@param title string?  
    ---@param message string?  
    ---@param button_name string?  
    ---@return boolean
    function tpt.confirm(title, message,button_name)
    end

    --Returns the number of particles currently on the screen. 
    --### **REPLACED BY `sim.NUM_PARTS`**
    ---@deprecated
    ---@return integer
    function tpt.get_numOfParts() 
    end

    --Start the iterator for receiving all indices of the particles. (Used to help get particle indices, see tpt.next_getPartIndex)  
    --### **REPLACED BY `sim.parts`**
    ---@deprecated
    function tpt.start_getPartIndex() end
    
    --Jump to the next available particle index. Returns false if the iterator has reached the end of all particle indecies. Returns true if a new index was available. (Used to help get particle indecies, see tpt.getPartIndex)  
    --### **REPLACED BY `sim.parts`**
    ---@return boolean
    ---@deprecated
    function tpt.next_getPartIndex()         
    end

    --Get the current index iterator.  
    --Index code example:  
    --```  
    --	 tpt.start_getPartIndex()  
    --	 while tpt.next_getPartIndex() do  
    --	    local index = tpt.getPartIndex()  
    --	    if tpt.get_property("ctype",index) == 21 then  
    --	       tpt.set_property("ctype","sing",index)  
    --	    end  
    --	 end  
    --```  
    --These functions are made obsolete by the function sim.parts(). That allows you to use Lua's iterators.  
    --### **REPLACED BY `sim.parts`**
    ---@return integer
    ---@deprecated
    function tpt.getPartIndex() end
    
    --Set HUD visibility.  
    --Does the same thing as pressing the H key normally. The number argument can be either 0 or 1, where 1 will show the HUD, and 0 will hide the HUD. If you don't pass in any arguments, the command will return an integer, either 0 or 1, about whether the HUD is visible right now.  
    ---@param state integer  
    function tpt.hud(state) end
    ---@return integer
    function tpt.hud() end

    --Sets Newtonian Gravity on and off.  
    --Does the same thing as Ctrl+N in normal gameplay.   
    --The number argument can be either 0 or 1, where 1 will enable Newtonian Gravity, and 0 will disable Newtonian Gravity. If you don't pass in any arguments, the command will return an integer, either 0 or 1, about whether Newtonian Gravity is turned on at the given moment.  
    ---@param state integer  
    function tpt.newtonian_gravity(state) end
    ---@return integer
    function tpt.newtonian_gravity() end

    --Toggles Ambient Heat state.  
    --The number argument can be either 0 or 1, where 1 will enable Ambient Heat, 0 will disable it. If you don't pass in any arguments, the command will return an integer, either 0 or 1, about whether Ambient Heat is turned on at the given moment.  
    ---@param state integer  
    function tpt.ambient_heat(state) end
    ---@return integer
    function tpt.ambient_heat() end

    --Changes activated menu. If you don't pass in any arguments, the command will return the currently active menu.  
    --The menu IDs are detailed here: https://powdertoy.co.uk/Wiki/W/Element_Properties.html#Menu_sections  
    --**Example:** 
    --```  
    --tpt.active_menu(elem.SC_EXPLOSIVE)  
    --```  
    ---@param menu integer  
    function tpt.active_menu(menu) end
    ---@return integer
    function tpt.active_menu() end

    --```  
    --boolean tpt.menu_enabled(number menuID)  
    --```  
    --Returns true if a menu section is enabled.  
    ---@param menuID integer  
    ---@return boolean
    function tpt.menu_enabled(menuID) end
    --```  
    --tpt.menu_enabled(number menuID, boolean enabled)  
    --```  
    --If provided a boolean, will set if a menu section is enabled.  
    ---@param menuID integer  
    ---@param enabled boolean  
    function tpt.menu_enabled(menuID, enabled) end


    --```  
    --number tpt.num_menus()  
    --```  
    --Returns the number of menus.  
    --The optional onlyEnabled boolean is true by default.  
    ---@return integer
    function tpt.num_menus() end
    --```  
    --number tpt.num_menus(boolean onlyEnabled)  
    --```  
    ---@param onlyEnabled boolean  
    ---@return integer
    function tpt.num_menus(onlyEnabled) end

    --Toggle drawing decorations.  
    --The number argument can be either 0 or 1, where 1 will enable decorations, and 0 will disable them. If you don't pass in any arguments, the command will return an integer, either 0 or 1, about whether decorations are turned on at the given moment.  
    --### **REPLACED BY `ren.decorations`**
    ---@param state integer  
    ---@deprecated
    function tpt.decorations_enable(state)
    end
    ---@return integer
    ---@deprecated
    function tpt.decorations_enable() end

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

    --Changes activated display mode.  
    --There's 11 display modes, detailed here https://github.com/ThePowderToy/The-Powder-Toy/blob/f54189a97f6d80181deb4f6d952ccf10f0e59ccf/src/graphics/Renderer.cpp#L2587-L2644  
    --Note that the order of display modes is shifted by 1 making velocity mode first and alternative velocity last.
    -- ---
    --**Display Modes:**   
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
    ---@param display DisplayMode  
    function tpt.display_mode(display)
    end

    --Displays an error message box.  
    ---@param text string  
    function tpt.throw_error(text)
    end

    --Toggles Heat Simulation.   
    --The number argument can be either 0 or 1, where 1 will enable heat, and 0 will disable it. If you don't pass in any arguments, the command will return an integer, either 0 or 1, about whether heat is turned on at the given moment.  
    --It's usually wise not to disable this, as there are practically no saves left that need the compatibility mode in order to work. Nevertheless this option exists. 
    ---@param state integer  
    function tpt.heat(state)
    end
    ---@return integer
    function tpt.heat() end

    --Changes the strength of the games glowing effects. `tpt.setfire(1)` is default.  
    ---@param strength number  
    function tpt.setfire(strength)  
    end

    --Sets the "debug mode". It works using bitmasks, so you can turn on multiple debug features at the same time.  
    --Setting 0x1 will display info on the number of particles on the screen.  
    --Setting 0x2 will draw a graph showing the percentages of each type of element on the screen.  
    --Setting 0x4 will display useful information when you draw lines using shift.  
    --Setting 0x8 enables subframe particle debugging. Use alt+f to step one particle at a time. Use shift+f to step up to the particle underneath the mouse. When not over a particle, it advances to the end of the frame.  
    ---@param mode integer  
    function tpt.setdebug(mode)
    end

    --Changes the upper FPS limit the program will run at. This value is   
    --60 by default.  
    --Don't set it too high, it'll eat all your CPU speed and make the game too responsive! Don't also set it too low, since UI and everything related to it uses the same FPS, so you'll find buttons and stuff not working.  
    --If you don't pass in any arguments, it will return the current fps cap. If you set the fpscap to 2, this will uncap the framerate.  
    ---@param fpscap number  
    function tpt.setfpscap(fpscap)
    end
    ---@return number
    function tpt.setfpscap() end

    --Downloads a script from the script server at starcatcher.us and saves it in the TPT's shared data folder under the provided name.  
    --Optional argument runScript if 1, will run the file after downloading it. By default it's 0.  
    --Optional argument confirmPrompt if 1, will prompt the user before downloading the script. By default it's 1.  
    --```  
    --tpt.getscript(number scriptID, string filename)  
    --```  
    --```  
    --tpt.getscript(number scriptID, string filename, number runScript)  
    --```  
    --```  
    --tpt.getscript(number scriptID, string filename, number runScript, number confirmPrompt)  
    --```  
    ---@param id integer  
    ---@param name string  
    ---@param runImmediately integer?  
    ---@param confirm integer?  
    function tpt.getscript(id, name, runImmediately, confirm) end

    --Changes a few special properties as to what size the game renders at.  
    --Scale is a multiplier by which every pixel shall get multiplied at, currently it can either be 1 (612x384) or 2 (1224x768).   
    --Full screen is a toggle (0 or 1) that enables "kiosk mode", which basically scales the game up to fill the screen and makes the rest of the edge black.  
    ---@param scale integer  
    ---@param fullscreen integer  
    function tpt.setwindowsize(scale, fullscreen)
    end

    --### **REPLACED by `simulation.waterEqualisation`**  
    --Toggles water equalization. Returns current state.  
    --```  
    --number tpt.watertest()  
    --```  
    ---@return integer
    ---@deprecated
    function tpt.watertest() 
    end

    --Takes a screenshot of the current screen, minus the menu and HUD.  
    --**Screenshot format:**   
    --0 - png  
    --1 - bmp  
    --2 - ppm  
    --**Examples:**  
    --`tpt.screenshot(1,1)` - take fullscreen screenshot in bmp format  
    --`tpt.screenshot(1,2)` - take fullscreen screenshot in ppm format  
    ---@param fullscreen integer
    ---@param screenshot_format integer
    function tpt.screenshot(fullscreen,screenshot_format)
    end

    --Records each drawn frame and saves them all in a unique folder inside a folder called "recordings" in the .ppm format.  
    --Returns the name of the folder inside the "recordings" folder.  
    --The record argument if true will start recording and if false will stop recording.  
    --```  
    --number tpt.record(boolean record)  
    --```  
    ---@param record boolean  
    ---@return integer
    function tpt.record(record) end

    --Returns an element's number. For example, it would return 28 for dmnd. If passed a number it will return the name instead.  
    ---@param elementname string  
    ---@return integer
    function tpt.element(elementname)
    end
    ---@param elementid integer  
    ---@return string
    function tpt.element(elementid)
    end

    ---@alias ElemFuncReplace
    ---|1 Call after original
    ---|2 Overwrite original
    ---|3 Call before original

    --Maybe deprecated? Idk if you can do calling before / after using anything else

    --Allows you to replace or add on to an element's update function.  
    --Write a function like normal, and then put its name into this command. Use `tpt.element("...")` or `tpt.el.dust.id` for el_number.  
    --If replace is set to 1, the new function will be called after the original update function.  
    --If replace is set to 2, the original function will be overwritten.  
    --If replace is set to 3, the new function will be called before the original update function.  
    --Replace automatically defaults to 1.  
    --new function arguments: index, x, y, surround_space, nt  
    --Returns: return 1 from your function if the particle is killed.  
    ---@param newfunction function  
    ---@param el_number integer  
    ---@param replace ElemFuncReplace?  
    function tpt.element_func(newfunction, el_number, replace)
    end

    --Allows you to replace an element's graphics function. Write a function like normal, and then put its name into this command. Use tpt.el.(name of element to change).id for el_number.  
    --
    --Function arguments: index, colr, colg, colb  
    --Returns: cache, pixel_mode, cola, colr, colg, colb, firea, firer, fireg, and fireb.  
    --
    --Set cache to 1 if you don't want the function to ever be called again, preventing lag. Don't do this if you need the way your element looks to change depending on its properties.  
    --colr/g/b are the red, green, and blue colors of your element. firea/r/g/b set the fire colors, but pixel_mode needs to be set to 0x00022000 for them to work.  
    --The pixel mode values you can use are:  
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
    --You can combine them in any way you want, you probably need more than one anyway. Radioactive elements default to PMODE_FLAT+PMODE_GLOW, liquids to PMODE_FLAT+PMODE_BLUR, and gasses to FIRE_BLEND+DECO_FIRE, with a firea of 125 and firer/g/b of colr/g/b divided by 2  
    --See this for a picture of what they look like:   
    --https://powdertoy.co.uk/Wiki/W/File:Particle_Drawing_Modes.png.html  
    --### **REPLACED by `elem.property`**  
    ---@param newfunction function  
    ---@param el_number integer  
    ---@deprecated
    function tpt.graphics_func(newfunction, el_number)
    end

    --Returns contents of the clipboard. 
    --### **REPLACED by `platform.clipboardCopy`**  
    ---@return string
    ---@deprecated
    function tpt.get_clipboard() 
    end

    --Copy to clipboard.  
    --### **REPLACED by `platform.clipboardPaste`**  
    ---@param text string  
    ---@deprecated
    function tpt.set_clipboard(text)
    end

    --tpt.setdrawcap  
    --Changes the rate that particle graphics and the UI render to the screen. This is separate from the fpscap, which only affects the simulation. The drawcap allows TPT to skip drawing every frame. This may increase the framerate in some instances.  
    --The default is set to the maximum refresh rate of all attached monitors.  
    ---@param drawcap integer  
    function tpt.setdrawcap(drawcap) end


    --Returns true if perfect circle brush is enabled.  
    --If provided with a boolean, will change if its enabled.  
    --If perfect circle brush is disabled, the circle brush will have single pixels sticking out on the sides.  
    --```  
    --boolean tpt.perfectCircleBrush()  
    --```  
    --```  
    --tpt.perfectCircleBrush(boolean enabled)  
    --```  
    ---@return boolean    
    function tpt.perfectCircleBrush() end
    ---@param enabled boolean  
    function tpt.perfectCircleBrush(enabled) end
--#endregion

-- ui.*
-- TODO: add missing stuff from classes + stuff like @class
--#region

    interface = {}

    --Component
    --#region 

        ---@class Component
        Component = {}

        --Sets the visibility of the component  
        ---@param visible boolean  
        function Component:visible(visible)    
        end
        --Returns the visibility of the component 
        ---@return boolean 
        function Component:visible()
        end

        --Returns the width and height of the component  
        ---@return integer, integer 
        function Component:size()
        end
        --Sets the size of the component to be width by height  
        ---@param width integer  
        ---@param height integer  
        function Component:size(width, height)
        end

        --Sets the position of the component to be x, y  
        ---@param x integer  
        ---@param y integer  
        function Component:position(x,y)    
        end
        --Returns the x and y coord of the component  
        ---@return integer, integer 
        function Component:position()   
        end
    --#endregion

    --Button
    --#region

        --Extends Component, fires "action" when clicked  
        ---@class Button : Component
        Button = {}

        --Extends Component, fires "action" when clicked  
        ---@param x integer  
        ---@param y integer  
        ---@param width integer  
        ---@param height integer  
        ---@param text string?  
        ---@param tooltip string?  
        ---@return Button
        function Button:new(x, y, width, height, text, tooltip)
        end

        ---@alias ButtonCallback fun(sender: Button)

        --```  
        --nil Button:action(function(sender) actionListener)  
        --```  
        --Sets the listener for button actions Example:  
        --```  
        --local newButton = Button:new(10, 10, 100, 17, "Press to change text")  
        --newButton:action(function(sender) sender:text("Text changed") end)  
        --interface.addComponent(newButton)  
        --```  
        ---@param actionListener ButtonCallback  
        function Button:action(actionListener)    
        end

        --Returns the button text  
        ---@return string
        function Button:text()
        end
        --Sets the text of the button  
        ---@param text string  
        function Button:text(text)
        end

        --Returns the enabled state of the button  
        ---@return boolean 
        function Button:enabled()
        end
        --Sets the enabled state of the button  
        ---@param enabled boolean  
        function Button:enabled(enabled)
        end
    --#endregion

    --ProgressBar
    --#region

        --Extends Component, used to indicate progress for long running tasks  
        ---@class ProgressBar : Component
        ProgressBar = {}

        --Extends Component, used to indicate progress for long running tasks  
        ---@param x integer  
        ---@param y integer  
        ---@param width integer  
        ---@param height integer  
        ---@param progress integer  
        ---@param status string  
        ---@return ProgressBar
        function ProgressBar:new(x, y, width, height, progress, status)
        end

        --Progress ranges from 0 to 100, but a special case of -1 will change the behaviour of the progress bar to intermediate (constantly scrolling to indicate progress)  
        --Returns the progress value  
        ---@return integer
        function ProgressBar:progress()
        end
        --Sets the progress value  
        ---@param progress integer  
        function ProgressBar:progress(progress)
        end

        --Status is simple a text representation of the current action being performed, for example "Working" or just a percentage  
        --Returns the progress bar status  
        ---@return string
        function ProgressBar:status()
        end
        --Sets the progress bar status  
        ---@param status string  
        function ProgressBar:status(status)
        end
    --#endregion

    --Slider
    --#region

        --Extends Component, fires "onValueChanged" when the value is changed (i.e used by the user)  
        ---@class Slider : Component
        Slider = {}

        --Extends Component, fires "onValueChanged" when the value is changed (i.e used by the user)  
        ---@param x integer  
        ---@param y integer  
        ---@param width integer  
        ---@param height integer  
        ---@param steps integer?  
        ---@return Slider
        function Slider:new(x, y, width, height, steps)
        end

        ---@alias SliderCallback fun(sender: Slider, value : integer)

        --Sets the listener for slider actions  
        ---@param actionListener SliderCallback  
        function Slider:onValueChanged(actionListener)    
        end

        --Returns the value of the slider  
        ---@return integer
        function Slider:value()
        end
        --Sets the value of the slider  
        ---@param value integer  
        function Slider:value(value)
        end

        --Returns the number of steps the slider has  
        ---@return integer
        function Slider:steps()
        end
        --Sets the number of steps for the slider  
        ---@param steps integer  
        function Slider:steps(steps)
        end
    --#endregion

    --Checkbox
    --#region

        --Extends Component, fires "action" when the checkbox is checked or unchecked  
        ---@class Checkbox : Component
        Checkbox = {}

        --Extends Component, fires "action" when the checkbox is checked or unchecked  
        ---@param x integer  
        ---@param y integer  
        ---@param width integer  
        ---@param height integer  
        ---@param text string?  
        ---@return Checkbox
        function Checkbox:new(x, y, width, height, text)
        end

        ---@alias CheckboxCallback fun(sender: Checkbox, checked: boolean)

        --Sets the listener for checkbox actions  
        ---@param actionListener CheckboxCallback  
        function Checkbox:action(actionListener)
        end

        --Returns the checkbox text  
        ---@return string
        function Checkbox:text()
        end    
        --Sets the text of the checkbox  
        ---@param text string  
        function Checkbox:text(text)
        end

        --Returns the checked state of the checkbox  
        ---@return boolean
        function Checkbox:checked()
        end
        --Sets the checked state of the checkbox  
        ---@param checked boolean  
        function Checkbox:checked(checked)
        end
    --#endregion

    --Label
    --#region

        --Extends Component, is a simple selectable, readonly text field  
        ---@class Label : Component
        Label = {}

        --Extends Component, is a simple selectable, readonly text field  
        ---@param x integer  
        ---@param y integer  
        ---@param width integer  
        ---@param height integer  
        ---@param text string?  
        ---@return Label
        function Label:new(x, y, width, height, text)
        end

        --Returns the label text  
        ---@return string
        function Label:text()
        end
        --Sets the text of the label  
        ---@param text string  
        function Label:text(text)
        end
    --#endregion

    --Textbox
    --#region

        --Extends Component, is a text input field, the placeholder text is shown if the component is no focused and contains no text  
        ---@class Textbox : Component
        Textbox = {}

        --Extends Component, is a text input field, the placeholder text is shown if the component is no focused and contains no text  
        ---@param x integer  
        ---@param y integer  
        ---@param width integer  
        ---@param height integer  
        ---@param text string?
        ---@param placeholder string? 
        ---@return Textbox
        function Textbox:new(x, y, width, height,text,placeholder)
        end

        ---@alias TextboxCallback fun(sender: Textbox)

        --Sets the listener for text changed actions  
        ---@param textChangedListener TextboxCallback  
        function Textbox:onTextChanged(textChangedListener)    
        end

        --Returns the text in the field  
        ---@return string
        function Textbox:text()
        end
        --Sets the text of the field  
        ---@param text string  
        function Textbox:text(text)
        end

        --Returns the readonly status of the field.  
        ---@return boolean
        function Textbox:readonly()
        end
        --Sets the readonly status of the field.  
        ---@param readonly boolean  
        function Textbox:readonly(readonly)
        end
    --#endregion

    --Window
    --#region

        --A modal form to display components, using -1 for either x or y values will centre the Window on that axis.  
        ---@class Window
        Window = {}

        --A modal form to display components, using -1 for either x or y values will centre the Window on that axis.  
        ---@param x integer  
        ---@param y integer  
        ---@param width integer  
        ---@param height integer 
        ---@return Window 
        function Window:new(x, y, width, height)
        end

        --Add a component to the window (The component must not have already been added to another Window object)
        ---@param newComponent Component  
        function Window:addComponent(newComponent)
        end

        --Remove a component from the window  
        ---@param component Component  
        function Window:removeComponent(component)
        end
    --#endregion

    --```  
    --nil interface.showWindow(Window newWindow)  
    --```  
    --Push a Window into the top of the modal stack  
    ---@param newWindow Window
    function interface.showWindow(newWindow)
    end

    --```  
    --nil interface.closeWindow(Window newWindow)  
    --```  
    --Pop a Window off the top of the modal stack. If the given Window is not the top item in the stack, this will have no effect.  
    ---@param newWindow Window
    function interface.closeWindow(newWindow)
    end

    --```  
    --nil interface.addComponent(Component newComponent)  
    --```  
    --Add a component to master game window.  
    ---@param newComponent Component  
    function interface.addComponent(newComponent)
    end


    --```  
    --nil interface.removeComponent(Component newComponent)  
    --```  
    --Remove a component from the master game window.  
    ---@param component Component  
    function interface.removeComponent(component)
    end


    --```  
    --nil interface.grabTextInput()  
    --```  
    --Signal to the interface engine that textinput events are expected and will be handled (for example, your textbox just gained focus and is ready for such events). Once called, it should not be called again until after calling interface.dropTextInput; see below.  
    --From the API user's perspective, the grabTextInput-dropTextInput pair implements an on-off switch. The purpose of this switch is to help the interface engine determine when to enter and exit text input state. In this state, the engine asks for OS help with text input (which may or may not involve enabling an Input Method) and delivers textinput events received from the OS to the API user.  
    --The engine should only enter text input state when the API user expects textinput events (for example, when a textbox is in focus). To correctly communicate this, grabTextInput should be called when processing of textinput events starts and dropTextInput when it ends. Note that textinput events may be delivered regardless of the state of this on-off switch, most likely as a result of another API user calling grabTextInput and dropTextInput.  
    function interface.grabTextInput() end

    --```  
    --nil interface.dropTextInput()  
    --```  
    --Signal to the interface engine that textinput events are not expected and will not be handled (for example, your textbox just lost focus and will not handle such events anymore). Once called, it should not be called again until after calling interface.grabTextInput; see above.  
    function interface.dropTextInput() end

    --```  
    --nil interface.textInputRect(number x, number y, number w, number h)  
    --``` 
    --Enables composition, for multi-byte unicode characters.  
    ---@param x integer  
    ---@param y integer  
    ---@param w integer  
    ---@param h integer  
    function interface.textInputRect(x, y, w, h)
    end

--#endregion

-- sim.*
--#region

    simulation = {}

    --```  
    --number[] sim.partNeighbors(number x, number y, number radius, [number type])  
    --```  
    --Returns a list of particles indexes(starting at 0) that neighbour the given coordinates that matches the given type (if it is specified) The resulting list does not contain the "origin particle"  
    ---@param x integer  
    ---@param y integer  
    ---@param radius integer  
    ---@param type integer?  
    ---@return (integer|nil)[]
    function simulation.partNeighbors(x, y, radius, type)
    end
    
    --```  
    --number[] sim.partNeighbours(number x, number y, number radius, [number type])  
    --```  
    --Returns a list of particles indexes(starting at 0) that neighbour the given coordinates that matches the given type (if it is specified) The resulting list does not contain the "origin particle"  
    ---@param x integer  
    ---@param y integer  
    ---@param radius integer  
    ---@param type integer?  
    ---@return (integer|nil)[]
    function simulation.partNeighbours(x, y, radius, type)
    end

    --```  
    --nil sim.partChangeType(number index, number type)  
    --```  
    --Reliably change the type of a particle, this method avoids the side effects created by changing the type directly with the "partProperty" method.  
    ---@param index integer  
    ---@param type integer  
    function simulation.partChangeType(index, type)
    end


    --```  
    --number sim.partCreate(number index, number x, number y, number type)  
    --```  
    --Create a single particle at location x, y. Returns the index of the new particle, or a negative number on failure.   
    --Possible values for index are:  
    --> **-1** Normal particle creation. This is the most useful value. No particle is created if position x, y is occupied and the requested new particle type cannot pass through the particle that is already there.  
    --> **-2** Create particle as though it was drawn by the user with the brush. Usually not useful.  
    --> **-3** Create particle without checking for collisions with existing particles. In most cases, this is a bad idea, since a lot of elements don't work properly when there are multiple particles in the same place. Particles may also turn into BHOL if there are too many in the same place. The exception to this is elements that have been specifically designed to cope with this (such as multiple energy particles like PHOT and NEUT in the same place).     
    --
    --Particle index >= 0: Overwrite an existing particle with a new particle. At the moment no collision checking is performed, so the same considerations apply as for index=-3. It is usually safe if the new particle is in the same location as the old one. This is roughly equivalent to calling `sim.partKill` then `sim.partCreate(-3, ...)`.  
    ---@param index integer  
    ---@param x integer  
    ---@param y integer  
    ---@param type integer      
    ---@return integer
    function simulation.partCreate(index, x, y, type)
    end

    ---@alias PartProperty    
    ---|integer
    ---|"type"
    ---|"life"
    ---|"ctype"
    ---|"x"
    ---|"y"
    ---|"vx"
    ---|"vy"
    ---|"temp"
    ---|"tmp3"
    ---|"tmp4"
    ---|"flags"
    ---|"tmp"
    ---|"tmp2"
    ---|"dcolour"
    ---|"pavg0" DEPRECATED. USE TMP3
    ---|"pavg1" DEPRECATED. USE TMP4

    --```  
    --nil sim.partProperty(number index, object field, object value)  
    --```  
    --Set the property value on a particle specified by index  
    ---@param index integer  
    ---@param field PartProperty  
    ---@param value any  
    function simulation.partProperty(index, field, value)
    end
    --```  
    --nil sim.partProperty(number index, object field)  
    --```  
    --Get the property value on a particle specified by the index  
    --The "field" may be a field name or field ID, see FIELD constants below for valid fields.  
    ---@param index integer  
    ---@param field PartProperty  
    ---@return any
    function simulation.partProperty(index, field)
    end

    
    --```  
    --number x, number y sim.partPosition(number index)  
    --```  
    --Get the location of the particle at the specified index 
    ---@param index integer  
    ---@return number, number
    function simulation.partPosition(index)
    end


    --```  
    --number sim.partID(number x, number y)  
    --```  
    --Get the index of a particle at the specified position. As of v89.3, this will return nil if there is no particle there.  
    --Example (though this is probably best done with sim.neighbours):  
    --```  
    --for fx = -1, 1, 1 do  
    -- for fy = -1, 1, 1 do  
    --  local i = sim.partID(x + fx, y + fy)  
    --  if i~=nil and sim.partProperty(i, 'type') == elements.DEFAULT_PT_DMND then  
    --   sim.partProperty(index, sim.FIELD_TEMP, 9999)  
    --  end  
    -- end  
    --end  
    --```  
    ---@param x integer  
    ---@param y integer  
    ---@return integer
    function simulation.partID(x, y)
    end

    --```  
    --nil sim.partKill(number index)  
    --nil sim.partKill(number x, number y)  
    --```  
    --Reliably delete a particle at a specified index or location, this method avoids the side effects created by changing the type to 0/DEFAULT_PT_NONE with the "partProperty" method  
    ---@param index integer  
    function simulation.partKill(index)
    end
    ---@param x integer  
    ---@param y integer  
    function simulation.partKill(x, y)
    end


    --```  
    --number sim.pressure(number x, number y)  
    --```  
    --Returns a value on the pressure map.  
    ---@param x integer  
    ---@param y integer  
    ---@return number
    function simulation.pressure(x, y)
    end
    --```  
    --nil sim.pressure(number x, number y, [number width, number height], number pressure)  
    --```  
    --Sets values on the pressure map.  
    ---@param x integer  
    ---@param y integer  
    ---@param width integer  
    ---@param height integer  
    ---@param pressure number  
    function simulation.pressure(x, y, width, height, pressure)
    end
    ---@param x integer  
    ---@param y integer  
    ---@param pressure number  
    function simulation.pressure(x, y, pressure)
    end


    --```  
    --number sim.ambientHeat(number x, number y)  
    --```  
    --Returns a value on the ambient heat map (the temperature of the air at that point).   
    ---@param x integer  
    ---@param y integer  
    ---@return number
    function simulation.ambientHeat(x, y)
    end
    --```  
    --nil sim.ambientHeat(number x, number y, [number width, number height], number temp)  
    --```  
    --Sets values on the ambient heat map. 
    ---@param x integer  
    ---@param y integer  
    ---@param width integer  
    ---@param height integer  
    ---@param temp number  
    function simulation.ambientHeat(x, y, width, height, temp)
    end
    ---@param x integer  
    ---@param y integer  
    ---@param temp number  
    function simulation.ambientHeat(x, y, temp)
    end

    --```  
    --number sim.velocityX(number x, number y)  
    --```  
    --Returns an X value on the velocity map.  
    ---@param x integer  
    ---@param y integer  
    ---@return number
    function simulation.velocityX(x, y)
    end
    --```  
    --nil sim.velocityX(number x, number y, [number width, number height], number value)  
    --```  
    --Sets X values on the velocity map.  
    ---@param x integer  
    ---@param y integer  
    ---@param width integer  
    ---@param height integer  
    ---@param value number  
    function simulation.velocityX(x, y, width, height, value)
    end
    ---@param x integer  
    ---@param y integer  
    ---@param value number  
    function simulation.velocityX(x, y, value)
    end

    --```  
    --number sim.velocityY(number x, number y)  
    --```  
    --Returns an Y value on the velocity map.  
    ---@param x integer  
    ---@param y integer  
    ---@return number
    function simulation.velocityY(x, y)
    end
    --```  
    --nil sim.velocityY(number x, number y, [number width, number height], number value)  
    --```  
    --Sets Y values on the velocity map.  
    ---@param x integer  
    ---@param y integer  
    ---@param width integer  
    ---@param height integer  
    ---@param value number  
    function simulation.velocityY(x, y, width, height, value)
    end
    ---@param x integer  
    ---@param y integer  
    ---@param value number  
    function simulation.velocityY(x, y, value)
    end

    --```  
    --nil sim.gravMap(number x, number y, [number width, number height, [number value]])  
    --```  
    --Returns the newtonian gravity at the given coordinates in the simulation. If given a value, will set the newtonian gravity at those coordinates. Width and height refer to the rectangle of affected cells, starting with the coords. If not given, they will default to 1,1.  
    ---@param x integer  
    ---@param y integer  
    ---@return number
    function simulation.gravMap(x, y)
    end
    ---@param x integer  
    ---@param y integer  
    ---@param width integer  
    ---@param height integer  
    ---@param value number  
    function simulation.gravMap(x, y, width, height, value)
    end
    ---@param x integer  
    ---@param y integer  
    ---@param value number  
    function simulation.gravMap(x, y, value)
    end


    --TODO: look into if its an iterator

    --```  
    --number sim.createParts(number x, number y, [number rx], [number ry], [number type], [number brush], [number flag])  
    --```  
    --Does something.  
    ---@param x integer  
    ---@param y integer  
    ---@param rx integer?  
    ---@param ry integer?  
    ---@param type integer?  
    ---@param brush integer? 
    ---@param flag integer?  
    ---@return number
    function simulation.createParts(x, y, rx, ry, type, brush, flag)
    end


    --```  
    --nil sim.createLine(number x1, number y1, number x2, number y2, [number rx], [number ry], [number type], [number brush], [number, flag])  
    --```  
    --Creates a line of of either the user's currently selected type or the type specified at the specified coordinates.  
    --rx and ry describe the radius of the brush used. Default radius is 5, 5.  
    --flag refers to particle replacement flags.  
    ---@param x1 integer  
    ---@param y1 integer  
    ---@param x2 integer  
    ---@param y2 integer  
    ---@param rx integer?  
    ---@param ry integer?  
    ---@param type integer?  
    ---@param brush integer? 
    ---@param flag integer?  
    function simulation.createLine(x1, y1, x2, y2, rx, ry, type, brush, flag) end


    --```  
    --nil sim.createBox(number x1, number y1, number x2, number y2, [number type], [number flag])  
    --```  
    --Creates a filled box of either the user's currently selected type or the type specified at the specified coordinates.  
    --flag refers to particle replacement flags.  
    ---@param x1 integer  
    ---@param y1 integer  
    ---@param x2 integer  
    ---@param y2 integer  
    ---@param type integer?  
    ---@param flag integer?  
    function simulation.createBox(x1, y1, x2, y2, type, flag)
    end

    --TODO: look into if its an iterator

    --```  
    --number sim.floodParts(number x, number y, [number type], [number cm?], [number flag])  
    --```  
    --Flood fills either the user's currently selected type or the type specified at the coordinates given.  
    --flag refers to particle replacement flags.  
    ---@param x integer  
    ---@param y integer  
    ---@param type integer?  
    ---@param cm integer?  
    ---@param flag integer?  
    ---@return integer
    function simulation.floodParts(x, y, type, cm, flag)
    end



    --```  
    --number sim.createWalls(number x, number y, [number rx], [number ry], [number walltype])  
    --```  
    --Does something  
    ---@param x integer  
    ---@param y integer  
    ---@param rx integer?  
    ---@param ry integer?  
    ---@param walltype WallType?  
    ---@return number
    function simulation.createWalls(x, y, rx, ry, walltype)
    end


    --```  
    --nil sim.createWallLine(number x1, number y1, number x2, number y2, [number rx], [number ry], [number walltype])  
    --```  
    --Creates a line of either the specified walltype or the type of the basic wall at the specified particle coordinates.  
    --Note: the coordinates might change from particle coordinates to map coordinates in the future.  
    ---@param x1 integer  
    ---@param y1 integer  
    ---@param x2 integer  
    ---@param y2 integer  
    ---@param rx integer?  
    ---@param ry integer?  
    ---@param walltype WallType?  
    function simulation.createWallLine(x1, y1, x2, y2, rx, ry, walltype)
    end

    --```  
    --nil sim.createWallBox(number x1, number y1, number x2, number y2, [number walltype])  
    --```  
    --Creates a filled box of either the specified walltype or the type of the basic wall at the specified particle coordinates.  
    --Note: the coordinates might change from particle coordinates to map coordinates in the future.  
    ---@param x1 integer  
    ---@param y1 integer  
    ---@param x2 integer  
    ---@param y2 integer  
    ---@param walltype WallType?  
    function simulation.createWallBox(x1, y1, x2, y2, walltype)
    end

    --TODO: look into if its an iterator

    --```  
    --number sim.floodWalls(number x, number y, [number walltype], [number bm?])  
    --```  
    --Flood fills either the specified walltype or the type of the basic wall at the specified particle coordinates.  
    --Note: the coordinates might change from particle coordinates to map coordinates in the future.  
    ---@param x integer  
    ---@param y integer  
    ---@param walltype WallType?  
    ---@param bm integer?  
    ---@return number
    function simulation.floodWalls(x, y, walltype, bm)
    end

    -- TODO: Alias with all tools
    --TODO: look into if its an iterator

    --```  
    --number sim.toolBrush(number x, number y, [number rx], [number ry], [number tool], [number brush], [number strength])  
    --```  
    --Performs the given tool (HEAT, COOL, AIR, etc) on the given coordinates with the given brush size. The brush types are 0 (circle), 1 (square) and 2 (triangle).  
    ---@param x integer  
    ---@param y integer  
    ---@param rx integer?  
    ---@param ry integer?  
    ---@param tool integer?  
    ---@param brush integer?  
    ---@param strength number?  
    ---@return number
    function simulation.toolBrush(x, y, rx, ry, tool, brush, strength)
    end



    --```  
    --type sim.toolLine(number x1, number y1, number x2, number y2, [number rx], [number ry], [number tool], [number brush], [number strength])  
    --```  
    --Does something  
    ---@param x1 integer  
    ---@param y1 integer  
    ---@param x2 integer  
    ---@param y2 integer  
    ---@param rx integer?  
    ---@param ry integer?  
    ---@param tool integer?  
    ---@param brush integer?  
    ---@param strength number?  
    function simulation.toolLine(x1, y1, x2, y2, rx, ry, tool, brush, strength)
    end

    
    --```  
    --type sim.toolBox(number x1, number y1, number x2, number y2, [number tool], [number strength])  
    --```  
    --Does something  
    ---@param x1 integer  
    ---@param y1 integer  
    ---@param x2 integer  
    ---@param y2 integer  
    ---@param tool integer?  
    ---@param strength number?  
    function simulation.toolBox(x1, y1, x2, y2, tool, strength)
    end
    
    --```  
    --nil sim.decoBrush(number x, number y, [number rx], [number ry], [number r, number g, number b, [number a]], [number tool], [number brush])  
    --```  
    --Does something  
    --tool refers to decoration tools.  
    ---@param x integer  
    ---@param y integer  
    ---@param rx integer?  
    ---@param ry integer?  
    ---@param r integer?  
    ---@param g integer?  
    ---@param b integer?  
    ---@param a integer?  
    ---@param tool integer?  
    ---@param brush integer?  
    function simulation.decoBrush(x, y, rx, ry, r, g, b, a, tool, brush)
    end


    --```  
    --nil sim.decoLine(number x1, number y1, number x2, number y2, [number rx], [number ry], [number r, number g, number b, [number a]], [number tool], [number brush])  
    --```  
    --Changes the decoration color of all particles in the line specified.  
    --rx and ry describe the radius of the brush used. Default radius is 5, 5.  
    --tool refers to decoration tools.  
    ---@param x1 integer  
    ---@param y1 integer  
    ---@param x2 integer  
    ---@param y2 integer  
    ---@param rx integer?  
    ---@param ry integer?  
    ---@param r integer?  
    ---@param g integer?  
    ---@param b integer?  
    ---@param a integer?  
    ---@param tool integer?  
    ---@param brush integer?  
    function simulation.decoLine(x1, y1, x2, y2, rx, ry, r, g, b, a, tool, brush)
    end


    --```  
    --nil sim.decoBox(number x1, number y1, number x2, number y2, [number r, number g, number b, [number a]], [number tool])  
    --```  
    --Changes the decoration color of all particles in the specified coordinates.  
    --tool refers to decoration tools.  
    ---@param x1 integer  
    ---@param y1 integer  
    ---@param x2 integer  
    ---@param y2 integer  
    ---@param r integer?  
    ---@param g integer?  
    ---@param b integer?  
    ---@param a integer?  
    ---@param tool integer?  
    function simulation.decoBox(x1, y1, x2, y2, r, g, b, a, tool)
    end


    --```  
    --number sim.decoColor()  
    --```  
    --Returns the currently selected decoration color.  
    ---@return integer
    function simulation.decoColor()
    end
    --```  
    --nil sim.decoColor(number color)  
    --``` 
    --Sets the selected decoration color to color.  
    --color is in the format 0xAARRGGBB  
    ---@param color integer  
    function simulation.decoColor(color)
    end
    --```  
    --nil sim.decoColor(number r, number g, number b, [number a])  
    --```  
    --Sets the selected decoration color to r,g,b,a  
    ---@param r integer  
    ---@param g integer  
    ---@param b integer  
    ---@param a integer?  
    function simulation.decoColor(r, g, b, a)
    end

    --```  
    --number sim.decoColour()  
    --```  
    --Returns the currently selected decoration color.  
    ---@return integer
    function simulation.decoColour()
    end
    --```  
    --nil sim.decoColour(number color)  
    --``` 
    --Sets the selected decoration color to color.  
    --color is in the format 0xAARRGGBB  
    ---@param colour integer  
    function simulation.decoColour(colour)
    end
    --```  
    --nil sim.decoColour(number r, number g, number b, [number a])  
    --```  
    --Sets the selected decoration color to r,g,b,a  
    ---@param r integer  
    ---@param g integer  
    ---@param b integer  
    ---@param a integer?  
    function simulation.decoColour(r, g, b, a)
    end

    --```  
    -- nil sim.floodDeco(number x, number y, number r, number g, number b, number a) 
    --```  
    --Flood fills the color at position x, y with another color. Note: Color at position includes console overlay.  
    ---@param x integer  
    ---@param y integer  
    ---@param r integer  
    ---@param g integer  
    ---@param b integer  
    ---@param a integer  
    function simulation.floodDeco(x, y, r, g, b, a) end


    --```  
    --nil sim.clearSim()  
    --```  
    --Clears everything in the simulation.  
    function simulation.clearSim() end

    --```  
    --nil sim.clearRect(number x, number y, number width, number height)  
    --```  
    --Clears all particles in a rectangle starting at x, y down and to the right width and height pixels respectively.  
    ---@param x integer  
    ---@param y integer  
    ---@param width integer  
    ---@param height integer  
    function simulation.clearRect(x, y, width, height) end
    

    --```  
    --nil sim.resetTemp()  
    --```  
    --Resets the temperature of all particles to their spawn temperature.  
    function simulation.resetTemp() end

    --```  
    --nil sim.resetPressure()  
    --```  
    --Resets the pressure map to no pressure.  
    function simulation.resetPressure() end


    --```  
    --string sim.saveStamp([number x, number y, number width, number height])  
    --```  
    --Creates a stamp of the specified coordinates. Coordinates default to entire simulation.  
    --Returns the stamp id created.  
    ---@param x integer  
    ---@param y integer  
    ---@param width integer  
    ---@param height integer  
    ---@return string
    function simulation.saveStamp(x, y, width, height)
    end
    ---@return string
    function simulation.saveStamp()
    end

    --```  
    --sim.loadStamp(string filename, number x, number y)  
    --sim.loadStamp(number id, number x, number y)  
    --``` 
    --Loads a stamp identified by filename or ID, and places it at position x,y. Filenames should be given without stamps/ or the .stm suffix. On success, returns 1. On failure, returns nil and the failure reason as a string.  
    ---@param filename string  
    ---@param x integer  
    ---@param y integer  
    ---@return number | nil, string | nil
    function simulation.loadStamp(filename, x, y)
    end
    ---@param id integer  
    ---@param x integer  
    ---@param y integer  
    ---@return number | nil, string | nil
    function simulation.loadStamp(id, x, y)
    end


    --```  
    --type sim.deleteStamp(string name)  
    --```  
    --Deleting a stamp identified by filename or ID.  
    ---@param name string  
    function simulation.deleteStamp(name)
    end
    ---@param id integer  
    function simulation.deleteStamp(id)
    end


    --```  
    --nil sim.loadSave(number SaveID, [number hideDescription], [number history?])  
    --```  
    --Loads the save associated with the specified SaveID.  
    --If hideDescription is non zero, the information for the save is not shown.  
    ---@param SaveID integer  
    ---@param hideDescription integer?  
    ---@param history integer?  
    function simulation.loadSave(SaveID, hideDescription, history)
    end


    --```  
    --nil sim.reloadSave()  
    --```  
    --Reloading save.  
    function simulation.reloadSave() end

    
    --```  
    --number, number sim.getSaveID()  
    --```  
    --Returns the save ID and the history offset of the currently loaded save or nil if the simulation is not a downloaded save. The history offset can be used with loadSave.  
    ---@return integer, integer
    function simulation.getSaveID() 
    end


    --```  
    --number, number sim.adjustCoords(number x, number y)  
    --```  
    --Actually this is more of a UI method than a simulation method. Given a mouse position x, y in the window, this function returns the corresponding coordinates in the simulation (taking into account the visibility and position of the zoom window, if applicable). 
    ---@param x integer  
    ---@param y integer  
    ---@return integer, integer
    function simulation.adjustCoords(x, y)
    end

    --```  
    --number sim.prettyPowders()  
    --nil sim.prettyPowders(mode)  
    --```  
    --Sets whether the "pretty powders mode" (powders, such as SAND or BCOL, will be assigned random deco values) is on or off. When called with no arguments, returns a value determining whether it is on or off.  
    ---@return integer
    function simulation.prettyPowders() 
    end
    ---@param mode integer  
    function simulation.prettyPowders(mode) end


    --```  
    --number sim.gravityGrid()  
    --```  
    --Returns the current setting for drawing the gravity grid. More of a renderer setting than a simulation setting.  
    ---@return integer
    function simulation.gravityGrid()
    end
    --```  
    --nil sim.gravityGrid(number mode)  
    --```  
    --Sets the setting for drawing the gravity grid to mode.  
    ---@param mode integer  
    function simulation.gravityGrid(mode)
    end

    --```  
    --number sim.edgeMode()  
    --```  
    --Returns the current Edge Mode  
    ---@return integer
    function simulation.edgeMode()
    end
    --```  
    --nil sim.edgeMode(number mode)  
    --```  
    --Sets the current Edge Mode to mode. 0 means normal, 1 creates a wall all the way round the edge of the simulation. 
    ---@param mode integer  
    function simulation.edgeMode(mode)
    end

    ---@alias GravityMode
    ---|0 Normal, vertical gravity
    ---|1 No gravity
    ---|2 Radial gravity  

    --```  
    --number sim.gravityMode()  
    --```  
    --Returns the current gravity simulation mode.  
    ---@return GravityMode
    function simulation.gravityMode()
    end
    --```  
    --nil sim.gravityMode(number mode)  
    --```  
    --Sets the gravity simulation mode to mode.  
    -- - 0 Normal, vertical gravity   
    -- - 1 No gravity  
    -- - 2 Radial gravity  
    ---@param mode GravityMode  
    function simulation.gravityMode(mode)
    end


    --TODO: Add docs once its added on wiki
    ---@param x number?
    ---@param y number
    function simulation.customGravity(x, y)        
    end
    ---@return number, number
    function simulation.customGravity(x, y)        
    end

    ---@alias AirMode
    ---|0 Normal  
    ---|1 Pressure off  
    ---|2 Velocity off  
    ---|3 Velocity and pressure off  
    ---|4 No update   


    --```  
    --number sim.airMode()  
    --```  
    --Returns the current Air Simulation Mode.  
    ---@return AirMode
    function simulation.airMode()
    end
    --```  
    --nil sim.airMode(number mode)  
    --```  
    --Sets the Air Simulation Mode to mode.  
    --Mode numbers are as follows (not currently available as named constants):  
    -- - 0 Normal  
    -- - 1 Pressure off  
    -- - 2 Velocity off  
    -- - 3 Velocity and pressure off  
    -- - 4 No update  
    ---@param mode AirMode  
    function simulation.airMode(mode)
    end

    
    --```  
    --number sim.waterEqualisation()  
    --```  
    --Returns the current Water equalisation setting.  
    ---@return integer
    function simulation.waterEqualisation()
    end
    --```  
    --nil sim.waterEqualisation(number setting)  
    --```  
    --Set the Water equalisation setting to setting.  
    ---@param setting integer  
    function simulation.waterEqualisation(setting)
    end    

    --```  
    --number sim.waterEqualization()  
    --```  
    --Returns the current Water equalization setting.  
    ---@return integer
    function simulation.waterEqualization()
    end
    --```  
    --nil sim.waterEqualization(number setting)  
    --```  
    --Set the Water equalization setting to setting.  
    ---@param setting integer  
    function simulation.waterEqualization(setting)
    end


    --```  
    --number sim.ambientAirTemp()  
    --```  
    --Returns the current ambient temperature. When ambient heat mode is turned on, the air at the edges of the screen will remain at this temperature.   
    ---@return number
    function simulation.ambientAirTemp()
    end
    --```  
    --nil sim.ambientAirTemp(number temp)  
    --```  
    --Sets the ambient temperature. The temperature is measured in Kelvin. 
    ---@param temp number  
    function simulation.ambientAirTemp(temp)
    end


    --```  
    --number sim.elementCount(number type)  
    --```  
    --Returns the number of particles of the specified type in the simulation.  
    ---@param type integer  
    ---@return integer
    function simulation.elementCount(type)
    end

    ---@alias CanMoveMethod
    ---|0 Bounce off the obstacle  
    ---|1 Swap places with the obstacle  
    ---|2 Move over the obstacle  

    --```  
    --simulation.can_move(number movingElementID, number obstacleElementID, number method)  
    --```  
    --Decides what a particle does when it hits another particle while moving. Method is one of the following:  
    -- - 0 bounce off the obstacle  
    -- - 1 swap places with the obstacle  
    -- - 2 move over the obstacle  
    ---@param movingElementID integer  
    ---@param obstacleElementID integer  
    ---@param method CanMoveMethod  
    function simulation.can_move(movingElementID, obstacleElementID, method) end
    --```  
    --number simulation.can_move(number movingElementID, number obstacleElementID)  
    --```  
    --Returns what a particle does when it hits another particle while moving, a method like above.  
    ---@param movingElementID integer  
    ---@param obstacleElementID integer  
    ---@return CanMoveMethod
    function simulation.can_move(movingElementID, obstacleElementID) 
    end

    --```  
    --function sim.brush(number x, number y, [number brushWidth, number brushHeight], [number brushID])  
    --```  
    --Returns an iterator over positions inside the specified brush.  
    --If width, height or ID is not provided, will use values of the current brush selected by user.  
    --Example:  
    --```  
    --for x, y in sim.brush(300, 200, 100, 50, 0) do  
    --    sim.partCreate(-1, x, y, elem.DEFAULT_PT_DUST)  
    --end  
    --```  
    ---@param x integer  
    ---@param y integer  
    ---@return fun(): integer, integer
    function simulation.brush(x, y) end
    ---@param x integer  
    ---@param y integer  
    ---@param brushWidth integer  
    ---@param brushHeight integer  
    ---@param brushID integer?  
    ---@return fun(): integer, integer
    function simulation.brush(x, y, brushWidth, brushHeight, brushID) end

    --```  
    --function sim.parts()  
    --```  
    --Returns an iterator over particle indexes that can be used in lua for loops  
    ---@return fun(): integer
    function simulation.parts() end

    --```  
    --number sim.pmap(number x, number y)  
    --```  
    --Get the index of the particle at the specified position. Returns 0 if there is no particle there. This function is very similar to sim.partID, but excludes energy particles (such as PHOT, NEUT, ELEC).  
    ---@param x integer  
    ---@param y integer  
    ---@return integer
    function simulation.pmap(x, y)
    end

    --```  
    --number sim.photons(number x, number y)  
    --```  
    --Get the index of the energy particle at the specified position. Returns 0 if there is no particle there. This function is very similar to sim.pmap  
    ---@param x integer  
    ---@param y integer  
    ---@return integer
    function simulation.photons(x, y)
    end

    --```  
    --type sim.neighbors(number x, number y, [number rx], [number ry], [number type])  
    --```  
    --Used for iterating through particles in an area centred on the given coordinates (x, y). Radius in the x and y directions is set by rx and ry. Default radius is 2, 2. If type is provided, only particles of the corresponding type will be returned.  
    --The size of the rectangular area is one plus twice the radius, so a radius of 2, 2 gives a 5x5 pixel area centred on x, y. Particles in the centre position x, y are excluded. Only one particle in each position is included, and energy particles (such as photons, neutrons, electrons) are ignored.  
    --Example (i is the index of the neighbouring particle and nx, ny are its coordinates):  
    --```  
    --for i,nx,ny in sim.neighbors(100,200,1,1) do  
    -- sim.partProperty(i, sim.FIELD_TEMP, 9999)  
    --end  
    --```  
    --Or if coordinates of the neighbouring particles are not required:  
    --```  
    --for i in sim.neighbors(100,200,1,1) do  
    -- sim.partProperty(i, sim.FIELD_TEMP, 9999)  
    --end  
    --```  
    ---@param x integer  
    ---@param y integer  
    ---@param rx integer  
    ---@param ry integer  
    ---@param type integer?  
    ---@return fun(): number, number, number
    function simulation.neighbors(x, y, rx, ry, type)
    end
    ---@param x integer  
    ---@param y integer  
    ---@return fun(): number, number, number
    function simulation.neighbors(x, y)
    end


    --```  
    --number sim.framerender()  
    --sim.framerender(number frames)  
    --```  
    --Advances the simulation the given number of frames, even when paused. If called with no arguments, returns the number of frames currently to be rendered. Usually is 0.  
    ---@param frames integer  
    function simulation.framerender(frames)
    end
    ---@return integer
    function simulation.framerender()
    end


    --```  
    --number sim.gspeed()  
    --```  
    --Returns the current GoL speed  
    ---@return integer
    function simulation.gspeed()
    end
    --```  
    --nil sim.gspeed(number newSpeed)  
    --```  
    --Sets the current GoL speed. This is the number of frames between GoL updates. Default is one, larger numbers make it slower.  
    ---@param newSpeed integer  
    function simulation.gspeed(newSpeed)
    end


    --```  
    --nil sim.takeSnapshot()  
    --```  
    --Takes a undo snapshot, for use with ctrl + z  
    function simulation.takeSnapshot() end

    --```  
    --number sim.replaceModeFlags()  
    --```  
    --Returns the current replace mode flags.  
    --If the first bit of that number is set (flags = 1), replace mode is enabled.  
    --If the second bit is set (flags = 2), specific delete is enabled.  
    ---@return integer
    function simulation.replaceModeFlags() 
    end
    --```  
    --nil sim.replaceModeFlags(number flags)  
    --```  
    --Sets the replace mode flags.  
    ---@param flags integer  
    function simulation.replaceModeFlags(flags) end

    ---@alias GOL {name: string, rulestr: string, rule: number, color1: number, color2: number}

    --```  
    --table sim.listCustomGol()  
    --```  
    --Returns a table of all custom game of life types. Each index has a name (string), rulestr (string), rule (number), color1 (number), and color2 (number) property.  
    --See https://powdertoy.co.uk/Wiki/W/Lua_API:Simulation.html#simulation.addCustomGol for details about properties.  
    ---@return GOL[]
    function simulation.listCustomGol() end

    --```  
    --nil sim.addCustomGol(string rule, string name, number color1, number color2)  
    --```  
    --Adds a custom game of life type with the specified rule, name, and colors. Rule strings use B#/S#/# notation (more detail). Colors are used when fading between multiple states. Names and rules cannot be duplicates.  
    ---@param rule string  
    ---@param name string  
    ---@param color1 number  
    ---@param color2 number  
    function simulation.addCustomGol(rule, name, color1, color2) end
    --```  
    --nil sim.addCustomGol(number rule, string name, number color1, number color2)  
    --```  
    --Same as above, but takes a binary representation of the rule instead of a string. Bits 0-8 list stay values (starting at 0), bits 9-16 list begin values (starting at 1), and bits 17-20 are the number of states (decimal value added to 2). This is also how GOL rules are stored as ctypes.  
    ---@param rule number  
    ---@param name string  
    ---@param color1 number  
    ---@param color2 number  
    function simulation.addCustomGol(rule, name, color1, color2) end

    --```  
    --boolean sim.removeCustomGol(string name)  
    --```  
    --Removes all custom game of life types with the specified name. Returns true if any were removed.  
    ---@param name string  
    ---@return boolean
    function simulation.removeCustomGol(name) end

    --```  
    --number sim.lastUpdatedID()
    --```  
    --Returns the last updated particle ID, if the simulation is currently being stepped through particle-by-particle (either using sim.updateUpTo or user input with tpt.setdebug(0x8)). If subframe particle debugging isn't active, returns nil.
    ---@return integer
    function simulation.lastUpdatedID() end

    --```  
    --nil sim.updateUpTo()
    --```  
    --Updates the simulation, but only up to the specified particle ID. Works as if shift+f is pressed while in particle debug mode (tpt.setdebug(0x8)). If no arguments are passed in, updates to the end of the frame.
    function simulation.updateUpTo() end
    --```  
    --nil sim.updateUpTo(number ID)
    --```  
    --Updates the simulation, but only up to the specified particle ID. Works as if shift+f is pressed while in particle debug mode (tpt.setdebug(0x8)). If no arguments are passed in, updates to the end of the frame.
    ---@param ID integer  
    function simulation.updateUpTo(ID) end

    --```  
    --number sim.temperatureScale()
    --```  
    -- Sets the temperature scale to use in the HUD. If called with no arguments, returns the current scale.
    -- - 0 Kelvin
    -- - 1 Celicus
    -- - 2 Farenheit
    ---@return integer
    function simulation.temperatureScale() end
    --```  
    --nil sim.temperatureScale(number scale)
    --```  
    -- Sets the temperature scale to use in the HUD. If called with no arguments, returns the current scale.
    -- - 0 Kelvin
    -- - 1 Celicus
    -- - 2 Farenheit
    ---@param scale integer
    function simulation.temperatureScale(scale) end


    --```  
    --boolean sim.historyRestore()
    --```  
    --Tries restoring a history snapshot (ctrl+z). Returns true on success, or false if there is no history to restore.
    ---@return boolean
    function simulation.historyRestore() end

    --```  
    --boolean sim.historyForward()
    --```  
    --Tries restoring a redo snapshot (ctrl+y). Returns true on success, or false if there is no redo history to restore.
    ---@return boolean
    function simulation.historyForward() end


--#endregion

-- ren.*
--#region

    renderer = {
        --#### These should be used in lua graphics functions to set how particles will be drawn. Effects like fire, glowing, and flares are set here. How a particle is actually rendered depends on the current render and display modes.  
        PMODE           = 0x00000FFF,	    --> A bitmask which can be used to check if a particle has any PMODEs set.  
        --#### These should be used in lua graphics functions to set how particles will be drawn. Effects like fire, glowing, and flares are set here. How a particle is actually rendered depends on the current render and display modes.  
        PMODE_NONE	    = 0x00000000,	    --> Don't draw a point where a particle is at all. Unused.  
        --#### These should be used in lua graphics functions to set how particles will be drawn. Effects like fire, glowing, and flares are set here. How a particle is actually rendered depends on the current render and display modes.  
        PMODE_FLAT	    = 0x00000001,	    --> Draw a basic pixel, overwriting the color under it. Given by default to everything unless overridden, Doesn't support cola.  
        --#### These should be used in lua graphics functions to set how particles will be drawn. Effects like fire, glowing, and flares are set here. How a particle is actually rendered depends on the current render and display modes.  
        PMODE_BLOB	    = 0x00000002,	    --> Draw a blob like in blob mode. Everything is given this in blob display mode, but can be set manually.  
        --#### These should be used in lua graphics functions to set how particles will be drawn. Effects like fire, glowing, and flares are set here. How a particle is actually rendered depends on the current render and display modes.  
        PMODE_BLUR	    = 0x00000004,	    --> Blur effect, used in fancy display mode. Given to all liquids without a graphics functions by default, if not this isn't set.  
        --#### These should be used in lua graphics functions to set how particles will be drawn. Effects like fire, glowing, and flares are set here. How a particle is actually rendered depends on the current render and display modes.  
        PMODE_GLOW	    = 0x00000008,	    --> Glow effect, used in elements like DEUT and TRON in fancy display mode, also given to radioactive elements.  
        --#### These should be used in lua graphics functions to set how particles will be drawn. Effects like fire, glowing, and flares are set here. How a particle is actually rendered depends on the current render and display modes.  
        PMODE_SPARK	    = 0x00000010,	    --> Draws a very light sparkle around a particle.  
        --#### These should be used in lua graphics functions to set how particles will be drawn. Effects like fire, glowing, and flares are set here. How a particle is actually rendered depends on the current render and display modes.  
        PMODE_FLARE	    = 0x00000020,	    --> Draws a flare around a particle, used by BOMB.  
        --#### These should be used in lua graphics functions to set how particles will be drawn. Effects like fire, glowing, and flares are set here. How a particle is actually rendered depends on the current render and display modes.  
        PMODE_LFLARE	= 0x00000040,	    --> Very large and bright flare, used by DEST when it hits something.  
        --#### These should be used in lua graphics functions to set how particles will be drawn. Effects like fire, glowing, and flares are set here. How a particle is actually rendered depends on the current render and display modes.  
        PMODE_ADD	    = 0x00000080,	    --> Like PMODE_FLAT, but adds color to a pixel, instead of overwriting it.  
        --#### These should be used in lua graphics functions to set how particles will be drawn. Effects like fire, glowing, and flares are set here. How a particle is actually rendered depends on the current render and display modes.  
        PMODE_BLEND	    = 0x00000100,	    --> Basically the same thing as PMODE_ADD, but has better OpenGL support  
        --#### These should be used in lua graphics functions to set how particles will be drawn. Effects like fire, glowing, and flares are set here. How a particle is actually rendered depends on the current render and display modes.  
        PSPEC_STICKMAN	= 0x00000200,	    --> Used by stickmen. Won't do anything unless the element actually is a stickman.  
        --#### These should be used in lua graphics functions to set how particles will be drawn. Effects like fire, glowing, and flares are set here. How a particle is actually rendered depends on the current render and display modes.  
        OPTIONS	        = 0x0000F000,	    --> A bitmask which can be used to check if a particle has any display options set.  
        --#### These should be used in lua graphics functions to set how particles will be drawn. Effects like fire, glowing, and flares are set here. How a particle is actually rendered depends on the current render and display modes.  
        NO_DECO	        = 0x00001000,	    --> Prevents decoration from being shown on an element.  
        --#### These should be used in lua graphics functions to set how particles will be drawn. Effects like fire, glowing, and flares are set here. How a particle is actually rendered depends on the current render and display modes.  
        DECO_FIRE	    = 0x00002000,	    --> Allows decoration to be drawn onto the fire effect. All gasses have this on by default.  
        --#### These should be used in lua graphics functions to set how particles will be drawn. Effects like fire, glowing, and flares are set here. How a particle is actually rendered depends on the current render and display modes.  
        FIREMODE	    = 0x00FF0000,	    --> A bitmask which can be used to check if a particle has any fire graphics set.  
        --#### These should be used in lua graphics functions to set how particles will be drawn. Effects like fire, glowing, and flares are set here. How a particle is actually rendered depends on the current render and display modes.  
        FIRE_ADD	    = 0x00010000,	    --> Adds a weak fire effect around an element. Does not support many colors like FIRE_BLEND does.  
        --#### These should be used in lua graphics functions to set how particles will be drawn. Effects like fire, glowing, and flares are set here. How a particle is actually rendered depends on the current render and display modes.  
        FIRE_BLEND	    = 0x00020000,	    --> Adds a stronger fire effect around an element. All gasses have this on by default.  
        --#### These should be used in lua graphics functions to set how particles will be drawn. Effects like fire, glowing, and flares are set here. How a particle is actually rendered depends on the current render and display modes.  
        EFFECT	        = 0xFF000000,	    --> A bitmask which can be used to check if a particle has any special effects set.  
        --#### These should be used in lua graphics functions to set how particles will be drawn. Effects like fire, glowing, and flares are set here. How a particle is actually rendered depends on the current render and display modes.  
        EFFECT_GRAVIN	= 0x01000000,	    --> Adds a PRTI effect. Won't work unless .life and .ctype are set properly in an update function.  
        --#### These should be used in lua graphics functions to set how particles will be drawn. Effects like fire, glowing, and flares are set here. How a particle is actually rendered depends on the current render and display modes.  
        EFFECT_GRAVOUT	= 0x02000000,	    --> Adds a PRTO effect. Won't work unless .life and .ctype are set properly in an update function.  
        --#### These should be used in lua graphics functions to set how particles will be drawn. Effects like fire, glowing, and flares are set here. How a particle is actually rendered depends on the current render and display modes.  
        EFFECT_LINES	= 0x04000000,	    --> Used by SOAP to draw lines between attached SOAP particles. Ignored by everything else.  
        --#### These should be used in lua graphics functions to set how particles will be drawn. Effects like fire, glowing, and flares are set here. How a particle is actually rendered depends on the current render and display modes.  
        EFFECT_DBGLINES	= 0x08000000,	    --> Draw lines between particles of the same type with similar temperatures. Used by WIFI and portals to draw lines between particles of the same channel when in debug mode.  

        --#### These are the values used and returned by ren.renderMode. They are combinations of the above values, and sometimes overlap. All source definitions also include OPTIONS and PSPEC_STICKMAN (so that options can always be set and stickmen are always rendered), but they are not listed here.  
        --> In source code `PMODE_SPARK | PMODE_FLARE | PMODE_LFLARE`  
        --> Used in all display modes except for heat, nothing, heat gradient, and life gradient. Turns on all basic effects like flares and portal effects.  
        RENDER_EFFE	= nil,   
        --#### These are the values used and returned by ren.renderMode. They are combinations of the above values, and sometimes overlap. All source definitions also include OPTIONS and PSPEC_STICKMAN (so that options can always be set and stickmen are always rendered), but they are not listed here.  
        --> In source code `PMODE_BLEND | FIREMODE`	  
        --> Used in fire, blob, and fancy display modes. Turns on all fire effects.  
        RENDER_FIRE	= 0x3f380,   
        --#### These are the values used and returned by ren.renderMode. They are combinations of the above values, and sometimes overlap. All source definitions also include OPTIONS and PSPEC_STICKMAN (so that options can always be set and stickmen are always rendered), but they are not listed here.  
        --> In source code `PMODE_ADD | PMODE_BLEND`	  
        --> Used in fancy display mode, so that radioactive elements glow.  
        RENDER_GLOW	= 0xf388,   
        --#### These are the values used and returned by ren.renderMode. They are combinations of the above values, and sometimes overlap. All source definitions also include OPTIONS and PSPEC_STICKMAN (so that options can always be set and stickmen are always rendered), but they are not listed here.  
        --> In source code `PMODE_ADD | PMODE_BLEND`	  
        --> Used in fancy display mode, to turn on the liquid blur effect.  
        RENDER_BLUR	= 0xf384,   
        --#### These are the values used and returned by ren.renderMode. They are combinations of the above values, and sometimes overlap. All source definitions also include OPTIONS and PSPEC_STICKMAN (so that options can always be set and stickmen are always rendered), but they are not listed here.  
        --> In source code `PMODE_ADD | PMODE_BLEND`	  
        --> Causes every particle to get PMODE_BLOB.  
        RENDER_BLOB	= 0xf382,   
        --#### These are the values used and returned by ren.renderMode. They are combinations of the above values, and sometimes overlap. All source definitions also include OPTIONS and PSPEC_STICKMAN (so that options can always be set and stickmen are always rendered), but they are not listed here.  
        --> In source code `PMODE_ADD | PMODE_BLEND | EFFECT_LINES`	  
        --> Used by every single display mode, turns on PMODE_FLAT so particles get displayed.  
        RENDER_BASC	= 0x400f381,   
        --#### These are the values used and returned by ren.renderMode. They are combinations of the above values, and sometimes overlap. All source definitions also include OPTIONS and PSPEC_STICKMAN (so that options can always be set and stickmen are always rendered), but they are not listed here.  
        --> In source code `PMODE_FLAT`	  
        --> Not used at all, but would make sure at least each individual pixel gets drawn.  
        RENDER_NONE	= 0xf201,   

        --#### These are the values used and returned by ren.displayMode. They can be set together, although no official display mode does this.  
        --> Cracker air display mode, used in alternate velocity display.  
        DISPLAY_AIRC =	0x00000001,	
        --#### These are the values used and returned by ren.displayMode. They can be set together, although no official display mode does this.  
        --> Used by pressure display mode.  
        DISPLAY_AIRP =	0x00000002,	
        --#### These are the values used and returned by ren.displayMode. They can be set together, although no official display mode does this.  
        --> Used by velocity display mode.  
        DISPLAY_AIRV =	0x00000004,	
        --#### These are the values used and returned by ren.displayMode. They can be set together, although no official display mode does this.  
        --> Used by heat display mode.  
        DISPLAY_AIRH =	0x00000008,	
        --#### These are the values used and returned by ren.displayMode. They can be set together, although no official display mode does this.  
        --> A bitmask which can be used to check if an air display mode is set.  
        DISPLAY_AIR	 =  0x0000000F,	
        --#### These are the values used and returned by ren.displayMode. They can be set together, although no official display mode does this.  
        --> Used by fancy display mode, turns on gravity lensing, causing newtonian gravity areas to bend light.  
        DISPLAY_WARP =	0x00000010,	
        --#### These are the values used and returned by ren.displayMode. They can be set together, although no official display mode does this.  
        --> Used by persistent display mode.  
        DISPLAY_PERS =	0x00000020,	
        --#### These are the values used and returned by ren.displayMode. They can be set together, although no official display mode does this.  
        --> Doesn't do anything at all, unless maybe OpenGL is on. Unclear what it does even then.  
        DISPLAY_EFFE =	0x00000040,	

        --#### These are the values used and returned by ren.colorMode. Only one can be set at a time, and they control which types of colors particles are drawn in.  
        --> Default colors, nothing gets changed.  
        COLOUR_DEFAULT = nil,	    
        --#### These are the values used and returned by ren.colorMode. Only one can be set at a time, and they control which types of colors particles are drawn in.  
        --> Render elements in heat display colors. Pink = hottest, Blue = coldest.  
        COLOUR_HEAT = nil,	        
        --#### These are the values used and returned by ren.colorMode. Only one can be set at a time, and they control which types of colors particles are drawn in.  
        --> Render elements in a greyscale gradient dependent on .life value.  
        COLOUR_LIFE = nil,	  
        --#### These are the values used and returned by ren.colorMode. Only one can be set at a time, and they control which types of colors particles are drawn in.      
        --> Render elements normally, but with a slight greyscale gradient dependent on a particle's temperature.  
        COLOUR_GRAD = nil,	
        --#### These are the values used and returned by ren.colorMode. Only one can be set at a time, and they control which types of colors particles are drawn in.        
        --> Remove all color changes from elements, elements get rendered in whichever color their element button is.  
        COLOUR_BASC = nil,	        
    }


    --```  
    --table ren.renderModes()  
    --ren.renderModes(table newModes)  
    --```  
    --If called with no arguments, returns a table containing the currently activated render modes. If called with a table argument, turns on all the render modes specified in the table. Render modes are typically used to change the way all particles render, display modes set extra added effects.  
    --Print out all current render modes in hex:  
    --```  
    --for k,v in pairs(ren.renderModes()) do  
    --	print(k,"0x"..bit.tohex(v))  
    --end  
    -->>1, 0x00fff380; 2, 0xff00f270; 3, 0x0400f381  
    --```  
    --Set the current render mode to a weird form of blob display  
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
    --Works exactly like rennder.renderModes(). If called with no arguments, returns a table containing the currently activated display modes. If called with a table argument, turns on all the display modes specified in the table. Render modes are typically used to change the way all particles render, display modes set extra added effects.  
    --Print out all current display modes in hex:  
    --```  
    --for k,v in pairs(ren.displayModes()) do  
    --	print(k,"0x"..bit.tohex(v))  
    --end  
    -->>1, 0x00000002; 2, 0x00000010  
    --```  
    --Set the current display mode to persistent with cracker velocity display  
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
    --This function takes one optional integer and sets which colour modes the currently appIying render mode uses. If the function is called with no arguments, it returns the current colour mode as an integer as well.  
    --A colour mode is basically a description of how particles are drawn. The other details which are considered when particles are drawn are fire mode, pixel mode and effect mode (rare cases like portals).   
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
    --This function takes one optional integer and sets which colour modes the currently appIying render mode uses. If the function is called with no arguments, it returns the current colour mode as an integer as well.  
    --A colour mode is basically a description of how particles are drawn. The other details which are considered when particles are drawn are fire mode, pixel mode and effect mode (rare cases like portals).  
    ---@return integer
    function renderer.colourMode() 
    end
    ---@param colourMode integer  
    function renderer.colourMode(colourMode) 
    end


    --```  
    --number ren.decorations()  
    --ren.decorations(number decoSetting)  
    --```  
    --If called with no arguments, returns a 0 or a 1 representing the current deco mode setting. If a number is passed in, turns decorations on or off.  
    ---@param decoSetting integer  
    function renderer.decorations(decoSetting)
    end
    ---@return integer
    function renderer.decorations()
    end


    --```  
    --number ren.grid()  
    --ren.grid(number gridSize)  
    --```  
    --If called with no arguments, returns the current grid size (normally set with 'g'). Grid sizes range from 0 (no grid) to 9. Each size increases the number of pixels between lines by 4.  
    --If an argument is passed in, sets the current grid size. There are no checks to make sure it is in the valid range, but if negative numbers are passed in it may cause strange behavior.  
    ---@param gridSize integer  
    function renderer.grid(gridSize)
    end
    ---@return integer
    function renderer.grid()
    end


    --```  
    --number ren.debugHUD()  
    --ren.debugHUD(number debugSetting)  
    --```  
    --If called with no arguments, returns a 0 or a 1 representing whether the debug HUD (normally set with 'd') is on or off. If a number is passed in, turns the debug HUD on or off.  
    ---@param debugSetting integer  
    function renderer.debugHUD(debugSetting)
    end
    ---@return integer
    function renderer.debugHUD()
    end

    
    --```  
    --number ren.showBrush()  
    --ren.showBrush(number brushSetting)  
    --```  
    --If called with no arguments, returns a 0 or a 1 representing whether the brush is currently shown. If a number is passed in, disables rendering the brush. This function is intended for recording scripts which want to hide the brush and other hud elements.  
    --
    ---@param brushSetting integer  
    function renderer.showBrush(brushSetting)
    end
    ---@return integer
    function renderer.showBrush()
    end

    --Not documented by the wiki. See this link in case it has been already added  
    --https://powdertoy.co.uk/Wiki/W/Lua_API:Renderer.html#renderer.depth3d  
    function renderer.depth3d(...) end

    --```  
    --ren.zoomEnabled(boolean zoomState)  
    --boolean ren.zoomEnabled()  
    --```  
    --If called with no arguments, returns a booleanean indicating whether the zoom window is open or not. If a number is passed in, it shows or hides the zoom window  
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
    --The zoom window displays the magnified image. If called with no arguments, returns 4 numbers: left top corner X position, left top corner Y position, the zoom factor and the inner window size in pixels. If arguments are passed then the zoom window will be moved to the specified X and Y coordinates (from its top left corner) and change its zoom factor.  
    ---@param x integer  
    ---@param y integer  
    ---@param zoomFactor integer  
    function renderer.zoomWindow(x, y, zoomFactor) 
    end
    ---@return integer x, integer y, integer zoomFactor, number windowSize
    function renderer.zoomWindow() 
    end

    -- idk if window size should be int TODO: uhh figure this out

    --```  
    --number, number, number ren.zoomScope()  
    --ren.zoomScope(number x, number y, number size)  
    --```  
    --The zoom scope defines the area where to zoom in. If called with no arguments, returns 3 numbers: left top corner X position, left top corner Y position and its size. If arguments are passed then the zoom scope will be moved to the specified X and Y coordinates (from its top left corner). It will also make it span the amount of pixels specified by the 'size' argument equally in width and height.  
    ---@return integer x, integer y, integer size
    function renderer.zoomScope() 
    end
    ---@param x integer  
    ---@param y integer  
    ---@param size integer  
    function renderer.zoomScope(x, y, size) 
    end
--#endregion


-- elem.*
--#region

    elements = {}

    --Doesnt include functions
    ---@alias Properties {Weight:number?, HotAir:number?, Properties:number?, HighTemperatureTransition:number?, LowPressureTransition:number?, AirLoss:number?, Gravity:number?, Name:string?, Colour:number?, Identifier:string?, PhotonReflectWavelengths:number?, Color:number?, NewtonianGravity:number?, Diffusion:number?, Advection:number?, Hardness:number?, HighPressureTransition:number?, HighPressure:number?, Loss:number?, MenuVisible:number?, LowTemperatureTransition:number?, MenuSection:number?, Collision:number?, DefaultProperties:table?, AirDrag:number?, HighTemperature:number?, LowTemperature:number?, Enabled:number?, HeatConduct:number?, Falldown:number?, Meltable:number?, LowPressure:number?, Explosive:number?, Temperature:number?, Description:string?, Flammable:number?}
    
    ---@alias Property
    ---|"Weight"
    ---|"HotAir"
    ---|"Properties"
    ---|"HighTemperatureTransition"
    ---|"LowPressureTransition"
    ---|"AirLoss"
    ---|"Gravity"
    ---|"Name"
    ---|"Colour"
    ---|"Identifier"
    ---|"PhotonReflectWavelengths"
    ---|"Color"
    ---|"NewtonianGravity"
    ---|"Diffusion"
    ---|"Advection"
    ---|"Hardness"
    ---|"HighPressureTransition"
    ---|"HighPressure"
    ---|"Loss"
    ---|"MenuVisible"
    ---|"LowTemperatureTransition"
    ---|"MenuSection"
    ---|"Collision"
    ---|"DefaultProperties"
    ---|"AirDrag"
    ---|"HighTemperature"
    ---|"LowTemperature"
    ---|"Enabled"
    ---|"HeatConduct"
    ---|"Falldown"
    ---|"Meltable"
    ---|"LowPressure"
    ---|"Explosive"
    ---|"Temperature"
    ---|"Description"
    ---|"Flammable"
    ---|"Update"
    ---|"Graphics"
    ---|"Create"
    ---|"ChangeType"

    --TODO: Figure out if any of those are ints

    -- `surround_space`	This is the number of particles with the same TYPE property in the Moore neighborhood surrounding the particle. Used primarily for GoL type elements.
    -- `nt`	This is the number of empty spaces in the Moore neighborhood surrounding the particle.
    ---@alias UpdateFunc fun(UPDATE_index:number, x:number, y:number, surround_space:number, nt:number): number|nil 

    ---@alias GraphicsFunc fun(GRAPHICS_index:number, r:number, g:number, b:number): number,number,number,number,number,number,number,number,number,number

    -- `v` This is an extra numeric property passed in sim.partCreate as part of the id number (currently bits 9 and above, counting from 0). It is effectively an extra multipurpose parameter for Create functions to handle however they like.
    ---@alias CreateFunc fun(CREATE_index:number, x:number, y:number, type:number, v:number)

    ---@alias ChangeTypeFunc fun(CHANGE_TYPE_index:number, x:number, y:number, type:number, new_type:number)

    ---@alias PropertyFunctions UpdateFunc|GraphicsFunc|CreateFunc|ChangeTypeFunc

    --```  
    --number elements.allocate(string group, string name)  
    --```  
    --Use this function to create a new element. This function will return the id of your element, and create a unique identifier that can be used to modify the properties later. The identifier is in the form GROUP_PT_NAME, where group is the name of the mod or script (or just anything unique, like your username), and name is the name of the element. For example, elements.allocate("mymod", "virus") would create the identifier MYMOD_PT_VIRUS.  
    --The identifier is added as a constant in the elements table, so elements.MYMOD_PT_VIRUS would be equivalent to the new element's id, and can be used as the elementID argument to any of the functions below.  
    --The new element is created with all the default properties, and won't be visible until you modify it to show up in the menu.  
    --Returns -1 on failure (there are no free spaces to create a new element).  
    ---@param group string  
    ---@param name string  
    ---@return integer
    function elements.allocate(group, name)
    end

    --```  
    --local myNewElement = elements.allocate("wiki", "expl")  
    --elements.element(myNewElement, elements.element(elements.DEFAULT_PT_WATR))  
    --elements.property(myNewElement, "Name", "EXPL")  
    --elements.property(myNewElement, "Description", "This is an example element from the Wiki")  
    --```  
    --In this example, the element properties for our new element (EXPL) are copied from WATR  
    --```  
    --local star = elements.allocate("ELEMENT", "STAR")  
    --elements.element(star, elements.element(elements.DEFAULT_PT_DMND))  
    --elements.property(star, "Name", "STAR")  
    --elements.property(star, "Description", "STAR. Enough Pressure Makes It Explode Into LAVA.")  
    --elements.property(star, "Colour", 0xFFFFFF)  
    --elements.property(star, "MenuSection", elem.SC_SOLIDS)  
    --elements.property(star, "HotAir", -0.009)  
    --elements.property(star, "Weight", 333)  
    --elements.property(star, "Temperature", 4556)  
    --elements.property(star, "HighPressure", 200)  
    --elements.property(star, "HighPressureTransition", elements.DEFAULT_PT_LAVA)  
    --local function graphics1(i, colr, colg, colb)   
    --	return 1,ren.FIRE_ADD,255,100,155,210,255,255,255,255  
    --end  
    --elements.property(star, "Graphics", graphics1)  
    --```  
    --Another Example, from an actual script. For more info on graphics functions, see the legacy api page  
    --```  
    --table elements.element(number elementID)  
    --```  
    --Returns a table containing all of an element's properties (Name, Description, etc)  
    ---@param elementID integer  
    ---@return Properties
    function elements.element(elementID)
    end
    --Sets the properties from the given table onto the element.  
    --These two functions are useful for copying or templating from already present elements, for example  
    ---@param elementID integer  
    ---@param properties Properties  
    function elements.element(elementID, properties)
    end


    --```  
    --object elements.property(number elementID, string property)  
    --```  
    --Gets the value of an element property  
    ---@param elementID integer  
    ---@param property Property|string    
    ---@return any
    function elements.property(elementID, property)
    end
    --```  
    --elements.property(number elementID, string property, object value)  
    --```  
    --Sets the value of an element property  
    -- replaceMethod applies only for property "Update"
    ---@param elementID integer  
    ---@param property Property|string  
    ---@param value number|string|PropertyFunctions|any
    ---@param replaceMethod ElemFuncReplace?
    function elements.property(elementID, property, value, replaceMethod)
    end

    --```  
    --elements.free(number elementID)  
    --```  
    --Free a previously allocated element, so it will disappear from the game. The element id will be freed and can used later by another script. elementID must be a non-default element (i.e you cannot free the default WATR element)  
    ---@param elementID integer  
    function elements.free(elementID)
    end


    --```  
    --elements.loadDefault(number elementID)  
    --```  
    --Reset an element to its original state before it was modified  
    ---@param elementID integer  
    function elements.loadDefault(elementID)
    end
    --```  
    --elements.loadDefault()  
    --```  
    --Resets all elements to the original state. This will also erase any elements created with any scripts, only the default elements will be available.  
    function elements.loadDefault()
    end
--#endregion

-- gfx.*
--#region
    
    graphics = {
        WIDTH = 629,
        HEIGHT = 424,
    }

    
    --```  
    --number, number graphics.textSize(string text)  
    --```  
    --Returns the width and height of the specified text.  
    ---@param text string  
    ---@return integer, integer 
    function graphics.textSize(text)
    end

    --```  
    --graphics.drawText(number x, number y, string text, [number r, number g, number b, [number a]])  
    --```  
    --Draws the specified text at (x,y). Providing the color is optional, if not provided defaults to white.  
    ---@param x integer  
    ---@param y integer  
    ---@param text string  
    ---@param r integer  
    ---@param g integer  
    ---@param b integer  
    ---@param a integer?  
    function graphics.drawText(x, y, text, r, g, b, a)
    end
    ---@param x number  
    ---@param y number  
    ---@param text string  
    function graphics.drawText(x, y, text)
    end

    --```  
    --graphics.drawLine(number x1, number y1, number x2, number y2, [number r, number g, number b, [number a]])  
    --```  
    --Draws a line from (x1,y1) to (x2,y2). Providing the color is optional, if not provided defaults to white.  
    ---@param x1 integer  
    ---@param y1 integer  
    ---@param x2 integer  
    ---@param y2 integer  
    ---@param r integer  
    ---@param g integer  
    ---@param b integer  
    ---@param a integer?  
    function graphics.drawLine(x1, y1, x2, y2, r, g, b, a)
    end
    ---@param x1 integer  
    ---@param y1 integer  
    ---@param x2 integer  
    ---@param y2 integer      
    function graphics.drawLine(x1, y1, x2, y2)
    end

    --```  
    --graphics.drawRect(number x, number y, number width, number height, [number r, number g, number b, [number a]])  
    --```  
    --Draws a hollow rectangle at (x,y) with the specified width and height. Providing the color is optional, if not provided defaults to white.  
    ---@param x integer  
    ---@param y integer  
    ---@param width integer  
    ---@param height integer  
    ---@param r integer  
    ---@param g integer  
    ---@param b integer  
    ---@param a integer?  
    function graphics.drawRect(x, y, width, height, r, g, b, a)
    end
    ---@param x integer  
    ---@param y integer  
    ---@param width integer  
    ---@param height integer  
    function graphics.drawRect(x, y, width, height)
    end

    --```  
    --graphics.fillRect(number x, number y, number width, number height, [number r, number g, number b, [number a]])  
    --```  
    --Draws a filled rectangle at (x,y) with the specified width and height. Providing the color is optional, if not provided defaults to white.  
    ---@param x number  
    ---@param y number  
    ---@param width number  
    ---@param height number  
    ---@param r integer  
    ---@param g integer  
    ---@param b integer  
    ---@param a integer?  
    function graphics.fillRect(x, y, width, height, r, g, b, a)
    end
    ---@param x number  
    ---@param y number  
    ---@param width number  
    ---@param height number  
    function graphics.fillRect(x, y, width, height)
    end

    --```  
    --graphics.drawCircle(number x, number y, number radiusW, number radiusH, [number r, number g, number b, [number a]])  
    --```  
    --Draws a hollow circle at (x,y) with radius of (radiusW,radiusH). Providing the color is optional, if not provided defaults to white.  
    ---@param x integer  
    ---@param y integer  
    ---@param radiusW integer  
    ---@param radiusH integer  
    ---@param r integer  
    ---@param g integer  
    ---@param b integer  
    ---@param a integer?  
    function graphics.drawCircle(x, y, radiusW, radiusH, r, g, b, a)
    end
    ---@param x integer  
    ---@param y integer  
    ---@param radiusW integer  
    ---@param radiusH integer  
    function graphics.drawCircle(x, y, radiusW, radiusH)
    end

    --```  
    --graphics.fillCircle(number x, number y, number radiusW, number radiusH, [number r, number g, number b, [number a]])  
    --```  
    --Draws a filled circle at (x,y) with radius of (radiusW,radiusH). Providing the color is optional, if not provided defaults to white.  
    ---@param x integer  
    ---@param y integer  
    ---@param radiusW integer  
    ---@param radiusH integer  
    ---@param r integer  
    ---@param g integer  
    ---@param b integer  
    ---@param a integer?  
    function graphics.fillCircle(x, y, radiusW, radiusH, r, g, b, a)
    end
    ---@param x integer  
    ---@param y integer  
    ---@param radiusW integer  
    ---@param radiusH integer  
    function graphics.fillCircle(x, y, radiusW, radiusH)
    end
    
    --```  
    --graphics.getColors(number color)  
    --```  
    --Converts color from hex. Return number r,g,b,a.  
    ---@param color integer  
    ---@return integer, integer, integer, integer
    function graphics.getColors(color)
    end


    --```  
    --graphics.getHexColor( [number r], [number g], [number b], [number a])  
    --```  
    --Converts color to hex.  
    ---@param r integer  
    ---@param g integer  
    ---@param b integer  
    ---@param a integer?
    ---@return integer  
    function graphics.getHexColor(r, g, b, a)
    end
    
    --```  
    --graphics.setClipRect(number x, number y, [number w, number h])
    --```  
    --Sets the clip rect used while drawing graphics to the screen. Graphics drawn outside the given rectangle will be clipped out. The default clip rect is the entire screen, and clip rects will be reset to this after every frame.  
    --Returns the old clip rect (x, y, w, h).
    ---@param x integer?  
    ---@param y integer?  
    ---@param w integer?  
    ---@param h integer?  
    ---@return integer x, integer y, integer w, integer h 
    function graphics.setClipRect(x, y, w, h)
    end


--#endregion

-- fs.*
--#region

    fileSystem = {}

    --```  
    --table fs.list(string folder)  
    --```  
    --Returns a table containing a list of files and folders in "folder"  
    ---@param folder string
    ---@return string[]  
    function fileSystem.list(folder)
    end

    --```  
    --booleanean fs.exists(string path)  
    --```  
    --Returns a booleanean indicating whether "path" exists as either a file or folder 
    ---@param path string  
    ---@return boolean
    function fileSystem.exists(path)
    end

    --```  
    --booleanean fs.isFile(string path)  
    --```  
    --Returns a booleanean indicating whether "path" exists as a file (i.e not a folder)  
    ---@param path string  
    ---@return boolean
    function fileSystem.isFile(path)
    end

    --```  
    --booleanean fs.isDirectory(string path)  
    --```  
    --Returns a booleanean indicating whether "path" exists as a folder (i.e not a file)  
    ---@param path string  
    ---@return boolean
    function fileSystem.isDirectory(path)
    end


    --```  
    --booleanean fs.makeDirectory(string path)  
    --```  
    --Creates the folder "path", this function is not recursive and won't create parent directories (makeDirectory("parent/child") will fail if "parent" does not exist). This function returns true on success and false on failure. 
    ---@param path string  
    ---@return boolean
    function fileSystem.makeDirectory(path)
    end

    --```  
    --booleanean fs.removeDirectory(string path)  
    --```  
    --Removes the empty folder specified by "path". This function returns true on success and false on failure.  
    ---@param path string  
    ---@return boolean
    function fileSystem.removeDirectory(path)
    end

    --```  
    --booleanean fs.removeFile(string path)  
    --```  
    --Removes the file "path". This function returns true on success and false on failure. 
    ---@param path string  
    ---@return boolean
    function fileSystem.removeFile(path)
    end

    --```  
    --booleanean fs.move(string path, string newPath)  
    --```  
    --Moves the file or folder specified by "path" to "newPath". This function returns true on success and false on failure. 
    ---@param path string  
    ---@param newPath string  
    ---@return boolean
    function fileSystem.move(path, newPath)
    end
    
    --```  
    --booleanean fs.copy(string path, string newPath)  
    --```  
    --Copies the file "path" to "newPath". This function returns true on success and false on failure.  
    ---@param path string  
    ---@param newPath string  
    ---@return boolean
    function fileSystem.copy(path, newPath)
    end
--#endregion

-- plat.*
--#region

    platform = {}

    --Returns information about the system
    ---@return string
    function platform.platform() end

    --Returns information about the system
    ---@return string
    function platform.ident() end

    --Returns information about the build
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
--#endregion

-- evt.*
--#region

    ---@alias Keycode
    ---|8          SDLK_BACKSPACE
    ---|9          SDLK_TAB
    ---|13         SDLK_RETURN 
    ---|27         SDLK_ESCAPE 
    ---|32         SDLK_SPACE 
    ---|33         SDLK_EXCLAIM 
    ---|34         SDLK_QUOTEDBL 
    ---|35         SDLK_HASH 
    ---|36         SDLK_DOLLAR 
    ---|37         SDLK_PERCENT 
    ---|38         SDLK_AMPERSAND 
    ---|39         SDLK_QUOTE 
    ---|40         SDLK_LEFTPAREN 
    ---|41         SDLK_RIGHTPAREN 
    ---|42         SDLK_ASTERISK 
    ---|43         SDLK_PLUS 
    ---|44         SDLK_COMMA 
    ---|45         SDLK_MINUS 
    ---|46         SDLK_PERIOD 
    ---|47         SDLK_SLASH 
    ---|48         SDLK_0 
    ---|49         SDLK_1 
    ---|50         SDLK_2 
    ---|51         SDLK_3 
    ---|52         SDLK_4 
    ---|53         SDLK_5 
    ---|54         SDLK_6 
    ---|55         SDLK_7 
    ---|56         SDLK_8 
    ---|57         SDLK_9 
    ---|58         SDLK_COLON 
    ---|59         SDLK_SEMICOLON 
    ---|60         SDLK_LESS 
    ---|61         SDLK_EQUALS 
    ---|62         SDLK_GREATER 
    ---|63         SDLK_QUESTION 
    ---|64         SDLK_AT 
    ---|91         SDLK_LEFTBRACKET 
    ---|92         SDLK_BACKSLASH 
    ---|93         SDLK_RIGHTBRACKET 
    ---|94         SDLK_CARET 
    ---|95         SDLK_UNDERSCORE 
    ---|96         SDLK_BACKQUOTE 
    ---|97         SDLK_a 
    ---|98         SDLK_b 
    ---|99         SDLK_c 
    ---|100        SDLK_d 
    ---|101        SDLK_e 
    ---|102        SDLK_f 
    ---|103        SDLK_g 
    ---|104        SDLK_h 
    ---|105        SDLK_i 
    ---|106        SDLK_j 
    ---|107        SDLK_k 
    ---|108        SDLK_l 
    ---|109        SDLK_m 
    ---|110        SDLK_n 
    ---|111        SDLK_o 
    ---|112        SDLK_p 
    ---|113        SDLK_q 
    ---|114        SDLK_r 
    ---|115        SDLK_s 
    ---|116        SDLK_t 
    ---|117        SDLK_u 
    ---|118        SDLK_v 
    ---|119        SDLK_w 
    ---|120        SDLK_x 
    ---|121        SDLK_y 
    ---|122        SDLK_z 
    ---|127        SDLK_DELETE 
    ---|1073741881 SDLK_CAPSLOCK 
    ---|1073741882 SDLK_F1 
    ---|1073741883 SDLK_F2 
    ---|1073741884 SDLK_F3 
    ---|1073741885 SDLK_F4 
    ---|1073741886 SDLK_F5 
    ---|1073741887 SDLK_F6 
    ---|1073741888 SDLK_F7 
    ---|1073741889 SDLK_F8 
    ---|1073741890 SDLK_F9 
    ---|1073741891 SDLK_F10 
    ---|1073741892 SDLK_F11 
    ---|1073741893 SDLK_F12 
    ---|1073741894 SDLK_PRINTSCREEN 
    ---|1073741895 SDLK_SCROLLLOCK 
    ---|1073741896 SDLK_PAUSE 
    ---|1073741897 SDLK_INSERT 
    ---|1073741898 SDLK_HOME 
    ---|1073741899 SDLK_PAGEUP 
    ---|1073741901 SDLK_END 
    ---|1073741902 SDLK_PAGEDOWN 
    ---|1073741903 SDLK_RIGHT 
    ---|1073741904 SDLK_LEFT 
    ---|1073741905 SDLK_DOWN 
    ---|1073741906 SDLK_UP 
    ---|1073741907 SDLK_NUMLOCKCLEAR 
    ---|1073741908 SDLK_KP_DIVIDE 
    ---|1073741909 SDLK_KP_MULTIPLY 
    ---|1073741910 SDLK_KP_MINUS 
    ---|1073741911 SDLK_KP_PLUS 
    ---|1073741912 SDLK_KP_ENTER 
    ---|1073741913 SDLK_KP_1 
    ---|1073741914 SDLK_KP_2 
    ---|1073741915 SDLK_KP_3 
    ---|1073741916 SDLK_KP_4 
    ---|1073741917 SDLK_KP_5 
    ---|1073741918 SDLK_KP_6 
    ---|1073741919 SDLK_KP_7 
    ---|1073741920 SDLK_KP_8 
    ---|1073741921 SDLK_KP_9 
    ---|1073741922 SDLK_KP_0 
    ---|1073741923 SDLK_KP_PERIOD

    --TODO: Scancode list

    ---@alias MouseButton
    ---|1 LEFT CLICK
    ---|2 MIDDLE CLICK
    ---|3 RIGHT CLICK
    ---|integer EXTRA BUTTONS

    ---@enum EventType
    event = {
        --### keypress  
        --> This event is sent every time a key is pressed, and continuously re-sent if they key is held down. This event should be used if you want to have a key shortcut; The textinput event should be used instead if you want to handle text input / Unicode.  
        --> This event can be canceled  
        --> Arguments: key, scan, repeat, shift, ctrl, alt  
        -->> key is the key code, a number that is usually the ascii value for the key, but for non-printable characters it may be a high number. You can find a list of key codes here: https://wiki.libsdl.org/SDLKeycodeLookup  
        -->> scan is the scan code. This is a number that represents the physical location of a key on a keyboard. You can find a list of scan codes here: https://wiki.libsdl.org/SDLScancodeLookup  
        -->> repeat is a booleanean that tells whether this is a key repeat event (sent every so often when the key is held down). You may want to ignore this event when it is just a key repeat event  
        -->> shift / ctrl / alt are booleaneans that will tell you whether those modifiers are currently held  
        keypress = 0,

        --### keyrelease   
        --> This event is sent every time a key is released  
        --> This event can be canceled  
        --> Arguments: key, scan, repeat, shift, ctrl, alt  
        -->> These arguments mean exactly the same thing as for keypress events. Repeat will always be false.  
        keyrelease = 1,

        --### textinput  
        --> This event is sent every time text is input. The text will be sent as a string, and may be more than one character or contain Unicode.  
        --> Arguments: text  
        textinput = 2,

        -- Not documented on the wiki 
        -- TODO:uhh write documentation lol
        --### textediting  
        --> Arguments: text  
        textediting = 3,

        --### mousedown  
        --> This event is sent whenever the mouse is clicked.  
        --> This event can be canceled  
        --> Arguments: x, y, button  
        -->> x and y will not be adjusted for the zoom window. See sim.adjustCoords for that. Coordinates may be outside of the simulation bounds (clicks outside the simulation area are still sent)  
        -->> button is the mouse button pressed. 1 is left click, 2 is middle click, 3 is right click. There may also be higher mouse buttons like 4 and 5.  
        mousedown = 4,

        --### mouseup  
        --> This event is sent whenever the mouse is released. There are also other some special cases this event may be sent,  
        --> This event can be canceled (only when reason = 0)  
        --> Arguments: x, y, button, reason  
        -->> x, y, and button function the same as the mousedown event  
        -->> reason is a number that describes what type of mouseup event this is (basically, hacks we sent mouseup events on anyway). reason 0 is for normal mouseup events. reason 1 is used when another interface is opened and a blur event is sent. This is how tpt ensures that the mouse isn't "stuck" down forever if you release the mouse after opening another interface. reason 2 is used when the mouse moves inside or outside of the zoom window. This is how tpt cancels mouse drawing with zoom windows to ensure a big line isn't drawn across the screen. The normal reason = 0 event will still be sent later.  
        mouseup = 5,

        --### mousemove  
        --> This event is sent every time the mouse is moved. It is only sent when the mouse is inside the tpt window, unless the mouse is held, in which case it can also be sent outside of the tpt window until the mouse is released. Coordinates from outside the tpt window bounds (including negative coordinates) can be sent in that case.  
        --> This event can be canceled  
        --> Arguments: x, y, dx, dy  
        -->> x and y are the mouse coordinates. dx and dy are the diff from the previous coordinates to the current ones.  
        mousemove = 6,

        --### mousewheel  
        --> This event is sent whenever the mousewheel is scrolled.  
        --> This event can be canceled  
        --> Arguments: x, y, d  
        -->> x and y are the mouse position where the wheel was scrolled  
        -->> d is the distance the mouse was scrolled. On nearly all mice this will be 1 or -1, but in certain situations it may be higher. You most likely want to treat higher values as 1 or -1 anyway. Horizontal scrolling is not supported at the moment, in the meantime d will be 0 for horizontal scrolling.  
        mousewheel = 7,

        --### tick  
        --> This event is sent once per frame. It is sent after the simulation frame finishes and everything is drawn to the screen.  
        tick = 8,

        --### blur  
        --> This event is sent whenever a blocking interface (such as the save browser or the console) is opened. Lua scripts don't function in those interfaces, so this event can be used to detect when the lua script is about to stop receiving any events during that time.  
        blur = 9,

        --### close  
        --> This event is sent whenever the tpt window is about to close.  
        close = 10,

        --### beforesim  
        --> This event is sent once per frame, but only if the sim is unpaused or being stepped through using framestep or subframe particle debugging. It is sent before any particle simulation or air updates have been done.
        beforesim = 11,

        --### aftersim  
        --> This event is sent once per frame, but only if the sim is unpaused or being stepped through using framestep or subframe particle debugging. It is sent after all particles have been simulated.
        aftersim = 12,
    }

    --TODO add mouse up reason alias

    ---@alias KeyPressCallback fun(KEYPRESS_key: Keycode?, scan: integer?, rep: boolean?, shift: boolean?, ctrl: boolean?, alt: boolean?): boolean?
    ---@alias KeyReleaseCallback fun(KEYRELEASE_key: Keycode?, scan: integer?, rep: string?, shift: boolean?, ctrl: boolean?, alt: boolean?): boolean?
    ---@alias TextInputCallback fun(TEXTINPUT_text: string?): boolean?
    ---@alias TextEditingCallback fun(TEXT_EDITING_text: string?): boolean?
    ---@alias MouseDownCallback fun(MOUSE_DOWN_x: integer?, y: integer?, button: MouseButton?): boolean?
    ---@alias MouseUpCallback fun(MOUSE_UP_x: integer?, y: integer?, button: MouseButton?, reason: integer?): boolean?
    ---@alias MouseMoveCallback fun(MOUSE_MOVE_x: integer?, y: integer?, dx: integer?, dy: integer?): boolean?
    ---@alias MouseWheelCallback fun(MOUSE_WHEEL_x: integer?, y: integer?, d: integer?): boolean?
    --Rest is classified under function
       

    ---@alias EventCallback function|KeyPressCallback|KeyReleaseCallback|TextInputCallback|TextEditingCallback|MouseDownCallback|MouseUpCallback|MouseMoveCallback|MouseWheelCallback


    --```  
    --event.register(eventType, eventHandler)  
    --```  
    --Registers an event handler for a certain type of event. See the list of constants at the bottom of the page for possible events you can listen to. The constants exist under the event namespace, not as strings. Returns eventHandler, in case it's a lambda function and you want to unregister it later.  
    --The event handler will be called with a varying number of arguments, depending on which type of event is being handled. Certain events can also be canceled by returning false from the event.  
    --**Example:**  
    --```  
    --event.register(event.mousedown, function(x, y) print("mouse clicked at " .. x .. "," .. y) end)  
    --```  
    ---@param eventType EventType
    ---@param eventHandler EventCallback
    function event.register(eventType, eventHandler) end

    --```  
    --event.unregister(eventType, eventHandler)  
    --```  
    --Unregister a previously registered event handler. Has no effect of this function wasn't registered or wasn't registered under this event type.  
    ---@param eventType EventType
    ---@param eventHandler EventCallback
    function event.unregister(eventType, eventHandler) end

    --```  
    --event.getmodifiers()  
    --```  
    --Gets the current keyboard modifier state. Includes bits describing whether shift, ctrl, alt, caps lock, num lock, and other modifiers are pressed / set.  
    ---@return integer
    function event.getmodifiers() 
    end
--#endregion

-- http.*
--#region

    http = {}

    ---@class HTTPRequest
    HTTPRequest = {}

    --Returns one of the following:  
    -- - "running" if the request hasn't finished yet;  
    -- - "done" if the request has finished and the response body is ready to be read;  
    -- - "dead" if the request is dead, i.e. if it has been cancelled or if the response body has been read.  
    ---@return "running"|"done"|"dead"
    function HTTPRequest:status()
    end

    --If the request is not dead, returns the size of the response body in bytes in the first return value (-1 if the size is not known), and the number of bytes received so far in the second. If the request is dead, returns nothing.  
    ---@return integer|nil, integer|nil
    function HTTPRequest:progress()
    end

    --Cancels the request. Does nothing if the request is dead  
    function HTTPRequest:cancel()
    end

    --Finishes the request and returns the response body and the status code. Call this only when HTTPRequest:status returns "done". Does and returns nothing if the request is dead.  
    --Non-standard status codes of note are 601, which is returned by plain HTTP requests if TPT is built with ENFORCE_HTTPS, and 604, which is returned by all requests if TPT is built with NOHTTP. Note that both codes may be returned for other reasons.  
    ---@return string, integer
    function HTTPRequest:finish()
    end

    --```  
    --HTTPRequest http.get(string uri, [table headers])  
    --```  
    --Constructs an HTTPRequest object and starts the underlying GET request immediately with the URI and headers supplied. The optional table argument is a collection of string key and string value pairs.  
    ---@param uri string  
    ---@param headers table?  
    ---@return HTTPRequest
    function http.get(uri, headers)
    end

    --```  
    --HTTPRequest http.post(string uri, table post_params, [table headers])  
    --```  
    --Same as http.get, except the underlying request is a POST. Post parameters are passed in the extra table argument, a collection of string key and string value pairs.  
    ---@param uri string  
    ---@param postParams table  
    ---@param headers table?  
    ---@return HTTPRequest
    function http.post(uri, postParams, headers)
    end
--#endregion

-- bit.*
--#region

    bit = {}

    --```
    --bit.tobit(number input)
    --```
    -- Turns a number into something usable by the rest of the binary utility functions.  
    -- It converts the number into a better form (what C deems to be a signed 32-bit int) to be used by the other bit functions. If you call one of the functions below yourself however, you do not need to use this function, as the below functions already use this in their code.
    -- **Examples:**
    --```
    -- bit.tobit(100) --> 100
    -- bit.tobit(-100) --> -100
    -- bit.tobit(2147483647) --> bit.tobit(2^31 - 1) = 2147483647
    -- bit.tobit(2147483648) --> bit.tobit(2^31) = -2147483648
    --```
    ---@param input integer
    ---@return integer
    function bit.tobit(input)    
    end

    --```
    --bit.tohex(number input, number length)
    --```
    -- By default, length is 8, if you leave it out.  
    -- Converts its first argument to a hexadecimal representation. Returns a string.  
    --
    -- How many hexadecimal digits to end up with is specified by the length argument. The length argument can also be negative, which specifies that the end result should have all-caps letters instead of small letters.
    -- **Examples:**
    --```
    -- bit.tohex(1) --> "00000001"
    -- bit.tohex(0xdeadbeef) --> "deadbeef"
    -- bit.tohex(15, 2) --> "0f"
    -- bit.tohex(0xdeadbeef, 2) --> "ef"
    -- bit.tohex(0xdeadbeef, -4) --> "BEEF"
    -- bit.tohex(0xdeadbeef, 25) --> "deadbeef"
    --```
    ---@param input integer
    ---@param length integer?
    ---@return string
    function bit.tohex(input, length)    
    end

    --```
    --bit.bnot(number input)
    --```
    --Returns the bitwise NOT from its argument.  
    --What happens during a bitwise NOT looks kinda like this: you start off with a value like 25 (::00011001) and you flip every bit specially and return the value, so...
    -- **Example:**
    --```
    -- ~ 0000 0000  0000 0000  0000 0000  0001 1001
    -- = 1111 1111  1111 1111  1111 1111  1110 0110
    --```
    ---@param input integer
    ---@return integer
    function bit.bnot(input)    
    end

    --```
    --bit.band(number input, [number input...])
    --```
    --Returns the binary AND of all its arguments combined.  
    --A binary AND is an operation that requires two numbers: the only bits that remain in the return value are ones that occur in both of the numbers. This is an easy way to pick out a single byte from a "bit string" - an integer that is actually used as a row of bits that can be used as boolean values. You can then store 32 booleans in a single int, whereas usually a single boolean is a single int!
    -- **Example:**
    --```
    -- :: 0001 1001 & 
    -- :: 0011 0011 & 
    -- :: 0001 1010
    --  = 0001 0000
    --```
    ---@param ... integer
    ---@return integer
    function bit.band(...)    
    end

    --```
    --bit.bor(number input, [number input...])
    --```
    --Returns the binary inclusive OR of all its arguments combined.  
    --Binary OR is really simple: if one of the arguments has a bit there, then the end result has a bit there too. This is also a simple way to deal with flags - you'll know that a bit will be turned on if you pass it through a binary OR. Binary OR happens like so:
    -- **Example:**
    --```
    -- :: 0001 1001 |
    -- :: 0011 1101 |
    -- :: 0100 1000
    --  = 0111 1101
    --```

    ---@param ... integer
    ---@return integer
    function bit.bor(...)    
    end

    --```
    --bit.xor(number input, [number input...])
    --```
    --Returns the binary exclusive OR of all its arguments combined.  
    --Binary exclusive OR or XOR for short is interesting: the end result's bit only gets toggled on when only one of the arguments has this bit toggled on. For flags, you can utilize it to toggle a bit - if it's on it will be off and if it's off it'll be on.
    -- **Example:**
    --```
    -- :: 0011 0011 ^
    -- :: 0010 1001 ^
    -- :: 1100 1100 
    --  = 1101 0110
    --```
    ---@param ... integer
    ---@return integer
    function bit.xor(...)    
    end

    --```
    --bit.lshift(number input, number shift)
    --```
    -- Shifts the input bits to the left by (shift) bits, replacing empty cells with 0 and discarding overflowing cells.  
    -- Left shifting is something really easy to imagine: every bit just gets moved once (or more) to the left and the ends are replaced with 0. If you have a bit at the far left end it gets eaten and is lost forever. Not to worry usually though.  
    -- Another great utilization of left shifting is that it's a really quick way of multiplying a number by two for some times. Shifting to the left by two is the same as multiplying a number by four.  
    --```
    -- :: 0000 0010 << 2
    --  = 0000 1000
    --```
    -- **Examples:**
    --```
    -- bit.lshift(2, 2) --> 8
    -- bit.lshift(2, 34) --> 8
    --```
    -- Important note: the shift count has to be between 1 and 32. Otherwise the number will be modulus-ed to it.
    ---@param input integer
    ---@param shift integer
    ---@return integer
    function bit.lshift(input, shift)    
    end

    -- ```
    -- bit.rshift(number input, number shift)
    -- ```
    -- Shifts the input bits to the right by (shift) bits, replacing empty cells with 0 and discarding overflowing cells.  
    -- Right shifting is something really easy to imagine: every bit just gets moved once (or more) to the right and the ends are replaced with 0. If you have a bit at the far right end it gets eaten and is lost forever. Not to worry usually though.  
    -- Another great utilization of right shifting is that it's a really quick way of dividing a number by two for some times. Shifting to the right by two is the same as dividing a number by four. Note that this will also move the sign bit. Which is what arithmetic right shift does not in fact do.
    -- ```
    --   1111 1111 :: >> 2
    -- = 0011 1111  1100 0000 ::
    -- ```
    -- **Examples:**
    -- ```
    -- bit.rshift(-2, 5) --> 134217727
    -- bit.rshift(4, 1) --> 2
    -- bit.rshift(4, 33) --> 2 
    -- ```
    -- Important note: the shift count has to be between 1 and 32. Otherwise the number will be modulus-ed to it.
    ---@param input integer
    ---@param shift integer
    ---@return integer
    function bit.rshift(input, shift)    
    end

    -- ```
    -- bit.arshift(number input, number shift)
    -- ```
    -- Shifts the input bits to the right by (shift) bits, copying over the sign bit for the new bits added from the left.  
    -- So the solution to our right shifting problem is that we need to add ones instead of zeros to the left side if we shift from the right. This keeps the sign right in place and still allows us to shift all we want.  
    -- ```
    --   1001 1001  0000 0000 :: >>> 2
    -- = 1110 0110  0100 0000 ::
    -- ```
    -- Examples:
    -- ```
    -- bit.arshift(-4, 1) --> -2
    -- bit.arshift(-32, 5) --> -1
    -- bit.arshift(32, 5) --> 1
    -- ```
    -- Important note: the shift count has to be between 1 and 32. Otherwise the number will be modulus-ed to it.  
    ---@param input integer
    ---@param shift integer
    ---@return integer
    function bit.arshift(input, shift)    
    end

    -- ```
    -- bit.rol(number input, number bits)
    -- ```
    -- ```
    -- bit.ror(number input, number bits)
    -- ```
    -- Exactly like bit shifting, except it copies the bits from the right to the bits on the left instead of just feasting upon them.
    -- ```
    -- :: 0000 1111 ROR 2
    --  = 1100 0000 :: 0000 0011
    -- :: 1100 0011 1100 0011 ROR 2
    --  = 1111 0000 1111 0000 
    -- ```
    -- Important note: the rotation count has to be between 1 and 32. Otherwise the number will be modulus-ed to it.
    ---@param input integer
    ---@param bits integer
    ---@return integer
    function bit.rol(input, bits)    
    end
    -- ```
    -- bit.rol(number input, number bits)
    -- ```
    -- ```
    -- bit.ror(number input, number bits)
    -- ```
    -- Exactly like bit shifting, except it copies the bits from the right to the bits on the left instead of just feasting upon them.
    -- ```
    -- :: 0000 1111 ROR 2
    --  = 1100 0000 :: 0000 0011
    -- :: 1100 0011 1100 0011 ROR 2
    --  = 1111 0000 1111 0000 
    -- ```
    -- Important note: the rotation count has to be between 1 and 32. Otherwise the number will be modulus-ed to it.
    ---@param input integer
    ---@param bits integer
    ---@return integer
    function bit.ror(input, bits)    
    end

    -- ```
    -- bit.bswap(number input)
    -- ```
    -- Swaps the byte order of the argument.
    -- 
    -- In a few places, TPT uses weird reverse-byte-order numbers, such as TPT saves in the OPS 1 format. This function makes things easier and just flips the bytes for you.
    -- ```
    --   0110 1010 0101 1001
    -- = 1001 0101 1010 0110
    -- ```
    -- Examples:
    -- ```
    -- bit.tohex(bit.bswap(0x01020304)) --> "04030201"
    -- bit.tohex(bit.bswap(0xdeadbeef), -8) --> "EFBEADDE"
    -- bit.bswap(5) --> 83886080
    -- ```
    ---@param input integer
    ---@return integer
    function bit.bswap(input)    
    end
--#endregion

ui = interface
sim = simulation
ren = renderer
elem = elements
gfx = graphics
fs = fileSystem
plat = platform
evt = event

simulation.XRES = 612
simulation.YRES = 384
simulation.CELL = 4
simulation.NT = -1
simulation.ST = 512
simulation.ITH = 10000
simulation.ITL = -1
simulation.IPH = 257
simulation.IPL = -257
simulation.PT_NUM = 512
simulation.R_TEMP = 22
simulation.MAX_TEMP = 9999
simulation.MIN_TEMP = 0
simulation.NUM_PARTS = nil

simulation.TOOL_HEAT = 0
simulation.TOOL_COOL = 1
simulation.TOOL_AIR = 2
simulation.TOOL_VAC = 3
simulation.TOOL_PGRV = 4
simulation.TOOL_NGRV = 5
simulation.TOOL_MIX = 6
simulation.TOOL_CYCL = 7
simulation.TOOL_WIND = 10

simulation.DECO_DRAW = 0
simulation.DECO_CLEAR = 1
simulation.DECO_ADD = 2
simulation.DECO_SUBTRACT = 3
simulation.DECO_MULTIPLY = 4
simulation.DECO_DIVIDE = 5
simulation.DECO_SMUDGE = 6

simulation.FIELD_TYPE = 0
simulation.FIELD_LIFE = 1
simulation.FIELD_CTYPE = 2
simulation.FIELD_X = 3
simulation.FIELD_Y = 4
simulation.FIELD_VX = 5
simulation.FIELD_VY = 6
simulation.FIELD_TEMP = 7
simulation.FIELD_FLAGS = 8
simulation.FIELD_TMP = 9
simulation.FIELD_TMP2 = 10
simulation.FIELD_DCOLOUR = 11
simulation.FIELD_PAVG0 = 12
simulation.FIELD_PAVG1 = 13

simulation.PMAPMASK = 511
simulation.PMAPBITS = 9


elements.TYPE_PART = 1
elements.TYPE_LIQUID = 2
elements.TYPE_SOLID = 4
elements.TYPE_GAS = 8
elements.TYPE_ENERGY = 16

elements.PROP_DRAWONCTYPE = 0
elements.PROP_CONDUCTS = 32
elements.PROP_BLACK = 64
elements.PROP_NEUTPENETRATE = 128
elements.PROP_NEUTABSORB = 256
elements.PROP_NEUTPASS = 512
elements.PROP_DEADLY = 1024
elements.PROP_HOT_GLOW = 2048
elements.PROP_LIFE = 4096
elements.PROP_RADIOACTIVE = 8192
elements.PROP_LIFE_DEC = 16384
elements.PROP_LIFE_KILL = 32768
elements.PROP_LIFE_KILL_DEC = 65536
elements.PROP_SPARKSETTLE = 131072
elements.PROP_NOAMBHEAT = 262144
elements.PROP_NOCTYPEDRAW = 1048576

elements.DEFAULT_PT_NONE = 0 
elements.DEFAULT_PT_DUST = 1 
elements.DEFAULT_PT_WATR = 2 
elements.DEFAULT_PT_OIL = 3 
elements.DEFAULT_PT_FIRE = 4 
elements.DEFAULT_PT_STNE = 5 
elements.DEFAULT_PT_LAVA = 6 
elements.DEFAULT_PT_GUN = 7 
elements.DEFAULT_PT_NITR = 8 
elements.DEFAULT_PT_CLNE = 9 
elements.DEFAULT_PT_GAS = 10 
elements["DEFAULT_PT_C-4"] = 11 
elements.DEFAULT_PT_GOO = 12 
elements.DEFAULT_PT_ICE = 13 
elements.DEFAULT_PT_METL = 14 
elements.DEFAULT_PT_SPRK = 15 
elements.DEFAULT_PT_SNOW = 16 
elements.DEFAULT_PT_WOOD = 17 
elements.DEFAULT_PT_NEUT = 18 
elements.DEFAULT_PT_PLUT = 19 
elements.DEFAULT_PT_PLNT = 20 
elements.DEFAULT_PT_ACID = 21 
elements.DEFAULT_PT_VOID = 22 
elements.DEFAULT_PT_WTRV = 23 
elements.DEFAULT_PT_CNCT = 24 
elements.DEFAULT_PT_DSTW = 25 
elements.DEFAULT_PT_SALT = 26 
elements.DEFAULT_PT_SLTW = 27 
elements.DEFAULT_PT_DMND = 28 
elements.DEFAULT_PT_BMTL = 29 
elements.DEFAULT_PT_BRMT = 30 
elements.DEFAULT_PT_PHOT = 31 
elements.DEFAULT_PT_URAN = 32 
elements.DEFAULT_PT_WAX = 33 
elements.DEFAULT_PT_MWAX = 34 
elements.DEFAULT_PT_PSCN = 35 
elements.DEFAULT_PT_NSCN = 36 
elements.DEFAULT_PT_LN2 = 37 
elements.DEFAULT_PT_INSL = 38 
elements.DEFAULT_PT_VACU = 39 
elements.DEFAULT_PT_VENT = 40 
elements.DEFAULT_PT_RBDM = 41 
elements.DEFAULT_PT_LRBD = 42 
elements.DEFAULT_PT_NTCT = 43 
elements.DEFAULT_PT_SAND = 44 
elements.DEFAULT_PT_GLAS = 45 
elements.DEFAULT_PT_PTCT = 46 
elements.DEFAULT_PT_BGLA = 47 
elements.DEFAULT_PT_THDR = 48 
elements.DEFAULT_PT_PLSM = 49 
elements.DEFAULT_PT_ETRD = 50 
elements.DEFAULT_PT_NICE = 51 
elements.DEFAULT_PT_NBLE = 52 
elements.DEFAULT_PT_BTRY = 53 
elements.DEFAULT_PT_LCRY = 54 
elements.DEFAULT_PT_STKM = 55 
elements.DEFAULT_PT_SWCH = 56 
elements.DEFAULT_PT_SMKE = 57 
elements.DEFAULT_PT_DESL = 58 
elements.DEFAULT_PT_COAL = 59 
elements.DEFAULT_PT_LOXY = 60 
elements.DEFAULT_PT_OXYG = 61 
elements.DEFAULT_PT_INWR = 62 
elements.DEFAULT_PT_YEST = 63 
elements.DEFAULT_PT_DYST = 64 
elements.DEFAULT_PT_THRM = 65 
elements.DEFAULT_PT_GLOW = 66 
elements.DEFAULT_PT_BRCK = 67 
elements.DEFAULT_PT_CFLM = 68 
elements.DEFAULT_PT_FIRW = 69 
elements.DEFAULT_PT_FUSE = 70 
elements.DEFAULT_PT_FSEP = 71 
elements.DEFAULT_PT_AMTR = 72 
elements.DEFAULT_PT_BCOL = 73 
elements.DEFAULT_PT_PCLN = 74 
elements.DEFAULT_PT_HSWC = 75 
elements.DEFAULT_PT_IRON = 76 
elements.DEFAULT_PT_MORT = 77 
elements.DEFAULT_PT_LIFE = 78 
elements.DEFAULT_PT_DLAY = 79 
elements.DEFAULT_PT_CO2 = 80 
elements.DEFAULT_PT_DRIC = 81 
elements.DEFAULT_PT_BUBW = 82 
elements.DEFAULT_PT_STOR = 83 
elements.DEFAULT_PT_PVOD = 84 
elements.DEFAULT_PT_CONV = 85 
elements.DEFAULT_PT_CAUS = 86 
elements.DEFAULT_PT_LIGH = 87 
elements.DEFAULT_PT_TESC = 88 
elements.DEFAULT_PT_DEST = 89 
elements.DEFAULT_PT_SPNG = 90 
elements.DEFAULT_PT_RIME = 91 
elements.DEFAULT_PT_FOG = 92 
elements.DEFAULT_PT_BCLN = 93 
elements.DEFAULT_PT_LOVE = 94 
elements.DEFAULT_PT_DEUT = 95 
elements.DEFAULT_PT_WARP = 96 
elements.DEFAULT_PT_PUMP = 97 
elements.DEFAULT_PT_FWRK = 98 
elements.DEFAULT_PT_PIPE = 99 
elements.DEFAULT_PT_FRZZ = 100 
elements.DEFAULT_PT_FRZW = 101 
elements.DEFAULT_PT_GRAV = 102 
elements.DEFAULT_PT_BIZR = 103 
elements.DEFAULT_PT_BIZG = 104 
elements.DEFAULT_PT_BIZS = 105 
elements.DEFAULT_PT_INST = 106 
elements.DEFAULT_PT_ISOZ = 107 
elements.DEFAULT_PT_ISZS = 108 
elements.DEFAULT_PT_PRTI = 109 
elements.DEFAULT_PT_PRTO = 110 
elements.DEFAULT_PT_PSTE = 111 
elements.DEFAULT_PT_PSTS = 112 
elements.DEFAULT_PT_ANAR = 113 
elements.DEFAULT_PT_VINE = 114 
elements.DEFAULT_PT_INVS = 115 
elements.DEFAULT_PT_EQVE = 116 
elements.DEFAULT_PT_SPWN2 = 117 
elements.DEFAULT_PT_SPWN = 118 
elements.DEFAULT_PT_SHLD = 119 
elements.DEFAULT_PT_SHD2 = 120 
elements.DEFAULT_PT_SHD3 = 121 
elements.DEFAULT_PT_SHD4 = 122 
elements.DEFAULT_PT_LOLZ = 123 
elements.DEFAULT_PT_WIFI = 124 
elements.DEFAULT_PT_FILT = 125 
elements.DEFAULT_PT_ARAY = 126 
elements.DEFAULT_PT_BRAY = 127 
elements.DEFAULT_PT_STK2 = 128 
elements.DEFAULT_PT_BOMB = 129 
elements["DEFAULT_PT_C-5"] = 130 
elements.DEFAULT_PT_SING = 131 
elements.DEFAULT_PT_QRTZ = 132 
elements.DEFAULT_PT_PQRT = 133 
elements.DEFAULT_PT_EMP = 134 
elements.DEFAULT_PT_BREL = 135 
elements.DEFAULT_PT_ELEC = 136 
elements.DEFAULT_PT_ACEL = 137 
elements.DEFAULT_PT_DCEL = 138 
elements.DEFAULT_PT_TNT = 139 
elements.DEFAULT_PT_IGNC = 140 
elements.DEFAULT_PT_BOYL = 141 
elements.DEFAULT_PT_GEL = 142 
elements.DEFAULT_PT_TRON = 143 
elements.DEFAULT_PT_TTAN = 144 
elements.DEFAULT_PT_EXOT = 145 
elements.DEFAULT_PT_EMBR = 147 
elements.DEFAULT_PT_HYGN = 148 
elements.DEFAULT_PT_SOAP = 149 
elements.DEFAULT_PT_BHOL = 150 
elements.DEFAULT_PT_WHOL = 151 
elements.DEFAULT_PT_MERC = 152 
elements.DEFAULT_PT_PBCN = 153 
elements.DEFAULT_PT_GPMP = 154 
elements.DEFAULT_PT_CLST = 155 
elements.DEFAULT_PT_WWLD = 156 
elements.DEFAULT_PT_GBMB = 157 
elements.DEFAULT_PT_FIGH = 158 
elements.DEFAULT_PT_FRAY = 159 
elements.DEFAULT_PT_RPEL = 160 
elements.DEFAULT_PT_PPIP = 161 
elements.DEFAULT_PT_DTEC = 162 
elements.DEFAULT_PT_DMG = 163 
elements.DEFAULT_PT_TSNS = 164 
elements.DEFAULT_PT_VIBR = 165 
elements.DEFAULT_PT_BVBR = 166 
elements.DEFAULT_PT_CRAY = 167 
elements.DEFAULT_PT_PSTN = 168 
elements.DEFAULT_PT_FRME = 169 
elements.DEFAULT_PT_GOLD = 170 
elements.DEFAULT_PT_TUNG = 171 
elements.DEFAULT_PT_PSNS = 172 
elements.DEFAULT_PT_PROT = 173 
elements.DEFAULT_PT_VIRS = 174 
elements.DEFAULT_PT_VRSS = 175 
elements.DEFAULT_PT_VRSG = 176 
elements.DEFAULT_PT_GRVT = 177 
elements.DEFAULT_PT_DRAY = 178 
elements.DEFAULT_PT_CRMC = 179 
elements.DEFAULT_PT_HEAC = 180 
elements.DEFAULT_PT_SAWD = 181 
elements.DEFAULT_PT_POLO = 182 
elements.DEFAULT_PT_RFRG = 183 
elements.DEFAULT_PT_RFGL = 184 
elements.DEFAULT_PT_LSNS = 185 
elements.DEFAULT_PT_LDTC = 186 
elements.DEFAULT_PT_SLCN = 187 
elements.DEFAULT_PT_PTNM = 188 
elements.DEFAULT_PT_VSNS = 189 
elements.DEFAULT_PT_ROCK = 190 
elements.DEFAULT_PT_LITH = 191

--Set in `parts[i].flags`. Used by liquids and powders to speed up simulation by moving them less  
elements.FLAG_STAGNANT = 1
--Set in `parts[i].flags`. Given to PHOT by PCLN and PBCN to fix gaps in lasers, only useable by energy particles  
elements.FLAG_SKIPMOVE = 2
--Set in `parts[i].flags`. Used internally for water equalization  
elements.FLAG_WATEREQUAL = nil
--Set in `parts[i].flags`. Can be used to re-enable moving sponge  
elements.FLAG_MOVABLE = 8
--Set in `parts[i].flags`. Re-enables deco on photons for compatibility. Defined as the same value as FLAG_MOVABLE (they only apply to different elements)  
elements.FLAG_PHOTDECO = 8

--#### Menu Sections  
elements.SC_WALL = 0
--#### Menu Sections  
elements.SC_ELEC = 1
--#### Menu Sections  
elements.SC_POWERED = 2
--#### Menu Sections  
elements.SC_SENSOR = 3
--#### Menu Sections  
elements.SC_FORCE = 4
--#### Menu Sections  
elements.SC_EXPLOSIVE = 5
--#### Menu Sections  
elements.SC_GAS = 6
--#### Menu Sections  
elements.SC_LIQUID = 7
--#### Menu Sections  
elements.SC_POWDERS = 8
--#### Menu Sections  
elements.SC_SOLIDS = 9
--#### Menu Sections  
elements.SC_NUCLEAR = 10
--#### Menu Sections  
elements.SC_SPECIAL = 11
--#### Menu Sections  
elements.SC_LIFE = 12
--#### Menu Sections  
elements.SC_TOOL = 13

-- 14 is faviourites

--#### Menu Sections  
elements.SC_DECO = 15