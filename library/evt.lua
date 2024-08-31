---@meta
---@diagnostic disable:lowercase-global
---@diagnostic disable:duplicate-set-field

-- The Elements API contains methods and constants for listening to events. This is the API you should use if you want to handle mouse and keyboard input. Shorthand: you can use evt. instead of event. 
event = {}

-- TODO: Replace enum, move event declaration below all @alias annotations

---@enum EventType
event = {
    --### keypress<br>
    --> This event is sent every time a key is pressed, and continuously re-sent if they key is held down. This event should be used if you want to have a key shortcut; The textinput event should be used instead if you want to handle text input / Unicode.<br>
    --> This event can be canceled<br>
    --> Arguments: key, scan, repeat, shift, ctrl, alt<br>
    -->> **key** is the key code. This is a number that represents the symbol that may be printed on a key on a keyboard. The relation of these numbers to physical keys varies wildly across systems and keyboard layouts. The interface API provides constants you can use to compare this with: you can find a list of key codes [here](https://github.com/The-Powder-Toy/The-Powder-Toy/blob/master/src/lua/LuaSDLKeys.h) (the ones starting with SDLK, for example, interface.SDLK_a)<br>
    -->> **scan** is the scan code. This is a number that represents the physical location of a key on a keyboard. You can find a list of scan codes here: https://wiki.libsdl.org/SDLScancodeLookup<br>
    -->> **repeat** is a boolean that tells whether this is a key repeat event (sent every so often when the key is held down). You may want to ignore this event when it is just a key repeat event<br>
    -->> **shift / ctrl / alt** are booleans that will tell you whether those modifiers are currently held<br>
    KEYPRESS = 2,

    --### keyrelease<br>
    --> This event is sent every time a key is released<br>
    --> This event can be canceled<br>
    --> Arguments: key, scan, repeat, shift, ctrl, alt<br>
    -->> These arguments mean exactly the same thing as for keypress events. Repeat will always be false.<br>
    KEYRELEASE = 3,

    --### textinput<br>
    --> This event is sent every time text is input. The text will be sent as a string, and may be more than one character or contain Unicode.<br>
    --> Arguments: text<br>
    TEXTINPUT = 0,

    -- Not documented on the wiki<br>
    -- TODO:uhh write documentation lol
    --### textediting<br>
    --> Arguments: text<br>
    TEXTEDITING = 1,

    --### mousedown<br>
    --> This event is sent whenever the mouse is clicked.<br>
    --> This event can be canceled<br>
    --> Arguments: x, y, button<br>
    -->> **x and **y** will not be adjusted for the zoom window. See sim.adjustCoords for that. Coordinates may be outside of the simulation bounds (clicks outside the simulation area are still sent)<br>
    -->> **button** is the mouse button pressed. 1 is left click, 2 is middle click, 3 is right click. There may also be higher mouse buttons like 4 and 5.<br>
    MOUSEDOWN = 4,

    --### mouseup<br>
    --> This event is sent whenever the mouse is released. There are also other some special cases this event may be sent,<br>
    --> This event can be canceled (only when reason = 0)<br>
    --> Arguments: x, y, button, reason<br>
    -->> **x**, **y**, and **button** function the same as the mousedown event<br>
    -->> **reason** is a number that describes what type of mouseup event this is (basically, hacks we sent mouseup events on anyway). reason 0 is for normal mouseup events. reason 1 is used when another interface is opened and a blur event is sent. This is how tpt ensures that the mouse isn't "stuck" down forever if you release the mouse after opening another interface. reason 2 is used when the mouse moves inside or outside of the zoom window. This is how tpt cancels mouse drawing with zoom windows to ensure a big line isn't drawn across the screen. The normal reason = 0 event will still be sent later.<br>
    MOUSEUP = 5,

    --### mousemove<br>
    --> This event is sent every time the mouse is moved. It is only sent when the mouse is inside the tpt window, unless the mouse is held, in which case it can also be sent outside of the tpt window until the mouse is released. Coordinates from outside the tpt window bounds (including negative coordinates) can be sent in that case.<br>
    --> This event can be canceled<br>
    --> Arguments: x, y, dx, dy<br>
    -->> **x** and **y** are the mouse coordinates. **dx** and **dy** are the diff from the previous coordinates to the current ones.<br>
    MOUSEMOVE = 6,

    --### mousewheel<br>
    --> This event is sent whenever the mousewheel is scrolled.<br>
    --> This event can be canceled<br>
    --> Arguments: x, y, d<br>
    -->> **x** and **y** are the mouse position where the wheel was scrolled<br>
    -->> **d** is the distance the mouse was scrolled. On nearly all mice this will be 1 or -1, but in certain situations it may be higher. You most likely want to treat higher values as 1 or -1 anyway. Horizontal scrolling is not supported at the moment, in the meantime d will be 0 for horizontal scrolling.<br>
    MOUSEWHEEL = 7,

    --### tick<br>
    --> This event is sent once per frame. It is sent after the simulation frame finishes and everything is drawn to the screen.<br>
    TICK = 8,

    --### blur<br>
    --> This event is sent whenever a blocking interface (such as the save browser or the console) is opened. Lua scripts don't function in those interfaces, so this event can be used to detect when the lua script is about to stop receiving any events during that time.<br>
    BLUR = 9,

    --### close<br>
    --> This event is sent whenever the tpt window is about to close.<br>
    CLOSE = 10,

    --### beforesim<br>
    --> This event is sent once per frame, but only if the sim is unpaused or being stepped through using framestep or subframe particle debugging. It is sent before any particle simulation or air updates have been done.
    BEFORESIM = 11,

    --### aftersim<br>
    --> This event is sent once per frame, but only if the sim is unpaused or being stepped through using framestep or subframe particle debugging. It is sent after all particles have been simulated.
    AFTERSIM = 12,
    
    --### beforesimdraw<br>
    --> This event is sent once per frame, before the simulation is drawn. It is sent after pressure / velocity mode graphics are drawn (if enabled), but before all other particles or simulation graphics are drawn.
    BEFORESIMDRAW = 13,

    --### aftersimdraw<br>
    --> This event is sent once per frame, after the simulation is drawn. All particles and graphics, such as the cursor, are already drawn. The only thing not yet rendered is the zoom window.
    AFTERSIMDRAW = 14,
}

--TODO add mouse up reason alias

---@alias KeyPressCallback fun(KEYPRESS_key: SDLKeyCodes?, scan: SDLScanCodes?, rep: boolean?, shift: boolean?, ctrl: boolean?, alt: boolean?): boolean?
---@alias KeyReleaseCallback fun(KEYRELEASE_key: SDLKeyCodes?, scan: SDLScanCodes?, rep: string?, shift: boolean?, ctrl: boolean?, alt: boolean?): boolean?
---@alias TextInputCallback fun(TEXTINPUT_text: string?): boolean?
---@alias TextEditingCallback fun(TEXT_EDITING_text: string?): boolean?
---@alias MouseDownCallback fun(MOUSE_DOWN_x: integer?, y: integer?, button: SDLButtons?): boolean?
---@alias MouseUpCallback fun(MOUSE_UP_x: integer?, y: integer?, button: SDLButtons?, reason: integer?): boolean?
---@alias MouseMoveCallback fun(MOUSE_MOVE_x: integer?, y: integer?, dx: integer?, dy: integer?): boolean?
---@alias MouseWheelCallback fun(MOUSE_WHEEL_x: integer?, y: integer?, d: integer?): boolean?
--Rest is classified under function
   

---@alias EventCallback function|KeyPressCallback|KeyReleaseCallback|TextInputCallback|TextEditingCallback|MouseDownCallback|MouseUpCallback|MouseMoveCallback|MouseWheelCallback

--```
--event.register(eventType, eventHandler)
--```
--Registers an event handler for a certain type of event. See the list of constants at the bottom of the page for possible events you can listen to. The constants exist under the event namespace, not as strings. Returns eventHandler, in case it's a lambda function and you want to unregister it later.<br>
--The event handler will be called with a varying number of arguments, depending on which type of event is being handled. Certain events can also be canceled by returning false from the event.<br>
--**Example:**<br>
--```
--event.register(event.mousedown, function(x, y) print("mouse clicked at " .. x .. "," .. y) end)
--```
---@param eventType EventType
---@param eventHandler EventCallback
function event.register(eventType, eventHandler) end

--```
--event.unregister(eventType, eventHandler)
--```
--Unregister a previously registered event handler. Has no effect of this function wasn't registered or wasn't registered under this event type.<br>
---@param eventType EventType
---@param eventHandler EventCallback
function event.unregister(eventType, eventHandler) end

--```
--event.getmodifiers()
--```
--Gets the current keyboard modifier state. Includes bits describing whether shift, ctrl, alt, caps lock, num lock, and other modifiers are pressed / set.<br>
---@return integer
function event.getmodifiers() 
end

evt = event

--### **REPLACED BY `evt.AFTERSIMDRAW`**
---@deprecated
event.aftersimdraw = nil
--### **REPLACED BY `evt.AFTERSIM`**
---@deprecated
event.aftersim = nil
--### **REPLACED BY `evt.BEFORESIMDRAW`**
---@deprecated
event.beforesimdraw = nil
--### **REPLACED BY `evt.BEFORESIM`**
---@deprecated
event.beforesim = nil
--### **REPLACED BY `evt.BLUR`**
---@deprecated
event.blur = nil
--### **REPLACED BY `evt.CLOSE`**
---@deprecated
event.close = nil
--### **REPLACED BY `evt.getModifiers`**
---@deprecated
event.getmodifiers = nil
--### **REPLACED BY `evt.KEYPRESS`**
---@deprecated
event.keypress = nil
--### **REPLACED BY `evt.KEYRELEASE`**
---@deprecated
event.keyrelease = nil
--### **REPLACED BY `evt.MOUSEDOWN`**
---@deprecated
event.mousedown = nil
--### **REPLACED BY `evt.MOUSEMOVE`**
---@deprecated
event.mousemove = nil
--### **REPLACED BY `evt.MOUSEUP`**
---@deprecated
event.mouseup = nil
--### **REPLACED BY `evt.MOUSEWHEEL`**
---@deprecated
event.mousewheel = nil
--### **REPLACED BY `evt.TEXTEDITING`**
---@deprecated
event.textediting = nil
--### **REPLACED BY `evt.TEXTINPUT`**
---@deprecated
event.textinput = nil
--### **REPLACED BY `evt.TICK`**
---@deprecated
event.tick = nil
