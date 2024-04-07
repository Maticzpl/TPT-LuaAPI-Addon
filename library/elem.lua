---@meta
---@diagnostic disable:lowercase-global
---@diagnostic disable:duplicate-set-field


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
---|"CreateAllowed"
---|"ChangeType"
---|"CtypeDraw"

---@alias MenuSection
---|`elem.SC_WALL`
---|`elem.SC_ELEC`
---|`elem.SC_POWERED`
---|`elem.SC_SENSOR`
---|`elem.SC_FORCE`
---|`elem.SC_EXPLOSIVE`
---|`elem.SC_GAS`
---|`elem.SC_LIQUID`
---|`elem.SC_POWDERS`
---|`elem.SC_SOLIDS`
---|`elem.SC_NUCLEAR`
---|`elem.SC_SPECIAL`
---|`elem.SC_LIFE`
---|`elem.SC_TOOL`
---|`elem.SC_DECO`

---@alias PropertyProperty
---|`elem.TYPE_PART`
---|`elem.TYPE_LIQUID`
---|`elem.TYPE_SOLID`
---|`elem.TYPE_GAS`
---|`elem.TYPE_ENERGY`
---|`elem.PROP_CONDUCTS`
---|`elem.PROP_BLACK`
---|`elem.PROP_NEUTPENETRATE`
---|`elem.PROP_NEUTABSORB`
---|`elem.PROP_NEUTPASS`
---|`elem.PROP_DEADLY`
---|`elem.PROP_HOT_GLOW`
---|`elem.PROP_LIFE`
---|`elem.PROP_RADIOACTIVE`
---|`elem.PROP_LIFE_DEC`
---|`elem.PROP_LIFE_KILL`
---|`elem.PROP_LIFE_KILL_DEC`
---|`elem.PROP_SPARKSETTLE`
---|`elem.PROP_NOAMBHEAT`
---|`elem.PROP_DRAWONCTYPE`
---|`elem.PROP_NOCTYPEDRAW `

--TODO: Figure out if any of those are ints

-- `surround_space`	This is the number of particles with the same TYPE property in the Moore neighborhood surrounding the particle. Used primarily for GoL type elements.
-- `nt`	This is the number of empty spaces in the Moore neighborhood surrounding the particle.
---@alias UpdateFunc fun(UPDATE_index:number, x:number, y:number, surround_space:number, nt:number): number|nil 

---@alias GraphicsFunc fun(GRAPHICS_index:number, r:number, g:number, b:number): number,number,number,number,number,number,number,number,number,number

-- `v` This is an extra numeric property passed in sim.partCreate as part of the id number (currently bits 9 and above, counting from 0). It is effectively an extra multipurpose parameter for Create functions to handle however they like.
---@alias CreateFunc fun(CREATE_index:number, x:number, y:number, type:number, v:number)

---@alias CreateAllowedFunc fun(CREATE_ALLOWED_index:number, x:number, y:number, type:number)

---@alias ChangeTypeFunc fun(CHANGE_TYPE_index:number, x:number, y:number, type:number, new_type:number)

---@alias CtypeDrawFunc fun(CHANGE_TYPE_index:number, type:number, v:number)

---@alias PropertyFunctions UpdateFunc|GraphicsFunc|CreateFunc|ChangeTypeFunc|CreateAllowedFunc

---@alias RunUpdateWhen `elements.UPDATE_AFTER`|`elements.UPDATE_REPLACE`|`elements.UPDATE_BEFORE`

--The `elements` API contains methods and constants for creating and modifying elements.<br>
--**The shorter alias `elem` is also available.**<br>
-- Unless stated otherwise, all functions raise errors if supplied with parameters that disagree with their descriptions. 
elements = {}

