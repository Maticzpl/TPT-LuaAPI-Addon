---@meta
---@diagnostic disable:lowercase-global
---@diagnostic disable:duplicate-set-field

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

---@alias Sign { id: integer, text: string?, x: integer?, y: integer?, justification: integer}

---@enum JustModes
simulation.signs = {
    JUSTMODE_LEFT = 0,
    JUSTMODE_MIDDLE = 1,
    JUSTMODE_RIGHT = 2,
    JUSTMODE_NONE = 3
}

-- Don't think the others can be enums cause they would redefine sim table

---@alias ColorSpace
---|`sim.DECOSPACE_SRGB`
---|`sim.DECOSPACE_LINEAR`
---|`sim.DECOSPACE_GAMMA22`
---|`sim.DECOSPACE_GAMMA18`

---@alias GravityMode
---|`sim.GRAV_VERTICAL`
---|`sim.GRAV_OFF`
---|`sim.GRAV_RADIAL`
---|`sim.GRAV_CUSTOM`

---@alias AirMode
---|`sim.AIR_ON`
---|`sim.AIR_PRESSUREOFF`
---|`sim.AIR_VELOCITYOFF`
---|`sim.AIR_OFF`
---|`sim.AIR_NOUPDATE`

---@alias CanMoveMethod
---|0 Bounce off the obstacle  
---|1 Swap places with the obstacle  
---|2 Move over the obstacle  

---@alias Brush
---|`sim.BRUSH_CIRCLE`
---|`sim.BRUSH_SQUARE`
---|`sim.BRUSH_TRIANGLE`

---@alias GOL {name: string, rulestr: string, rule: number, color1: number, color2: number}

--The Simulation API allows for modifying the state and properties of particles, air and gravity 
simulation = {}

--```
--number[] sim.partNeighbors(number x, number y, number radius, [number type])
--```
--Returns an array of indices of particles that neighbour the given coordinates and match the given type (if it is specified). The resulting array does not contain the particle at the specified position.<br> 
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
--Returns a list of particles indexes(starting at 0) that neighbour the given coordinates that matches the given type (if it is specified) The resulting list does not contain the "origin particle"<br>
--### **REPLACED by `sim.partNeighbors`**<br>
---@deprecated
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
--Reliably change the type of a particle, this method avoids the side effects created by changing the type directly with the "partProperty" method.<br>
---@param index integer  
---@param type integer  
function simulation.partChangeType(index, type)
end

--```
--count = sim.partCount()
--```
--  - `count`: Total count of all particles in the sim.
---@return integer
function simulation.partCount()
end

--```
--number sim.partCreate(number index, number x, number y, number type)
--```
--Create a single particle at location x, y. Returns the index of the new particle, or a negative number on failure.<br>
--Possible values for index are:<br>
--> **-1** Normal particle creation. This is the most useful value. No particle is created if position x, y is occupied and the requested new particle type cannot pass through the particle that is already there.<br>
--> **-2** Create particle as though it was drawn by the user with the brush (runs the Create function). Usually not useful.<br>
--> **-3** Create particle without checking for collisions with existing particles. In most cases, this is a bad idea, since a lot of elements don't work properly when there are multiple particles in the same place. Particles may also turn into BHOL if there are too many in the same place. The exception to this is elements that have been specifically designed to cope with this (such as multiple energy particles like PHOT and NEUT in the same place).<br>
--
--Particle index >= 0: Overwrite an existing particle with a new particle. At the moment no collision checking is performed, so the same considerations apply as for index=-3. It is usually safe if the new particle is in the same location as the old one. This is roughly equivalent to calling `sim.partKill` then `sim.partCreate(-3, ...)`.<br>
---@param index integer  
---@param x integer  
---@param y integer  
---@param type integer      
---@return integer
function simulation.partCreate(index, x, y, type)
end


--```
--nil sim.partProperty(number index, object field, object value)
--```
--Set the property value on a particle specified by index<br>
---@param index integer  
---@param field PartProperty  
---@param value any  
function simulation.partProperty(index, field, value)
end
--```
--nil sim.partProperty(number index, object field)
--```
--Get the property value on a particle specified by the index<br>
--The "field" may be a field name or field ID, see FIELD constants below for valid fields.<br>
---@param index integer  
---@param field PartProperty  
---@return any
function simulation.partProperty(index, field)
end


--```
--number x, number y sim.partPosition(number index)
--```
--Get the location of the particle at the specified index<br>
---@param index integer  
---@return number, number
function simulation.partPosition(index)
end

--```
--sim.partPosition(number index, number x, number y)
--```
--Get the location of the particle at the specified index<br>
---@param index integer  
---@param x number
---@param y number
function simulation.partPosition(index, x, y)
end

--```
--number sim.partID(number x, number y)
--```
--Get the index of a particle at the specified position. As of v89.3, this will return nil if there is no particle there.<br>
--Example (though this is probably best done with sim.neighbours):<br>
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
--Reliably delete a particle at a specified index or location, this method avoids the side effects created by changing the type to 0/DEFAULT_PT_NONE with the "partProperty" method<br>
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
--Returns a value on the pressure map.<br>
---@param x integer  
---@param y integer  
---@return number
function simulation.pressure(x, y)
end
--```
--nil sim.pressure(number x, number y, [number width, number height], number pressure)
--```
--Sets values on the pressure map.<br>
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
--Returns a value on the ambient heat map (the temperature of the air at that point).<br>
---@param x integer  
---@param y integer  
---@return number
function simulation.ambientHeat(x, y)
end
--```
--nil sim.ambientHeat(number x, number y, [number width, number height], number temp)
--```
--Sets values on the ambient heat map.<br>
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
--Returns an X value on the velocity map.<br>
---@param x integer  
---@param y integer  
---@return number
function simulation.velocityX(x, y)
end
--```
--nil sim.velocityX(number x, number y, [number width, number height], number value)
--```
--Sets X values on the velocity map.<br>
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
--Returns an Y value on the velocity map.<br>
---@param x integer  
---@param y integer  
---@return number
function simulation.velocityY(x, y)
end
--```
--nil sim.velocityY(number x, number y, [number width, number height], number value)
--```
--Sets Y values on the velocity map.<br>
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
--### **DEPRECATED IN 98.0, replaced by `sim.gravityMass` and `sim.gravityField`**<br>
--Returns the newtonian gravity at the given coordinates in the simulation. If given a value, will set the newtonian gravity at those coordinates. Width and height refer to the rectangle of affected cells, starting with the coords. If not given, they will default to 1,1.<br>
---@deprecated
---@param x integer  
---@param y integer  
---@return number
function simulation.gravMap(x, y)
end
--### **DEPRECATED IN 98.0, replaced by `sim.gravityMass` and `sim.gravityField`**<br>
--Returns the newtonian gravity at the given coordinates in the simulation. If given a value, will set the newtonian gravity at those coordinates. Width and height refer to the rectangle of affected cells, starting with the coords. If not given, they will default to 1,1.<br>
---@deprecated
---@param x integer  
---@param y integer  
---@param width integer  
---@param height integer  
---@param value number  
function simulation.gravMap(x, y, width, height, value)
end
--### **DEPRECATED IN 98.0, replaced by `sim.gravityMass` and `sim.gravityField`**<br>
--Returns the newtonian gravity at the given coordinates in the simulation. If given a value, will set the newtonian gravity at those coordinates. Width and height refer to the rectangle of affected cells, starting with the coords. If not given, they will default to 1,1.<br>
---@deprecated
---@param x integer  
---@param y integer  
---@param value number  
function simulation.gravMap(x, y, value)
end

