---@meta
---@diagnostic disable:lowercase-global
---@diagnostic disable:duplicate-set-field

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

-- The Elements API contains methods and constants for listening to events. This is the API you should use if you want to handle mouse and keyboard input. Shorthand: you can use evt. instead of event. 
event = {}

-- TODO: Replace enum, move event declaration below all @alias annotations

---@enum EventType
event = {
    --### keypress<br>
    --> This event is sent every time a key is pressed, and continuously re-sent if they key is held down. This event should be used if you want to have a key shortcut; The textinput event should be used instead if you want to handle text input / Unicode.<br>
    --> This event can be canceled<br>
    --> Arguments: key, scan, repeat, shift, ctrl, alt<br>
    -->> key is the key code, a number that is usually the ascii value for the key, but for non-printable characters it may be a high number. You can find a list of key codes here: https://wiki.libsdl.org/SDLKeycodeLookup<br>
    -->> scan is the scan code. This is a number that represents the physical location of a key on a keyboard. You can find a list of scan codes here: https://wiki.libsdl.org/SDLScancodeLookup<br>
    -->> repeat is a boolean that tells whether this is a key repeat event (sent every so often when the key is held down). You may want to ignore this event when it is just a key repeat event<br>
    -->> shift / ctrl / alt are booleans that will tell you whether those modifiers are currently held<br>
    keypress = 0,

    --### keyrelease<br>
    --> This event is sent every time a key is released<br>
    --> This event can be canceled<br>
    --> Arguments: key, scan, repeat, shift, ctrl, alt<br>
    -->> These arguments mean exactly the same thing as for keypress events. Repeat will always be false.<br>
    keyrelease = 1,

    --### textinput<br>
    --> This event is sent every time text is input. The text will be sent as a string, and may be more than one character or contain Unicode.<br>
    --> Arguments: text<br>
    textinput = 2,

    -- Not documented on the wiki<br>
    -- TODO:uhh write documentation lol
    --### textediting<br>
    --> Arguments: text<br>
    textediting = 3,

    --### mousedown<br>
    --> This event is sent whenever the mouse is clicked.<br>
    --> This event can be canceled<br>
    --> Arguments: x, y, button<br>
    -->> x and y will not be adjusted for the zoom window. See sim.adjustCoords for that. Coordinates may be outside of the simulation bounds (clicks outside the simulation area are still sent)<br>
    -->> button is the mouse button pressed. 1 is left click, 2 is middle click, 3 is right click. There may also be higher mouse buttons like 4 and 5.<br>
    mousedown = 4,

    --### mouseup<br>
    --> This event is sent whenever the mouse is released. There are also other some special cases this event may be sent,<br>
    --> This event can be canceled (only when reason = 0)<br>
    --> Arguments: x, y, button, reason<br>
    -->> x, y, and button function the same as the mousedown event<br>
    -->> reason is a number that describes what type of mouseup event this is (basically, hacks we sent mouseup events on anyway). reason 0 is for normal mouseup events. reason 1 is used when another interface is opened and a blur event is sent. This is how tpt ensures that the mouse isn't "stuck" down forever if you release the mouse after opening another interface. reason 2 is used when the mouse moves inside or outside of the zoom window. This is how tpt cancels mouse drawing with zoom windows to ensure a big line isn't drawn across the screen. The normal reason = 0 event will still be sent later.<br>
    mouseup = 5,

    --### mousemove<br>
    --> This event is sent every time the mouse is moved. It is only sent when the mouse is inside the tpt window, unless the mouse is held, in which case it can also be sent outside of the tpt window until the mouse is released. Coordinates from outside the tpt window bounds (including negative coordinates) can be sent in that case.<br>
    --> This event can be canceled<br>
    --> Arguments: x, y, dx, dy<br>
    -->> x and y are the mouse coordinates. dx and dy are the diff from the previous coordinates to the current ones.<br>
    mousemove = 6,

    --### mousewheel<br>
    --> This event is sent whenever the mousewheel is scrolled.<br>
    --> This event can be canceled<br>
    --> Arguments: x, y, d<br>
    -->> x and y are the mouse position where the wheel was scrolled<br>
    -->> d is the distance the mouse was scrolled. On nearly all mice this will be 1 or -1, but in certain situations it may be higher. You most likely want to treat higher values as 1 or -1 anyway. Horizontal scrolling is not supported at the moment, in the meantime d will be 0 for horizontal scrolling.<br>
    mousewheel = 7,

    --### tick<br>
    --> This event is sent once per frame. It is sent after the simulation frame finishes and everything is drawn to the screen.<br>
    tick = 8,

    --### blur<br>
    --> This event is sent whenever a blocking interface (such as the save browser or the console) is opened. Lua scripts don't function in those interfaces, so this event can be used to detect when the lua script is about to stop receiving any events during that time.<br>
    blur = 9,

    --### close<br>
    --> This event is sent whenever the tpt window is about to close.<br>
    close = 10,

    --### beforesim<br>
    --> This event is sent once per frame, but only if the sim is unpaused or being stepped through using framestep or subframe particle debugging. It is sent before any particle simulation or air updates have been done.
    beforesim = 11,

    --### aftersim<br>
    --> This event is sent once per frame, but only if the sim is unpaused or being stepped through using framestep or subframe particle debugging. It is sent after all particles have been simulated.
    aftersim = 12,
    
    --### beforesimdraw<br>
    --> This event is sent once per frame, before the simulation is drawn. It is sent after pressure / velocity mode graphics are drawn (if enabled), but before all other particles or simulation graphics are drawn.
    beforesimdraw = 13,

    --### aftersimdraw<br>
    --> This event is sent once per frame, after the simulation is drawn. All particles and graphics, such as the cursor, are already drawn. The only thing not yet rendered is the zoom window.
    aftersimdraw = 14,
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