--```
--elemNumber = elements.allocate(group, iname)
--```
-- Create a new element.<br>
--  - `group`: string without underscores (`_`), the group the element belongs to; gets uppercased by the function<br>
--  - `iname`: string without underscores (`_`), the internal name of the element; gets uppercased by the function<br>
--  - `elemNumber`: the positive element number allocated for the element created, or `-1` on error, if there are no free element numbers left<br>
--<br>
-- `group` should be something unique to your script, and should be the same across the entire script. It is common to use a simpler version of your username or the script’s name, for example if your script is called Ultimate Chemistry Pack v3, you might use `"CHEMPACK3"` as the group name.<br>
--<br>
-- `iname` should be unique to the element within your script, and should ultimately resemble the [`Name` property](https://powdertoy.co.uk/Wiki/W/Lua_API:Elements.html#elements.property) of the element. For example, if your element’s name is C-6 you should use `C6` as the internal name.<br>
--<br>
-- The resulting element identifier must be unique across all scripts in use at any point in time. Elements that seem like built-in elements, i.e. ones in the group `DEFAULT`, cannot be created. Note that, as stated above, both `group` and `iname` get uppercased, so `elements.allocate("CheMpaCk3", "c6")` is equivalent to `elements.allocate("CHEMPACK3", "C6")`.<br>
--<br>
-- Make the choice such that it is convenient to refer to your element via an [`elements.[group]_PT_[iname]` constant](https://powdertoy.co.uk/Wiki/W/Lua_API:Elements.html#elements.group_pt_iname). While it is perfectly possible to type `elem["Ultimate Chemistry Pack v3_PT_C-6"]`, it is much more convenient to type `elem.CHEMPACK3_PT_C6`.<br>
--<br>
-- The new element is created with all the default properties, and will not be visible until you modify it to show up in the menu.<br>
---@param group string  
---@param name string  
---@return integer
---@nodiscard
function elements.allocate(group, name)
end

--```
--elemProps = elements.element(elemNumber) -- query variant
--elements.element(elemNumber, elemProps) -- update variant
--```
-- Query all or update multiple properties of an element.<br>
--  - `elemNumber`: number of the element whose properties are to be queried or update<br>
--  - `elemProps`: table that maps property names to property values<br>
--<br>
-- The keys and values of `elemProps` are the same as the `propName` and `propValue` parameters of [elements.property](https://powdertoy.co.uk/Wiki/W/Lua_API:Elements.html#elements.property). The query variant returns all properties of the element in `elemProps` with the same caveats as [elements.property](https://powdertoy.co.uk/Wiki/W/Lua_API:Elements.html#elements.property). The update variant accepts any subset of properties, only updates the ones present in the table, applying the same checks as [elements.property](https://powdertoy.co.uk/Wiki/W/Lua_API:Elements.html#elements.property).<br>
--<br>
-- This function is commonly used to base an element off another element by first copying all properties of the source element and applying them to the new element, and then customizing the new element a bit afterwards:<br>
--```
--local purpleGold = elem.allocate("EXAMPLE", "PGLD")
--assert(purpleGold ~= -1, "ran out of element numbers")
--elem.element(purpleGold, elem.element(elem.DEFAULT_PT_GOLD))
--elem.property(purpleGold, "Name", "PGLD")
--elem.property(purpleGold, "Color", 0x8040FF)
--```
---@param elemNumber integer  
---@return Properties
function elements.element(elemNumber)
end
--```
--elemProps = elements.element(elemNumber) -- query variant
--elements.element(elemNumber, elemProps) -- update variant
--```
-- Query all or update multiple properties of an element.<br>
--  - `elemNumber`: number of the element whose properties are to be queried or update<br>
--  - `elemProps`: table that maps property names to property values<br>
--<br>
-- The keys and values of `elemProps` are the same as the `propName` and `propValue` parameters of [elements.property](https://powdertoy.co.uk/Wiki/W/Lua_API:Elements.html#elements.property). The query variant returns all properties of the element in `elemProps` with the same caveats as [elements.property](https://powdertoy.co.uk/Wiki/W/Lua_API:Elements.html#elements.property). The update variant accepts any subset of properties, only updates the ones present in the table, applying the same checks as [elements.property](https://powdertoy.co.uk/Wiki/W/Lua_API:Elements.html#elements.property).<br>
--<br>
-- This function is commonly used to base an element off another element by first copying all properties of the source element and applying them to the new element, and then customizing the new element a bit afterwards:<br>
--```
--local purpleGold = elem.allocate("EXAMPLE", "PGLD")
--assert(purpleGold ~= -1, "ran out of element numbers")
--elem.element(purpleGold, elem.element(elem.DEFAULT_PT_GOLD))
--elem.property(purpleGold, "Name", "PGLD")
--elem.property(purpleGold, "Color", 0x8040FF)
--```
---@param elemNumber integer  
---@param elemProps Properties  
function elements.element(elemNumber, elemProps)
end

--```
--propValue = elements.property(elemNumber, propName) -- query variant
--elements.property(elemNumber, propName, propValue) -- update variant
--elements.property(elemNumber, "Update", propValue, [runWhen]) -- special update variant for the Update property
--```
-- Query or update a property of an element.<br>
--  - `elemNumber`: number of the element whose property is to be queried or updated<br>
--  - `propName`: string, name of the property to be queried or updated<br>
--  - `propValue`: various types, value of the property to be queried or updated<br>
--  - `runWhen`: number, specifies when the update function should be run, one of:<br>
--      - `elements.UPDATE_AFTER`: run before the built-in update function, this is the default<br>
--      - `elements.UPDATE_REPLACE`: run instead of the built-in update function<br>
--      - `elements.UPDATE_BEFORE`: run after the built-in update function<br>
--<br>
-- For more information on what properties there are to use in elements.property, and how to use them, see this page: [Element_Properties](https://powdertoy.co.uk/Wiki/W/Element_Properties.html).<br>
--<br>
-- When working with the "MenuSection" or the "Properties" property, use one of the provided [constants](https://powdertoy.co.uk/Wiki/W/Lua_API:Elements.html#Constants).<br>
--<br>
-- The "Identifier" property is read-only and cannot be set.<br>
--<br>
-- Several event callback functions are implemented, such as "Update" and "Graphics". To set these, use a function for `propValue`. They are not included in the tables created with elements.element, and the functions can't be returned with elements.property either. This means copying all of an elements properties using elements.element will not set event callbacks for the new element. For help on creating these, see [Element_Properties#Callback_functions](https://powdertoy.co.uk/Wiki/W/Element_Properties.html#Callback_functions).<br>
---@param elemNumber integer
---@param propName Property|string
---@return any
function elements.property(elemNumber, propName)
end
--```
--propValue = elements.property(elemNumber, propName) -- query variant
--elements.property(elemNumber, propName, propValue) -- update variant
--elements.property(elemNumber, "Update", propValue, [runWhen]) -- special update variant for the Update property
--```
-- Query or update a property of an element.<br>
--  - `elemNumber`: number of the element whose property is to be queried or updated<br>
--  - `propName`: string, name of the property to be queried or updated<br>
--  - `propValue`: various types, value of the property to be queried or updated<br>
--  - `runWhen`: number, specifies when the update function should be run, one of:<br>
--      - `elements.UPDATE_AFTER`: run before the built-in update function, this is the default<br>
--      - `elements.UPDATE_REPLACE`: run instead of the built-in update function<br>
--      - `elements.UPDATE_BEFORE`: run after the built-in update function<br>
--<br>
-- For more information on what properties there are to use in elements.property, and how to use them, see this page: [Element_Properties](https://powdertoy.co.uk/Wiki/W/Element_Properties.html).<br>
--<br>
-- When working with the "MenuSection" or the "Properties" property, use one of the provided [constants](https://powdertoy.co.uk/Wiki/W/Lua_API:Elements.html#Constants).<br>
--<br>
-- The "Identifier" property is read-only and cannot be set.<br>
--<br>
-- Several event callback functions are implemented, such as "Update" and "Graphics". To set these, use a function for `propValue`. They are not included in the tables created with elements.element, and the functions can't be returned with elements.property either. This means copying all of an elements properties using elements.element will not set event callbacks for the new element. For help on creating these, see [Element_Properties#Callback_functions](https://powdertoy.co.uk/Wiki/W/Element_Properties.html#Callback_functions).<br>
---@param elemNumber integer
---@param propName Property|string
---@param propValue number|string|PropertyFunctions|PropertyProperty|any
---@param runWhen RunUpdateWhen
function elements.property(elemNumber, propName, propValue, runWhen)
end

--```
--exists = elements.exists(elemNumber)
--```
-- Check whether a number is a real element number and refers to an element.<br>
--  - `elemNumber`: number of the element to be checked<br>
--  - `exists`: boolean, `true` if `elemNumber` refers to an element<br>
--<br>
-- If an element exists, there exists a corresponding [`elements.[group]_PT_[iname]` constant](https://powdertoy.co.uk/Wiki/W/Lua_API:Elements.html#elements.group_pt_iname), and conversely, if there exists such a constant, there exists a corresponding element.<br>
---@param elemNumber integer
---@return boolean
function elements.exists(elemNumber)
end

--```
--elements.free(number elementID)
--```
-- Free a previously allocated element.<br>
--  - `elemNumber`: number of the element to be freed<br>
-- The element number is freed and can used later by another script. Built-in elements, i.e. elements in the group DEFAULT, cannot be freed.<br>
---@param elementID integer  
function elements.free(elementID)
end

--```
--elementNumber = elements.getByName(name)
--```
-- Find an element by name, the [`Name` property](https://powdertoy.co.uk/Wiki/W/Lua_API:Elements.html#elements.property).<br>
--  - `name`: string, the name to find the element by<br>
--  - `elemNumber`: positive number of the element name refers to, or -1 on error if no such element exists<br>
--<br>
-- This function converts a human-friendly element name to an element number, essentially the same way the PROP tool or the console works.<br>
---@param name string
function elements.getByName(name)
end

--```
--elements.loadDefault()
--```
-- Restore the set of elements to its initial state at startup.<br>
-- This frees all elements created and resets all properties of all built-in elements to their defaults.<br>
---@param id integer?
function elements.loadDefault(id)
end

elem = elements

elements.TYPE_PART = 1 -- Used in powders.
elements.TYPE_LIQUID = 2 -- Used in liquids.
elements.TYPE_SOLID = 4 -- Used in solids / misc elements.
elements.TYPE_GAS = 8 -- Used in gases.
elements.TYPE_ENERGY = 16 -- Used in energy particles.

---@deprecated ??? TODO: Make sure
elements.PROP_DRAWONCTYPE = 0 -- Set its ctype to another element if the element is drawn upon it (like what CLNE does).
elements.PROP_CONDUCTS = 32 -- Allows an element to automatically conduct SPRK, requires PROP_LIFE_DEC.
elements.PROP_BLACK = 64 -- Elements with this property absorb photons of any color.
elements.PROP_NEUTPENETRATE = 128 -- Elements can be displaced by neutrons (observe behavior of wood with neutrons to see).
elements.PROP_NEUTABSORB = 256 -- Element will absorb neutrons.
elements.PROP_NEUTPASS = 512 -- Element will allow neutrons to pass through it.
elements.PROP_DEADLY = 1024 -- Element will kill stickmen and fighters.
elements.PROP_HOT_GLOW = 2048 -- Element will glow red when it approaches it's melting point.
elements.PROP_LIFE = 4096 -- Unused.
elements.PROP_RADIOACTIVE = 8192 -- Element will have a radioactive glow, like URAN or PLUT. Also, deadly to stickmen.
elements.PROP_LIFE_DEC = 16384 -- The "life" property of particles will be reduced by 1 every frame.
elements.PROP_LIFE_KILL = 32768 -- Particles will be destroyed when the "life" property is less than or equal to zero.
elements.PROP_LIFE_KILL_DEC = 65536 -- When used with PROP_LIFE_DEC, particles will be destroyed when the "life" property is decremented to 0. If already at 0 it will be fine.
elements.PROP_SPARKSETTLE = 131072 -- Allows sparks/embers to contact without being destroyed.
elements.PROP_NOAMBHEAT = 262144 -- Prevents particles from exchanging heat with the air when ambient heat is enabled.
elements.PROP_NOCTYPEDRAW = 1048576 -- When this element is drawn upon other elements, do not set ctype (like STKM for CLNE).

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

--Set in `parts[i].flags`. Used by liquids and powders to speed up simulation by moving them less<br>
--### **REPLACED BY `sim.FLAG_STAGNANT`**
---@deprecated
elements.FLAG_STAGNANT = 1
--Set in `parts[i].flags`. Given to PHOT by PCLN and PBCN to fix gaps in lasers, only useable by energy particles<br>
--### **REPLACED BY `sim.FLAG_SKIPMOVE`**
---@deprecated
elements.FLAG_SKIPMOVE = 2
--Set in `parts[i].flags`. Used internally for water equalization<br>
elements.FLAG_WATEREQUAL = nil
--Set in `parts[i].flags`. Can be used to re-enable moving sponge<br>
--### **REPLACED BY `sim.FLAG_MOVABLE`**
---@deprecated
elements.FLAG_MOVABLE = 8
--Set in `parts[i].flags`. Re-enables deco on photons for compatibility. Defined as the same value as FLAG_MOVABLE (they only apply to different elements)<br>
--### **REPLACED BY `sim.FLAG_PHOTDECO`**
---@deprecated
elements.FLAG_PHOTDECO = 8

-- Deprecated missing stuff according to https://github.com/The-Powder-Toy/The-Powder-Toy/blob/master/src/lua/luascripts/compat.lua

---@deprecated
elements.ST_GAS = 0
---@deprecated
elements.ST_LIQUID = 0
---@deprecated
elements.ST_NONE = 0
---@deprecated
elements.ST_SOLID = 0

--#### Menu Sections<br>
elements.SC_WALL = 0
--#### Menu Sections<br>
elements.SC_ELEC = 1
--#### Menu Sections<br>
elements.SC_POWERED = 2
--#### Menu Sections<br>
elements.SC_SENSOR = 3
--#### Menu Sections<br>
elements.SC_FORCE = 4
--#### Menu Sections<br>
elements.SC_EXPLOSIVE = 5
--#### Menu Sections<br>
elements.SC_GAS = 6
--#### Menu Sections<br>
elements.SC_LIQUID = 7
--#### Menu Sections<br>
elements.SC_POWDERS = 8
--#### Menu Sections<br>
elements.SC_SOLIDS = 9
--#### Menu Sections<br>
elements.SC_NUCLEAR = 10
--#### Menu Sections<br>
elements.SC_SPECIAL = 11
--#### Menu Sections<br>
elements.SC_LIFE = 12
--#### Menu Sections<br>
elements.SC_TOOL = 13

-- 14 is faviourites

--#### Menu Sections<br>
elements.SC_DECO = 15