--```
--x-strength y-strength sim.gravityField(x, y)
--```
--Check the gravity output map, which is a [CELL-sized](https://powdertoy.co.uk/Wiki/W/Lua_API:Simulation.html#Constants_2) map that controls the output of Newtonian Gravity calculation.<br>
--  -  x-strength: X strength of the gravity field at this location<br>
--  -  y-strength: Y strength of the gravity field at this location<br>
--  -  x: x position of the cell<br>
--  -  y: y position of the cell<br>
---@param x integer
---@param y integer
---@return number, number
function gravityField(x, y)
end

--```
--strength sim.gravityMass(x, y)
--```
--Interface with the gravity input map, which is a [CELL-sized](https://powdertoy.co.uk/Wiki/W/Lua_API:Simulation.html#Constants_2) map that controls the input to the Newtonian Gravity calculation. The larger the value, the greater the mass / attraction to this location.<br>
--  - `strength`: Strength of the input gravity at this location<br>
--  - `x`: x position of the cell<br>
--  - `y`: y position of the cell<br>
--  - `w`: width (cell count) of the area to set<br>
--  - `h`: height (cell count) of the area to set<br>
---@param x integer
---@param y integer
---@return number
function simulation.gravityMass(x, y)
end
--```
--sim.gravityMass(x, y, strength)
--```
--Interface with the gravity input map, which is a [CELL-sized](https://powdertoy.co.uk/Wiki/W/Lua_API:Simulation.html#Constants_2) map that controls the input to the Newtonian Gravity calculation. The larger the value, the greater the mass / attraction to this location.<br>
--  - `strength`: Strength of the input gravity at this location<br>
--  - `x`: x position of the cell<br>
--  - `y`: y position of the cell<br>
--  - `w`: width (cell count) of the area to set<br>
--  - `h`: height (cell count) of the area to set<br>
---@param x integer
---@param y integer
---@param strength number
function simulation.gravityMass(x, y, strength)
end
--```
--sim.gravityMass(x, y, w, h, strength)
--```
--Interface with the gravity input map, which is a [CELL-sized](https://powdertoy.co.uk/Wiki/W/Lua_API:Simulation.html#Constants_2) map that controls the input to the Newtonian Gravity calculation. The larger the value, the greater the mass / attraction to this location.<br>
--  - `strength`: Strength of the input gravity at this location<br>
--  - `x`: x position of the cell<br>
--  - `y`: y position of the cell<br>
--  - `w`: width (cell count) of the area to set<br>
--  - `h`: height (cell count) of the area to set<br>
---@param x integer
---@param y integer
---@param w integer
---@param h integer
---@param strength number
function simulation.gravityMass(x, y, w, h, strength)
end 

--```
--enabled = sim.newtonianGravity()
--```
--  - `newtonianGravity`: boolean flag that specifies whether Newtonian Gravity is turned on or off.
---@return boolean
function simulation.newtonianGravity()
end
--```
--sim.newtonianGravity(enabled)
--```
--  - `newtonianGravity`: boolean flag that specifies whether Newtonian Gravity is turned on or off.
---@param enabled boolean
function simulation.newtonianGravity(enabled)
end

--```
--sim.resetSpark()
--```
-- Same effect as the ctrl+= shortcut. Removes all sparks from the simulation and resets them to .life = 0. SPRK with invalid ctypes are deleted. Also resets all wifi cooldowns. 
function simulation.resetSpark()
end

--```
--sim.resetGravityField()
--```
-- Resets the gravity field to 0. While this will temporarily stop all Newtonian Gravity output, any changes will regenerate the gravity map based on the gravity sources in the sim. 
function simulation.resetGravityField()
end

--```
--sim.resetVelocity()
--```
-- Resets the air velocity map to 0. This map controls the flow of air. Resetting this will have some effect on particles, but won't stop them in their tracks. 
function simulation.resetVelocity()
end


--TODO: look into if its an iterator

--```
--number sim.createParts(number x, number y, [number rx], [number ry], [number type], [number brush], [number flag])
--```
--Does something.<br>
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
--Creates a line of of either the user's currently selected type or the type specified at the specified coordinates.<br>
--rx and ry describe the radius of the brush used. Default radius is 5, 5.<br>
--flag refers to particle replacement flags.<br>
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
--Creates a filled box of either the user's currently selected type or the type specified at the specified coordinates.<br>
--flag refers to particle replacement flags.<br>
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
--Flood fills either the user's currently selected type or the type specified at the coordinates given.<br>
--flag refers to particle replacement flags.<br>
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
--Does something<br>
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
--Creates a line of either the specified walltype or the type of the basic wall at the specified particle coordinates.<br>
--Note: the coordinates might change from particle coordinates to map coordinates in the future.<br>
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
--Creates a filled box of either the specified walltype or the type of the basic wall at the specified particle coordinates.<br>
--Note: the coordinates might change from particle coordinates to map coordinates in the future.<br>
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
--Flood fills either the specified walltype or the type of the basic wall at the specified particle coordinates.<br>
--Note: the coordinates might change from particle coordinates to map coordinates in the future.<br>
---@param x integer  
---@param y integer  
---@param walltype WallType?  
---@param bm integer?  
---@return number
function simulation.floodWalls(x, y, walltype, bm)
end

--```
--wallType sim.wallMap(x, y)
--```
--Interface with the wall map, which is a [CELL-sized](https://powdertoy.co.uk/Wiki/W/Lua_API:Simulation.html#Constants_2) map that specifies which walls are at what position.<br>
--  - `wallType`: Wall type to set, wall type will be one of the constants in [sim.walls](https://powdertoy.co.uk/Wiki/W/Lua_API:Simulation.html#Walls)<br>
--  - `x`: x position of the cell<br>
--  - `y`: y position of the cell<br>
--  - `w`: width (cell count) of the area to set<br>
--  - `h`: height (cell count) of the area to set<br>
---@param x integer
---@param y integer
---@return WallType
function simulation.wallMap(x, y)
end
--```
--sim.wallMap(x, y, wallType)
--```
--Interface with the wall map, which is a [CELL-sized](https://powdertoy.co.uk/Wiki/W/Lua_API:Simulation.html#Constants_2) map that specifies which walls are at what position.<br>
--  - `wallType`: Wall type to set, wall type will be one of the constants in [sim.walls](https://powdertoy.co.uk/Wiki/W/Lua_API:Simulation.html#Walls)<br>
--  - `x`: x position of the cell<br>
--  - `y`: y position of the cell<br>
--  - `w`: width (cell count) of the area to set<br>
--  - `h`: height (cell count) of the area to set<br>
---@param x integer
---@param y integer
---@param wallType WallType
function simulation.wallMap(x, y, wallType)
end
--```
--sim.wallMap(x, y, w, h, wallType)
--```
--Interface with the wall map, which is a [CELL-sized](https://powdertoy.co.uk/Wiki/W/Lua_API:Simulation.html#Constants_2) map that specifies which walls are at what position.<br>
--  - `wallType`: Wall type to set, wall type will be one of the constants in [sim.walls](https://powdertoy.co.uk/Wiki/W/Lua_API:Simulation.html#Walls)<br>
--  - `x`: x position of the cell<br>
--  - `y`: y position of the cell<br>
--  - `w`: width (cell count) of the area to set<br>
--  - `h`: height (cell count) of the area to set<br>
---@param x integer
---@param y integer
---@param w integer
---@param h integer
---@param wallType WallType
function simulation.wallMap(x, y, w, h, wallType)
end

-- TODO: Alias with all tools
--TODO: look into if its an iterator

--```
--sim.toolBrush(number x, number y, [number rx], [number ry], [number tool], [number brush], [number strength])
--```
--Performs the given tool (HEAT, COOL, AIR, etc) on the given coordinates with the given brush size. The brush types are 0 (circle), 1 (square) and 2 (triangle).<br>
---@param x integer  
---@param y integer  
---@param rx integer?  
---@param ry integer?  
---@param tool integer?  
---@param brush integer?  
---@param strength number?  
---@return 0
function simulation.toolBrush(x, y, rx, ry, tool, brush, strength)
end



--```
--type sim.toolLine(number x1, number y1, number x2, number y2, [number rx], [number ry], [number tool], [number brush], [number strength])
--```
--Does something<br>
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
--Does something<br>
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
--Does something<br>
--tool refers to decoration tools.<br>
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
--Changes the decoration color of all particles in the line specified.<br>
--rx and ry describe the radius of the brush used. Default radius is 5, 5.<br>
--tool refers to decoration tools.<br>
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
--Changes the decoration color of all particles in the specified coordinates.<br>
--tool refers to decoration tools.<br>
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
--Returns the currently selected decoration color.<br>
---@return integer
function simulation.decoColor()
end
--```
--nil sim.decoColor(number color)
--```
--Sets the selected decoration color to color.<br>
--color is in the format 0xAARRGGBB<br>
---@param color integer  
function simulation.decoColor(color)
end
--```
--nil sim.decoColor(number r, number g, number b, [number a])
--```
--Sets the selected decoration color to r,g,b,a<br>
---@param r integer  
---@param g integer  
---@param b integer  
---@param a integer?  
function simulation.decoColor(r, g, b, a)
end

--```
--number sim.decoColour()
--```
--Returns the currently selected decoration color.<br>
--### **REPLACED BY `sim.decoColor`**
---@deprecated
---@return integer
function simulation.decoColour()
end
--```
--nil sim.decoColour(number color)
--```
--Sets the selected decoration color to color.<br>
--color is in the format 0xAARRGGBB<br>
--### **REPLACED BY `sim.decoColor`**
---@deprecated
---@param colour integer  
function simulation.decoColour(colour)
end
--```
--nil sim.decoColour(number r, number g, number b, [number a])
--```
--Sets the selected decoration color to r,g,b,a<br>
--### **REPLACED BY `sim.decoColor`**
---@deprecated
---@param r integer  
---@param g integer  
---@param b integer  
---@param a integer?  
function simulation.decoColour(r, g, b, a)
end

--```
-- nil sim.floodDeco(number x, number y, number r, number g, number b, number a)
--```
--Flood fills the color at position x, y with another color. Note: Color at position includes console overlay.<br>
---@param x integer  
---@param y integer  
---@param r integer  
---@param g integer  
---@param b integer  
---@param a integer  
function simulation.floodDeco(x, y, r, g, b, a) end



--```
--sim.decoSpace(colorSpace)
--```
--Controls the color space used by smudge tool.<br>
--  - `space`: The color space, can be one of these constants:<br>
--     - `DECOSPACE_SRGB`: Standard SRGB color space<br>
--     - `DECOSPACE_LINEAR`: Linear color space<br>
--     - `DECOSPACE_GAMMA22`: Gamma 2.2<br>
--     - `DECOSPACE_GAMMA18`: Gamma 1.8<br>
--     - `NUM_DECOSPACES`: The total number of color spaces<br>
---@param colorSpace ColorSpace|number
function simulation.decoSpace(colorSpace)
end
--```
--colorSpace sim.decoSpace()
--```
--Controls the color space used by smudge tool.<br>
--  - `space`: The color space, can be one of these constants:<br>
--     - `DECOSPACE_SRGB`: Standard SRGB color space<br>
--     - `DECOSPACE_LINEAR`: Linear color space<br>
--     - `DECOSPACE_GAMMA22`: Gamma 2.2<br>
--     - `DECOSPACE_GAMMA18`: Gamma 1.8<br>
--     - `NUM_DECOSPACES`: The total number of color spaces<br>
---@return ColorSpace|number
function simulation.decoSpace()
end

--```
--nil sim.clearSim()
--```
--Clears everything in the simulation.<br>
function simulation.clearSim() end

--```
--nil sim.clearRect(number x, number y, number width, number height)
--```
--Clears all particles in a rectangle starting at x, y down and to the right width and height pixels respectively.<br>
---@param x integer  
---@param y integer  
---@param width integer  
---@param height integer  
function simulation.clearRect(x, y, width, height) end


--```
--sim.resetTemp()
--```
--Resets the temperature of all particles to their spawn temperature.<br>
function simulation.resetTemp() end

--```
--sim.resetPressure()
--```
--Resets the pressure map to no pressure.<br>
function simulation.resetPressure() end


--```
--string sim.saveStamp([number x, number y, number width, number height])
--```
--Creates a stamp of the specified coordinates. Coordinates default to entire simulation.<br>
--Returns the stamp id created.<br>
---@param x integer  
---@param y integer  
---@param width integer  
---@param height integer  
---@param includePressure boolean?
---@return string
function simulation.saveStamp(x, y, width, height, includePressure)
end
---@return string
function simulation.saveStamp()
end

--```
--sim.loadStamp(string filename, number x, number y)
--sim.loadStamp(number id, number x, number y)
--```
--Loads a stamp identified by filename or ID, and places it at position x,y. Filenames should be given without stamps/ or the .stm suffix. On success, returns 1. On failure, returns nil and the failure reason as a string.<br>
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
--table sim.listStamps()
--```
--Returns a table of stamps, in order. Stamp names are 10 characters, with no .stm extention or stamps/ prefix.<br>
---@return string[]
function simulation.listStamps()
end

-- TODO: inconsitent formatting (3 dashes, space after)

---```
---sim.loadStamp(string filename, number x, number y, [boolean hflip, [number rotation, [boolean includePressure]]])
---sim.loadStamp(number id, number x, number y, [boolean hflip, [number rotation, [boolean includePressure]]])
---```
--- Loads a stamp identified by filename or ID, and places it at position x,y. Filenames should be given without stamps/ or the .stm suffix. On success, returns 1. On failure, returns nil and the failure reason as a string.<br>
--- The following changes are applied to the stamp before pasting, in this order:<br>
--- - if hflip is true, a horizontal flip is applied to the save (same as pressing Shift+R when pasting<br>
--- - if rotation is present, this number of 90-degree counterclockwise rotations are applied to the save (same as pressing R this many times when pasting)<br>
--- - if the position x,y is not CELL-aligned, the stamp is pasted with its top left corner at the nearest CELL-aligned position toward negative infinity, and the difference between this position and the requested one is achieved via "nudging" (same as pressing the arrow keys a few times when pasting)<br>
---@param filenameOrId string | number
---@param x number
---@param y number
---@param hflip boolean?
---@param rotation number?
---@param includePressure boolean?
function simulation.loadStamp(filenameOrId, x, y, hflip, rotation, includePressure) end

--```
--type sim.deleteStamp(string name)
--```
--Deleting a stamp identified by filename or ID.<br>
---@param name string  
function simulation.deleteStamp(name)
end
---@param id integer  
function simulation.deleteStamp(id)
end


--```
--nil sim.loadSave(number SaveID, [number hideDescription], [number history?])
--```
--Loads the save associated with the specified SaveID.<br>
--If hideDescription is non zero, the information for the save is not shown.<br>
---@param SaveID integer  
---@param hideDescription integer?  
---@param history integer?  
function simulation.loadSave(SaveID, hideDescription, history)
end


--```
--nil sim.reloadSave()
--```
--Reloading save.<br>
function simulation.reloadSave() end


--```
--number, number sim.getSaveID()
--```
--Returns the save ID and the history offset of the currently loaded save or nil if the simulation is not a downloaded save. The history offset can be used with loadSave.<br>
---@return integer, integer
function simulation.getSaveID() 
end


--```
--number, number sim.adjustCoords(number x, number y)
--```
--Actually this is more of a UI method than a simulation method. Given a mouse position x, y in the window, this function returns the corresponding coordinates in the simulation (taking into account the visibility and position of the zoom window, if applicable).<br>
---@param x integer  
---@param y integer  
---@return integer, integer
function simulation.adjustCoords(x, y)
end

--```
--number sim.prettyPowders()
--nil sim.prettyPowders(mode)
--```
--Sets whether the "pretty powders mode" (powders, such as SAND or BCOL, will be assigned random deco values) is on or off. When called with no arguments, returns a value determining whether it is on or off.<br>
---@return integer
function simulation.prettyPowders() 
end
---@param mode integer  
function simulation.prettyPowders(mode) end


--```
--number sim.gravityGrid()
--```
--Returns the current setting for drawing the gravity grid. More of a renderer setting than a simulation setting.<br>
---@return integer
function simulation.gravityGrid()
end
--```
--nil sim.gravityGrid(number mode)
--```
--Sets the setting for drawing the gravity grid to mode.<br>
---@param mode integer  
function simulation.gravityGrid(mode)
end

--```
--number sim.edgeMode()
--```
--Returns the current Edge Mode<br>
---@return integer
function simulation.edgeMode()
end
--```
--nil sim.edgeMode(number mode)
--```
--Sets the current Edge Mode to mode. 0 means normal, 1 creates a wall all the way round the edge of the simulation.<br>
---@param mode integer  
function simulation.edgeMode(mode)
end


--```
--number sim.gravityMode()
--```
--Returns the current gravity simulation mode.<br>
---@return GravityMode
function simulation.gravityMode()
end
--```
--nil sim.gravityMode(number mode)
--```
--Sets the gravity simulation mode to mode.<br>
-- - 0 Normal, vertical gravity<br>
-- - 1 No gravity<br>
-- - 2 Radial gravity<br>
---@param mode GravityMode  
function simulation.gravityMode(mode)
end


--```
--nil sim.customGravity(number x, number y)
--```
--Sets the custom gravity x and y values. Gravity mode must be set to "custom" to have any effect (see sim.gravityMode).
--If called with one argument, sets only Y component of the gravity
---@param x number?
---@param y number
function simulation.customGravity(x, y)        
end
--```
-- number, number sim.customGravity()
--```
--Returns the current custom gravity settings as x and y values. Left and up are negative x and negative y respectively.
---@return number, number
function simulation.customGravity()        
end

--```
--number sim.airMode()
--```
--Returns the current Air Simulation Mode.<br>
---@return AirMode
function simulation.airMode()
end
--```
--nil sim.airMode(number mode)
--```
--Sets the Air Simulation Mode to mode.<br>
--Mode numbers are as follows (not currently available as named constants):<br>
-- - 0 Normal<br>
-- - 1 Pressure off<br>
-- - 2 Velocity off<br>
-- - 3 Velocity and pressure off<br>
-- - 4 No update<br>
---@param mode AirMode  
function simulation.airMode(mode)
end


--```
--number sim.waterEqualisation()
--```
--Returns the current Water equalisation setting.<br>
--### **REPLACED BY `sim.waterEqualization`**
---@deprecated
---@return integer
function simulation.waterEqualisation()
end
--```
--nil sim.waterEqualisation(number setting)
--```
--Set the Water equalisation setting to setting.<br>
--### **REPLACED BY `sim.waterEqualization`**
---@deprecated
---@param setting integer  
function simulation.waterEqualisation(setting)
end    

--```
--number sim.waterEqualization()
--```
--Returns the current Water equalization setting.<br>
---@return integer
function simulation.waterEqualization()
end
--```
--nil sim.waterEqualization(number setting)
--```
--Set the Water equalization setting to setting.<br>
---@param setting integer  
function simulation.waterEqualization(setting)
end


--```
--number sim.ambientAirTemp()
--```
--Returns the current ambient temperature. When ambient heat mode is turned on, the air at the edges of the screen will remain at this temperature.<br>
---@return number
function simulation.ambientAirTemp()
end
--```
--nil sim.ambientAirTemp(number temp)
--```
--Sets the ambient temperature. The temperature is measured in Kelvin.<br>
---@param temp number  
function simulation.ambientAirTemp(temp)
end

--```
--sim.ambientHeatSim(enabled)
--```
-- - `enabled`: Flag that specifies whether ambient heat is enabled or not.<br>
---@param enabled boolean 
function simulation.ambientHeatSim(enabled)
end
--```
--enabled = sim.ambientHeatSim()
--```
-- - `enabled`: Flag that specifies whether ambient heat is enabled or not.<br>
---@return boolean
function simulation.ambientHeatSim()
end

--```
--enabled = sim.heatSim()
--```
--  - `heatSim`: boolean flag that specifies whether heat simulation is turned on or off.
---@return boolean
function simulation.heatSim()
end
--```
--sim.heatSim(enabled)
--```
--  - `heatSim`: boolean flag that specifies whether heat simulation is turned on or off.
---@param enabled boolean
function simulation.heatSim(enabled)
end

--```
--number sim.elementCount(number type)
--```
--Returns the number of particles of the specified type in the simulation.<br>
---@param type integer  
---@return integer
function simulation.elementCount(type)
end

--```
--simulation.can_move(number movingElementID, number obstacleElementID, number method)
--```
--Decides what a particle does when it hits another particle while moving. Method is one of the following:<br>
-- - 0 bounce off the obstacle<br>
-- - 1 swap places with the obstacle<br>
-- - 2 move over the obstacle<br>
--### **REPLACED BY `sim.canMove`**
---@deprecated
---@param movingElementID integer  
---@param obstacleElementID integer  
---@param method CanMoveMethod  
function simulation.can_move(movingElementID, obstacleElementID, method) end
--```
--number simulation.can_move(number movingElementID, number obstacleElementID)
--```
--Returns what a particle does when it hits another particle while moving, a method like above.<br>
--### **REPLACED BY `sim.canMove`**
---@deprecated
---@param movingElementID integer  
---@param obstacleElementID integer  
---@return CanMoveMethod
function simulation.can_move(movingElementID, obstacleElementID) 
end

--```
--simulation.canMove(number movingElementID, number obstacleElementID, number method)
--```
--Decides what a particle does when it hits another particle while moving. Method is one of the following:<br>
-- - 0 bounce off the obstacle<br>
-- - 1 swap places with the obstacle<br>
-- - 2 move over the obstacle<br>
---@param movingElementID integer  
---@param obstacleElementID integer  
---@param method CanMoveMethod  
function simulation.canMove(movingElementID, obstacleElementID, method) end
--```
--number simulation.canMove(number movingElementID, number obstacleElementID)
--```
--Returns what a particle does when it hits another particle while moving, a method like above.<br>
---@param movingElementID integer  
---@param obstacleElementID integer  
---@return CanMoveMethod
function simulation.canMove(movingElementID, obstacleElementID) 
end

--```
--function sim.brush(number x, number y, [number brushWidth, number brushHeight], [number brushID])
--```
--Returns an iterator over positions inside the specified brush.<br>
--If width, height or ID is not provided, will use values of the current brush selected by user.<br>
--Example:<br>
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
--Returns an iterator over particle indexes that can be used in lua for loops<br>
---@return fun(): integer
function simulation.parts() end

--```
--number sim.pmap(number x, number y)
--```
--Get the index of the particle at the specified position. Returns 0 if there is no particle there. This function is very similar to sim.partID, but excludes energy particles (such as PHOT, NEUT, ELEC).<br>
---@param x integer  
---@param y integer  
---@return integer
function simulation.pmap(x, y)
end

--```
--number sim.photons(number x, number y)
--```
--Get the index of the energy particle at the specified position. Returns 0 if there is no particle there. This function is very similar to sim.pmap<br>
---@param x integer  
---@param y integer  
---@return integer
function simulation.photons(x, y)
end

--```
--value sim.elecMap(x, y)
--```
--Interface with the elec map, which is a CELL-sized map used to control powered walls like E-Wall and Detector.<br>
--  -  `value`: Elec map value. This is an integer that controls for how many frames wall electricity is active in this cell, 0 if there is no power.<br>
--  -  `x`: x position of the cell<br>
--  -  `y`: y position of the cell<br>
--  -  `w`: width (cell count) of the area to set<br>
--  -  `h`: height (cell count) of the area to set<br>
---@param x integer
---@param y integer
---@return integer
function simulation.elecMap(x, y)
end
--```
--sim.elecMap(x, y, value)
--```
--Interface with the elec map, which is a [CELL-sized](https://powdertoy.co.uk/Wiki/W/Lua_API:Simulation.html#Constants_2) map used to control powered walls like E-Wall and Detector.<br>
--  -  `value`: Elec map value. This is an integer that controls for how many frames wall electricity is active in this cell, 0 if there is no power.<br>
--  -  `x`: x position of the cell<br>
--  -  `y`: y position of the cell<br>
--  -  `w`: width (cell count) of the area to set<br>
--  -  `h`: height (cell count) of the area to set<br>
---@param x integer
---@param y integer
---@param value integer
function simulation.elecMap(x, y, value)
end
--```
--sim.elecMap(x, y, w, h, value)
--```
--Interface with the elec map, which is a [CELL-sized](https://powdertoy.co.uk/Wiki/W/Lua_API:Simulation.html#Constants_2) map used to control powered walls like E-Wall and Detector.<br>
--  -  `value`: Elec map value. This is an integer that controls for how many frames wall electricity is active in this cell, 0 if there is no power.<br>
--  -  `x`: x position of the cell<br>
--  -  `y`: y position of the cell<br>
--  -  `w`: width (cell count) of the area to set<br>
--  -  `h`: height (cell count) of the area to set<br>
---@param x integer
---@param y integer
---@param w integer
---@param h integer
---@param value integer
function simulation.elecMap(x, y, w, h, value)
end

--```
--type sim.neighbors(number x, number y, [number rx], [number ry], [number type])
--```
--Used for iterating through particles in an area centred on the given coordinates (x, y). Radius in the x and y directions is set by rx and ry. Default radius is 2, 2. If type is provided, only particles of the corresponding type will be returned.<br>
--The size of the rectangular area is one plus twice the radius, so a radius of 2, 2 gives a 5x5 pixel area centred on x, y. Particles in the centre position x, y are excluded. Only one particle in each position is included, and energy particles (such as photons, neutrons, electrons) are ignored.<br>
--Example (i is the index of the neighbouring particle and nx, ny are its coordinates):<br>
--```
--for i,nx,ny in sim.neighbors(100,200,1,1) do
-- sim.partProperty(i, sim.FIELD_TEMP, 9999)
--end
--```
--Or if coordinates of the neighbouring particles are not required:<br>
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

--### **REPLACED by `sim.neighbors`**
---@deprecated
---@param x integer  
---@param y integer  
---@param rx integer  
---@param ry integer  
---@param type integer?  
---@return fun(): number, number, number
function simulation.neighbours(x, y, rx, ry, type)
end
--### **REPLACED by `sim.neighbors`**
---@deprecated
---@param x integer  
---@param y integer  
---@return fun(): number, number, number
function simulation.neighbours(x, y)
end


--```
--number sim.framerender()
--sim.framerender(number frames)
--```
--Advances the simulation the given number of frames, even when paused. If called with no arguments, returns the number of frames currently to be rendered. Usually is 0.<br>
--### **REPLACED BY `sim.frameRender`**
---@deprecated
---@param frames integer  
function simulation.framerender(frames)
end
--### **REPLACED BY `sim.frameRender`**
---@deprecated
---@return integer
function simulation.framerender()
end

--```
--number sim.frameRender()
--sim.frameRender(number frames)
--```
--Advances the simulation the given number of frames, even when paused. If called with no arguments, returns the number of frames currently to be rendered. Usually is 0.<br>
---@param frames integer  
function simulation.frameRender(frames)
end
---@return integer
function simulation.frameRender()
end


--```
--number sim.gspeed()
--```
--Returns the current GoL speed<br>
--### **REPLACED BY `sim.frameRender`**
---@deprecated
---@return integer
function simulation.gspeed()
end
--```
--nil sim.gspeed(number newSpeed)
--```
--Sets the current GoL speed. This is the number of frames between GoL updates. Default is one, larger numbers make it slower.<br>
--### **REPLACED BY `sim.frameRender`**
---@deprecated
---@param newSpeed integer  
function simulation.gspeed(newSpeed)
end

--```
--number sim.golSpeedRatio()
--```
--Returns the current GoL speed<br>
---@return integer
function simulation.golSpeedRatio()
end
--```
--nil sim.golSpeedRatio(number newSpeed)
--```
--Sets the current GoL speed. This is the number of frames between GoL updates. Default is one, larger numbers make it slower.<br>
---@param newSpeed integer  
function simulation.golSpeedRatio(newSpeed)
end

--```
--nil sim.takeSnapshot()
--```
--Takes a undo snapshot, for use with ctrl + z<br>
function simulation.takeSnapshot() end

--```
--number sim.replaceModeFlags()
--```
--Returns the current replace mode flags.<br>
--If the first bit of that number is set (flags = 1), replace mode is enabled.<br>
--If the second bit is set (flags = 2), specific delete is enabled.<br>
---@return integer
function simulation.replaceModeFlags() 
end
--```
--nil sim.replaceModeFlags(number flags)
--```
--Sets the replace mode flags.<br>
---@param flags integer  
function simulation.replaceModeFlags(flags) end

--```
--table sim.listCustomGol()
--```
--Returns a table of all custom game of life types. Each index has a name (string), rulestr (string), rule (number), color1 (number), and color2 (number) property.<br>
--See https://powdertoy.co.uk/Wiki/W/Lua_API:Simulation.html#simulation.addCustomGol for details about properties.<br>
---@return GOL[]
function simulation.listCustomGol() end

--```
--nil sim.addCustomGol(string rule, string name, number color1, number color2)
--```
--Adds a custom game of life type with the specified rule, name, and colors. Rule strings use B#/S#/# notation (more detail). Colors are used when fading between multiple states. Names and rules cannot be duplicates.<br>
---@param rule string  
---@param name string  
---@param color1 number  
---@param color2 number  
function simulation.addCustomGol(rule, name, color1, color2) end
--```
--nil sim.addCustomGol(number rule, string name, number color1, number color2)
--```
--Same as above, but takes a binary representation of the rule instead of a string. Bits 0-8 list stay values (starting at 0), bits 9-16 list begin values (starting at 1), and bits 17-20 are the number of states (decimal value added to 2). This is also how GOL rules are stored as ctypes.<br>
---@param rule number  
---@param name string  
---@param color1 number  
---@param color2 number  
function simulation.addCustomGol(rule, name, color1, color2) end

--```
--boolean sim.removeCustomGol(string name)
--```
--Removes all custom game of life types with the specified name. Returns true if any were removed.<br>
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

---```
--- boolean sim.ensureDeterminism()
---```
---Fetch or set ensureDeterminism flag. When this flag is set, extra data is included in saves to ensure simulation RNG state is saved, along with other items needed to guarantee proper determinism upon loading the save. 
---This is only useful for debugging, as different builds of the game may do things slightly differently on different machines. 
---Further, Newtonian gravity is not deterministic with this flag enabled even in debugging scenarios. 
--- @return boolean
function simulation.ensureDeterminism() end
---```
--- nil sim.ensureDeterminism(boolean flag)
---```
---Fetch or set ensureDeterminism flag. When this flag is set, extra data is included in saves to ensure simulation RNG state is saved, along with other items needed to guarantee proper determinism upon loading the save. 
---This is only useful for debugging, as different builds of the game may do things slightly differently on different machines. 
---Further, Newtonian gravity is not deterministic with this flag enabled even in debugging scenarios. 
--- @param flag boolean
function simulation.ensureDeterminism(flag) end

---```
---number simulation.hash()
---```
---Returns a 32-bit int represending the hash of the simulation's current state.  
---Nearly all state is included, including particles, air, gravity, frame count, and rng state.  
---Frame count's inclusion means that the hash changes every frame, even while paused).  
---@return number
function simulation.hash() end

---```
---number seed0Lower, number seed0Upper, number seed1Lower, number seed1Upper sim.randomSeed()
---```
---Retrieve or set the seed used for the Simulation RNG. This RNG is used by TPT to generate random numbers during sim contexts. The renderer RNG and interface RNG are unaffected.  
---Because seeds are 64 bits, they are fetched/set in two sets of 32 bits integers.  
---@return number seed0Lower, number seed0Upper, number seed1Lower, number seed1Upper
function simulation.randomSeed() end
---```
---nil sim.randomSeed(number seed0Lower, number seed0Upper, number seed1Lower, number seed1Upper)
---```
---Retrieve or set the seed used for the Simulation RNG. This RNG is used by TPT to generate random numbers during sim contexts. The renderer RNG and interface RNG are unaffected.  
---Because seeds are 64 bits, they are fetched/set in two sets of 32 bits integers.  
---@param seed0Lower number
---@param seed0Upper number
---@param seed1Lower number
---@param seed1Upper number
function simulation.randomSeed(seed0Lower, seed0Upper, seed1Lower, seed1Upper) end

--### **REPLACED BY `sim.randomSeed`**
---@deprecated
---@return number seed0Lower, number seed0Upper, number seed1Lower, number seed1Upper
function simulation.randomseed() end
--### **REPLACED BY `sim.randomSeed`**
---@deprecated
---@param seed0Lower number
---@param seed0Upper number
---@param seed1Lower number
---@param seed1Upper number
function simulation.randomseed(seed0Lower, seed0Upper, seed1Lower, seed1Upper) end

-- Deletes the sign at the specified sign id.<br>
---@param signID integer
function simulation.signs.delete(signID)
end

-- Creates a new sign with the specified properties. Returns the sign ID, or nil if there are too many signs (the limit is 16).<br>
---@param text string
---@param x integer
---@param y integer
---@param justification JustModes
---@return integer|nil
function simulation.signs.new(text, x, y, justification)
end

--```
--value sim.fanVelocityX(x, y)
--```
--Interface with the fan velocity map, which is a [CELL-sized](https://powdertoy.co.uk/Wiki/W/Lua_API:Simulation.html#Constants_2) map used to control fan velocity.<br>
--   - value: Fan X velocity, a floating point value<br>
--   - x: x position of the cell<br>
--   - y: y position of the cell<br>
--   - w: width (cell count) of the area to set<br>
--   - h: height (cell count) of the area to set<br>
---@param x integer
---@param y integer
---@return number
function simulation.fanVelocityX(x, y)
end
--```
--sim.fanVelocityX(x, y, value)
--```
--Interface with the fan velocity map, which is a [CELL-sized](https://powdertoy.co.uk/Wiki/W/Lua_API:Simulation.html#Constants_2) map used to control fan velocity.<br>
--   - value: Fan X velocity, a floating point value<br>
--   - x: x position of the cell<br>
--   - y: y position of the cell<br>
--   - w: width (cell count) of the area to set<br>
--   - h: height (cell count) of the area to set<br>
---@param x integer
---@param y integer
---@param value number
function simulation.fanVelocityX(x, y, value)
end
--```
--sim.fanVelocityX(x, y, w, h, value)
--```
--Interface with the fan velocity map, which is a [CELL-sized](https://powdertoy.co.uk/Wiki/W/Lua_API:Simulation.html#Constants_2) map used to control fan velocity.<br>
--   - value: Fan X velocity, a floating point value<br>
--   - x: x position of the cell<br>
--   - y: y position of the cell<br>
--   - w: width (cell count) of the area to set<br>
--   - h: height (cell count) of the area to set<br>
---@param x integer
---@param y integer
---@param w integer
---@param h integer
---@param value number
function simulation.fanVelocityX(x, y, w, h, value)
end

--```
--value sim.fanVelocityY(x, y)
--```
--Interface with the fan velocity map, which is a [CELL-sized](https://powdertoy.co.uk/Wiki/W/Lua_API:Simulation.html#Constants_2) map used to control fan velocity.<br>
--   - value: Fan Y velocity, a floating point value<br>
--   - x: x position of the cell<br>
--   - y: y position of the cell<br>
--   - w: width (cell count) of the area to set<br>
--   - h: height (cell count) of the area to set<br>
---@param x integer
---@param y integer
---@return number
function simulation.fanVelocityY(x, y)
end
--```
--sim.fanVelocityY(x, y, value)
--```
--Interface with the fan velocity map, which is a [CELL-sized](https://powdertoy.co.uk/Wiki/W/Lua_API:Simulation.html#Constants_2) map used to control fan velocity.<br>
--   - value: Fan Y velocity, a floating point value<br>
--   - x: x position of the cell<br>
--   - y: y position of the cell<br>
--   - w: width (cell count) of the area to set<br>
--   - h: height (cell count) of the area to set<br>
---@param x integer
---@param y integer
---@param value number
function simulation.fanVelocityY(x, y, value)
end
--```
--sim.fanVelocityY(x, y, w, h, value)
--```
--Interface with the fan velocity map, which is a [CELL-sized](https://powdertoy.co.uk/Wiki/W/Lua_API:Simulation.html#Constants_2) map used to control fan velocity.<br>
--   - value: Fan Y velocity, a floating point value<br>
--   - x: x position of the cell<br>
--   - y: y position of the cell<br>
--   - w: width (cell count) of the area to set<br>
--   - h: height (cell count) of the area to set<br>
---@param x integer
---@param y integer
---@param w integer
---@param h integer
---@param value number
function simulation.fanVelocityY(x, y, w, h, value)
end

--```
--flag = sim.paused()
--```
--  - `flag`: Boolean flag that says whether or not the sim is paused.<br>
-- Checks whether or not the simulation is paused. Processing may also continue if the 'f' framerender shortcut is used, which can last for long periods of time. [sim.framerender](https://powdertoy.co.uk/Wiki/W/Lua_API:Simulation.html#simulation.framerender) should be used to check for that<br>
---@return boolean
function simulation.paused()
end
--```
--sim.paused(flag)
--```
--  - `flag`: Boolean flag that says whether or not the sim is paused.<br>
-- Checks whether or not the simulation is paused. Processing may also continue if the 'f' framerender shortcut is used, which can last for long periods of time. sim.framerender should be used to check for that<br>
---@param flag boolean
function simulation.paused(flag)
end

sim = simulation

simulation.XRES = 612 -- X Resolution of the sim
simulation.YRES = 384 -- Y Resolution of the sim<br>
simulation.CELL = 4 -- Size of a wall / air simulation block<br>
simulation.XCELLS = 153 -- The number of cells in the X direction<br>
simulation.YCELLS = 96 -- The number of cells in the Y direction<br>
simulation.NCELL = 14688 -- The total number of cells in the simulation<br>
simulation.MAX_PARTS = 235008 -- Maximum number of particles that can exist at once<br>
simulation.MAX_VELOCITY = 10000 -- Particle velocity cap<br>
simulation.ISTP = 2 -- Movement code step value. Particles scan their trajectory and only check for blockers each step.<br>
simulation.CFDS = 1 -- Air sim related<br>
simulation.NT = -1 -- No transition, used in *Transition [properties](https://powdertoy.co.uk/Wiki/W/Element_Properties.html)
simulation.ST = 512 -- Special transition, used in *Transition properties, but there is no way to set a special transition handler from Lua<br>
simulation.ITH = 10000 -- Impossible temperature high, used along with NT to disable transitions<br>
simulation.ITL = -1 -- Impossible temperature low, used along with NT to disable transitions<br>
simulation.IPH = 257 -- Impossible pressure high, used along with NT to disable transitions<br>
simulation.IPL = -257 -- Impossible pressure low, used along with NT to disable transitions<br>
simulation.PT_NUM = 512 -- Maximum number of element IDs. Does not reflect the current number of elements, only the maximum that can be enabled at one time.<br>
simulation.R_TEMP = 22 -- Room temperature (22C), the default temperature for many elements<br>
simulation.MAX_TEMP = 9999 -- Maximum allowable temperature of the sim, in Kelvin<br>
simulation.MIN_TEMP = 0 -- Maximum allowable temperature of the sim, in Kelvin<br>
simulation.MAX_PRESSURE = 256 -- Maximum allowable pressure of the sim<br>
simulation.MIN_PRESSURE = -256 -- Minimum allowable pressure of the sim
--### **REPLACED BY `sim.partCount`**
---@deprecated
simulation.NUM_PARTS = nil -- Not actually a constant, this is updated every frame to reflect the current number of particles in the sim. Deprecated by sim.partCount

-- TODO: Use those below in function argument types

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
simulation.FIELD_DCOLOUR = 13
--### **REPLACED BY `sim.FIELD_TMP3`**
---@deprecated
simulation.FIELD_PAVG0 = 12 -- idk if value is correct
simulation.FIELD_TMP3 = 11
--### **REPLACED BY `sim.FIELD_TMP4`**
---@deprecated
simulation.FIELD_PAVG1 = 13-- idk if value is correct
simulation.FIELD_TMP4 = 12

simulation.PMAPMASK = 511
simulation.PMAPBITS = 9

simulation.BRUSH_CIRCLE = 0
simulation.BRUSH_SQUARE = 1
simulation.BRUSH_TRIANGLE = 2
simulation.NUM_DEFAULTBRUSHES = 3
--Number of total brushes, including any custom brushes<br>
---@type integer 
simulation.BRUSH_NUM = nil 

simulation.EDGE_VOID = 0
simulation.EDGE_SOLID = 1
simulation.EDGE_LOOP = 2
simulation.NUM_EDGEMODES = 3

simulation.AIR_ON = 0
simulation.AIR_PRESSUREOFF = 1
simulation.AIR_VELOCITYOFF = 2
simulation.AIR_OFF = 3
simulation.AIR_NOUPDATE = 4
simulation.NUM_AIRMODES = 5

simulation.NUM_WALLS = 19
---@type { [string]: integer } | { [integer]: string }
simulation.walls = nil

simulation.FLAG_MOVABLE = 8
simulation.FLAG_PHOTDECO = 8
simulation.FLAG_SKIPMOVE = 2
simulation.FLAG_STAGNANT = 1

simulation.GRAV_VERTICAL = 0
simulation.GRAV_OFF = 1
simulation.GRAV_RADIAL = 2
simulation.GRAV_CUSTOM = 3
simulation.NUM_GRAVMODES = 4

simulation.NUM_DECOSPACES = 4

---@type Sign[]|any
simulation.signs.MAX_SIGNS = 16
simulation.signs.NUM_JUSTMODES = 4
