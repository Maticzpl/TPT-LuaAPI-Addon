---@meta
---@diagnostic disable:lowercase-global
---@diagnostic disable:duplicate-set-field
---@diagnostic disable:deprecated

---@alias ButtonCallback fun(sender: Button)

---@alias SliderCallback fun(sender: Slider, value : integer)

---@alias CheckboxCallback fun(sender: Checkbox, checked: boolean)

---@alias TextboxCallback fun(sender: Textbox)


-- The Interface API includes objects for UI components such as buttons, labels, and checkboxes and methods for access to the very primitive window manager and input events.<br> 
-- All classes in here extend Component. That means the methods in here are standard and can be used in any component type. 
interface = {}

--Component
--#region<br>

    --Component is abstract, and cannot be created directly.
    ---@class Component
    Component = {}

    --```
    --Component:visible(flag)
    --```
    -- - `flag`: boolean true / false on whether the component is visible or not<br>
    ---@param visible boolean  
    function Component:visible(visible)    
    end
    --```
    --flag = Component:visible()
    --```
    -- - `flag`: boolean true / false on whether the component is visible or not<br>
    ---@return boolean 
    function Component:visible()
    end

    --```
    --width, height = Component:size()
    --```
    -- - `width`: The width of the component<br>
    -- - `height`: The height of the component<br>
    ---@return integer, integer 
    function Component:size()
    end
    --```
    --Component:size(width, height)
    --```
    -- - `width`: The width of the component<br>
    -- - `height`: The height of the component<br>
    ---@param width integer  
    ---@param height integer  
    function Component:size(width, height)
    end


    --```
    --Component:position(x, y)
    --```
    --  - `x`: The x coordinate of the component<br>
    --  - `y`: The y coordinate of the component<br>
    ---@param x integer  
    ---@param y integer  
    function Component:position(x,y)    
    end
    --```
    --x, y = Component:position()
    --```
    --  - `x`: The x coordinate of the component<br>
    --  - `y`: The y coordinate of the component<br>
    ---@return integer, integer 
    function Component:position()   
    end

--#endregion

--Button
--#region

    -- Used `ui.class(...)` to  hint at whats the new constructor thing

    ---### **REPLACED BY `ui.button(...)`**
    ---@deprecated
    Button = nil

    --Extends Component, fires "action" when clicked<br>
    ---@class Button : Component
    interface.button = {}

    --```
    --button = interface.button(x, y, width, height, [text], [tooltip])
    --```
    --Construct a new Button<br>
    --  - `button`: The button, see class Button documentation for details on its methods<br>
    --  - `x`: The x position of the button. This is relative to the parent window's top left corner.<br>
    --  - `y`: The y position of the button. This is relative to the parent window's top left corner.<br>
    --  - `width`: The width of the button<br>
    --  - `height`: The height of the button<br>
    --  - `text`: The text displayed inside the button. Defaults to empty string.<br>
    --  - `tooltip`: The tooltip. Only valid for buttons placed directly on the main screen, it will show up in the bottom right corner where element descriptions normally show. Defaults to empty string.<br>
    --
    --The button won't be automatically placed down, for that see Window::addComponent or ui.addComponent. You will almost certainly also want to add a callback with Button::action to set what happens when the button is clicked.<br>
    ---@param x integer
    ---@param y integer  
    ---@param width integer  
    ---@param height integer  
    ---@param text string?  
    ---@param tooltip string?  
    ---@return Button
    function interface.button(x, y, width, height, text, tooltip)
    end

    --```
    --Button:action(callback)
    --```
    -- - `callback`: The callback, a function which receives one argument, sender<br>
    --   - `sender`: The button itself<br>
    --
    --Sets the listener for button actions. The action is triggered whenever the button is left clicked (clicked means a full mousedown + mouseup happened inside the button).<br>
    -- Example:<br>
    --```
    --local newButton = ui.button(10, 10, 100, 17, "Times clicked: 0")
    --local counter = 0
    --newButton:action(function(sender)
    --	counter = counter + 1
    --	sender:text("Times clicked: " .. counter)
    --end)
    --interface.addComponent(newButton)
    --```
    ---@param callback ButtonCallback  
    function interface.button:action(callback)    
    end

    --```
    --text = Button:text()
    --```
    --  - `text`: The button text<br>
    ---@return string
    function interface.button:text()
    end
    --```
    --Button:text(text)
    --```
    --  - `text`: The button text<br>
    ---@param text string  
    function interface.button:text(text)
    end


    --```
    --flag = Button:enabled()
    --```
    --  - `flag`: Whether or not the button is enabled<br>
    --Controls the enabled flag of the button. Buttons that are disabled cannot be clicked, change to gray, and don't respond to mousemove events either.<br>
    ---@return boolean 
    function interface.button:enabled()
    end
    --```
    --Button:enabled(flag)
    --```
    --  - `flag`: Whether or not the button is enabled<br>
    --Controls the enabled flag of the button. Buttons that are disabled cannot be clicked, change to gray, and don't respond to mousemove events either.<br>
    ---@param enabled boolean  
    function interface.button:enabled(enabled)
    end
--#endregion

--ProgressBar
--#region

    ---### **REPLACED BY `ui.progressBar(...)`**
    ---@deprecated
    ProgressBar = nil

    --Extends Component, used to indicate progress for long running tasks<br>
    ---@class ProgressBar : Component
    interface.progressBar = {}


    --```
    --progressBar = interface.progressBar(x, y, width, height, [progress], [status])
    --```
    --Construct a new ProgressBar<br>
    --  - `progressBar`: The progress bar, see class ProgressBar documentation for details on its methods<br>
    --  - `x`: The x position of the progress bar. This is relative to the parent window's top left corner.<br>
    --  - `y`: The y position of the progress bar. This is relative to the parent window's top left corner.<br>
    --  - `width`: The width of the progress bar<br>
    --  - `height`: The height of the progress bar<br>
    --  - `progress`: The initial progress. Must be between -1 and 100. Defaults to 0. -1 is a special case which will show a constant progress animation.<br>
    --  - `status`: The status. Will be drawn as text inside the progress bar.<br>
    --
    --The progress bar won't be automatically placed down, for that see Window::addComponent or ui.addComponent. Progress bars don't make any progress by default. You're responsible in your code for setting progress to a value between 0 and 100 to indicate the percentage. To show a constant scrolling animation, progress can be set to -1. This can be seen, for example, after downloading an update and it begins unpacking.<br>
    ---@param x integer  
    ---@param y integer  
    ---@param width integer  
    ---@param height integer  
    ---@param progress integer  
    ---@param status string  
    ---@return ProgressBar
    function interface.progressBar(x, y, width, height, progress, status)
    end

    --```
    --progress = ProgressBar:progress()
    --```
    --  - `progress`: The current progress value<br>
    --
    --Gets or sets the current progress. Progress ranges from 0 to 100, but a special case of <tt>-1</tt> will change the behavior of the progress bar to intermediate (constantly scrolling to indicate progress)<br>
    ---@return integer
    function interface.progressBar:progress()
    end
    --```
    --ProgressBar:progress(progress)
    --```
    --  - `progress`: The current progress value<br>
    --
    --Gets or sets the current progress. Progress ranges from 0 to 100, but a special case of <tt>-1</tt> will change the behavior of the progress bar to intermediate (constantly scrolling to indicate progress)<br>
    ---@param progress integer  
    function interface.progressBar:progress(progress)
    end

    --```
    --text = ProgressBar:status()
    --```
    --  - `text`: The progress bar status<br>
    --
    --Status is simply a text representation of the current action being performed, for example, "Working" or just a percentage<br>
    ---@return string
    function interface.progressBar:status()
    end
    --```
    --ProgressBar:status(text)
    --```
    --  - `text`: The progress bar status<br>
    --
    --Status is simply a text representation of the current action being performed, for example, "Working" or just a percentage<br>
    ---@param status string  
    function interface.progressBar:status(status)
    end
--#endregion

--Slider
--#region

    ---### **REPLACED BY `ui.slider(...)`**
    ---@deprecated
    Slider = nil

    --Extends Component, fires "onValueChanged" when the value is changed (i.e used by the user)<br>
    ---@class Slider : Component
    interface.slider = {}

    --```
    --slider = interface.slider(x, y, width, height, steps)
    --```
    --Construct a new Slider<br>
    --  - `x`: The x position of the slider. This is relative to the parent window's top left corner.<br>
    --  - `y`: The y position of the slider. This is relative to the parent window's top left corner.<br>
    --  - `width`: The width of the slider<br>
    --  - `height`: The height of the slider<br>
    --  - `steps`: The number of steps this slider has. AKA how many "notches" will it stop at while the user drags it.<br>
    --
    --The progress bar won't be automatically placed down, for that see Window::addComponent or ui.addComponent. For an example of a slider in TPT's ui, check the color picker in the deco editor.<br>
    ---@param x integer  
    ---@param y integer  
    ---@param width integer  
    ---@param height integer  
    ---@param steps integer?  
    ---@return Slider
    function interface.slider(x, y, width, height, steps)
    end

    --```
    --Slider:onValueChanged(callback)
    --```
    --  - `callback`: The callback, a function which receives two arguments, `sender` and `value`<br>
    --     - `sender`: The slider itself<br>
    --     - `value`: The value the slider was set to<br>
    --
    --Called whenever the slider value changes due to a change by the user. Changes made to the value from Lua don't trigger the callback.<br>
    ---@param callback SliderCallback  
    function interface.slider:onValueChanged(callback)    
    end

    --```
    --value = Slider:value()
    --```
    --  - `value`: The value of the slider, which is a number in the range [0, steps]<br>
    ---@return integer
    function interface.slider:value()
    end
    --```
    --Slider:value(value)
    --```
    --  - `value`: The value of the slider, which is a number in the range [0, steps]<br>
    ---@param value integer  
    function interface.slider:value(value)
    end

    --```
    --steps = Slider:steps()
    --```
    --  - `steps`: The number of steps the slider has. Must be a positive number. If the current slider position is greater than the new number of steps, the slider position will be set to the new max.<br>
    ---@return integer
    function interface.slider:steps()
    end
    --```
    --Slider:steps(steps)
    --```
    --  - `steps`: The number of steps the slider has. Must be a positive number. If the current slider position is greater than the new number of steps, the slider position will be set to the new max.<br>
    ---@param steps integer  
    function interface.slider:steps(steps)
    end
--#endregion

--Checkbox
--#region

    ---### **REPLACED BY `ui.checkbox(...)`**
    ---@deprecated
    Checkbox = nil

    --Extends Component, fires "action" when the checkbox is checked or unchecked<br>
    ---@class Checkbox : Component
    interface.checkbox = {}


    --```
    --checkbox = interface.checkbox(x, y, width, height, [text])
    --```
    --Construct a new Checkbox<br>
    --  - `x`: The x position of the checkbox. This is relative to the parent window's top left corner.<br>
    --  - `y`: The y position of the checkbox. This is relative to the parent window's top left corner.<br>
    --  - `width`: The width of the checkbox mouseover area<br>
    --  - `height`: The height of the checkbox mouseover area<br>
    --  - `text`: Text displayed to the right of the checkbox. Optional, the default is empty string.<br>
    --
    --The checkbox won't be automatically placed down, for that see Window::addComponent. The size of the square "checkbox" itself is always constant. `width` / `height` are instead used to control the area where mouseover events allow you to check / uncheck the box. 16 is recommended for height, for width you should ensure it's at least as wide as the text.<br>
    ---@param x integer  
    ---@param y integer  
    ---@param width integer  
    ---@param height integer  
    ---@param text string?  
    ---@return Checkbox
    function interface.checkbox(x, y, width, height, text)
    end

    --```
    --Checkbox:action(callback)
    --```
    --  - `callback`: The callback, a function which receives two arguments, `sender` and `checked`<br>
    --     - `sender`: The checkbox itself<br>
    --     - `checked`: A true / false flag on whether the checkbox is currently checked<br>
    --
    --Called whenever the checkbox state is toggled due to a change by the user.<br>
    ---@param callback CheckboxCallback  
    function interface.checkbox:action(callback)
    end

    --```
    --text = Checkbox:text()
    --```
    --  - `text`: The checkbox's text<br>
    --
    --Text is drawn to the right of the checkbox, see for example the options menu. The text that responds to mouseover events is part of the checkbox itself. (The text underneath is a separate Label)<br>
    ---@return string
    function interface.checkbox:text()
    end    
    --```
    --Checkbox:text(text)
    --```
    --  - `text`: The checkbox's text<br>
    --
    --Text is drawn to the right of the checkbox, see for example the options menu. The text that responds to mouseover events is part of the checkbox itself. (The text underneath is a separate Label)<br>
    ---@param text string  
    function interface.checkbox:text(text)
    end

    --```
    --flag = Checkbox:checked()
    --```
    --  - `flag`: The checked state of the checkbox, a boolean true / false flag<br>
    ---@return boolean
    function interface.checkbox:checked()
    end
    --```
    --Checkbox:checked(flag)
    --```
    --  - `flag`: The checked state of the checkbox, a boolean true / false flag<br>
    ---@param checked boolean  
    function interface.checkbox:checked(checked)
    end
--#endregion

--Label
--#region

    ---### **REPLACED BY `ui.label(...)`**
    ---@deprecated
    Label = nil

    --Extends Component, is a simple selectable, readonly text field<br>
    ---@class Label : Component
    interface.label = {}

    --```
    --label = interface.label(x, y, width, height, text)
    --```
    --Construct a new Label<br>
    --  - `x`: The x position of the label. This is relative to the parent window's top left corner.<br>
    --  - `y`: The y position of the label. This is relative to the parent window's top left corner.<br>
    --  - `width`: The width of the label<br>
    --  - `height`: The height of the label<br>
    --  - `text`: Label text<br>
    --
    --The label won't be automatically placed down, for that see Window::addComponent. Label text that extends past the width or height of the label will be cut off at the border. For that reason, and to ensure proper text selection via mouse events, please make sure the label size fits the text being displayed.<br>
    --Labels are horizontally centered by default. This creates problems for left-aligned text in interfaces. To properly left align text, you should get the exact width with [gfx.textSize](https://powdertoy.co.uk/Wiki/W/Lua_API:Graphics.html#graphics.textSize). For single line labels, height should be set to 16.<br>
    ---@param x integer  
    ---@param y integer  
    ---@param width integer  
    ---@param height integer  
    ---@param text string? TODO: Check if this is actually optional in source code
    ---@return Label
    function interface.label(x, y, width, height, text)
    end

    --```
    --text = Label:text()
    --```
    --  - `text`: The label text<br>
    ---@return string
    function interface.label:text()
    end
    --```
    --Label:text(text)
    --```
    --  - `text`: The label text<br>
    ---@param text string  
    function interface.label:text(text)
    end
--#endregion

--Textbox
--#region

    ---### **REPLACED BY `ui.textbox(...)`**
    ---@deprecated
    Textbox = nil

    --Extends Component, is a text input field, the placeholder text is shown if the component is no focused and contains no text<br>
    ---@class Textbox : Component
    interface.textbox = {}

    --```
    --textbox = interface.textbox(x, y, width, height, [text], [placeholder])
    --```
    --Construct a new Textbox<br>
    --  - `x`: The x position of the textbox. This is relative to the parent window's top left corner.<br>
    --  - `y`: The y position of the textbox. This is relative to the parent window's top left corner.<br>
    --  - `width`: The width of the textbox<br>
    --  - `height`: The height of the textbox<br>
    --  - `text`: Optional default text<br>
    --  - `placeholder`: Optional text that is shown when the textbox is both unfocused and empty. Used, for example, to show [password] in the login ui.<br>
    --
    --The textbox won't be automatically placed down, for that see Window::addComponent. A border will be drawn around the textbox. The text length is unrestricted, if the text typed by the user is too long, then it will scroll to the left and right. Pressing enter in a textbox will no-op, and newlines are not accepted. Limits on length and valid characters can be applied by listening to the text change event.<br>
    ---@param x integer  
    ---@param y integer  
    ---@param width integer  
    ---@param height integer  
    ---@param text string?
    ---@param placeholder string? 
    ---@return Textbox
    function interface.textbox(x, y, width, height,text,placeholder)
    end

    --```
    --Textbox:onTextChanged(callback)
    --```
    --  - `callback`: The callback, a function which receives one argument, `sender`<br>
    --     - `sender`: The textbox itself<br>
    --
    --Called whenever the textbox is changed due to an action by the user. For example, typing or deleting a character, cutting or pasting text. Changes via Lua do not trigger this callback.<br>
    ---@param callback TextboxCallback  
    function interface.textbox:onTextChanged(callback)    
    end

    --```
    --text = Textbox:text()
    --```
    --  - `text`: The textbox's text<br>
    --
    --When setting text, the old selection is cleared, the text is replaced, and the cursor is set to the end.<br>
    ---@return string
    function interface.textbox:text()
    end
    --```
    --Textbox:text(text)
    --```
    --  - `text`: The textbox's text<br>
    --
    --When setting text, the old selection is cleared, the text is replaced, and the cursor is set to the end.<br>
    ---@param text string  
    function interface.textbox:text(text)
    end

    --```
    --flag Textbox:readonly()
    --```
    --  - `flag`: true / false flag for the textbox's readonly flag.<br>
    --
    --readonly textboxes can't have their text changed in any way. The only possible user interaction is moving the cursor and text selection operations.<br>
    ---@return boolean
    function interface.textbox:readonly()
    end
    --```
    --Textbox:readonly(flag)
    --```
    --  - `flag`: true / false flag for the textbox's readonly flag.<br>
    --
    --readonly textboxes can't have their text changed in any way. The only possible user interaction is moving the cursor and text selection operations.<br>
    ---@param readonly boolean  
    function interface.textbox:readonly(readonly)
    end
--#endregion

--Window
--#region

    ---### **REPLACED BY `ui.window(...)`**
    ---@deprecated
    Window = nil

    --A modal form to display components, using -1 for either x or y values will centre the Window on that axis.<br>
    ---@class Window
    interface.window = {}

    --```
    --window = interface.window(x, y, width, height)
    --```
    --Construct a new Window<br>
    --  - `x`: The x position of the window. Use -1 to center it horizontally.<br>
    --  - `y`: The y position of the window. Use -1 to center it vertically.<br>
    --  - `width`: The width of the window. Must be at least 10.<br>
    --  - `height`: The height of the window. Must be at least 10.<br>
    --
    --The window won't be automatically placed down, for that see [interface.showWindow](https://powdertoy.co.uk/Wiki/W/.html#interface.showWindow). Once the window is added, it takes focus and receives all input events, and the main TPT window is no longer active. Parent windows are drawn underneath and dimmed out. Parents windows (aka the main window) don't run any tick events either. This means all Lua scripts will stop processing until the window closes, including your own. To handle input events like mouse, keyboard, and ticks, special window event handlers need to be registered instead.<br>
    --
    --By default, the Window can't be closed. Clicking outside of the window and ESC normally close windows, but this behavior needs to be added manually by listening to the `onTryExit` event. Clicking the "X" button from your OS still closes the window.<br>
    ---@param x integer  
    ---@param y integer  
    ---@param width integer  
    ---@param height integer 
    ---@return Window 
    function interface.window(x, y, width, height)
    end

    -- Sets the window position. Both coordinates must be greater or equal to 1
    ---@param x integer
    ---@param y integer
    function interface.window:position(x,y)            
    end

    -- Gets the window position
    ---@return integer x, integer y
    function interface.window:position()            
    end

    -- Sets the window size. Both arguments must be greater or equal to 10
    ---@param w integer
    ---@param h integer
    function interface.window:size(w,h)            
    end

    -- Gets the window size
    ---@return integer w, integer h
    function interface.window:size()            
    end

    --```
    --Window:addComponent(component)
    --```
    --  - `component`: The component to add<br>
    --
    --Adds a component to the window. The component must not have already been added to another Window object.<br>
    ---@param newComponent Component  
    function interface.window:addComponent(newComponent)
    end

    --```
    --Window:removeComponent(component)
    --```
    --  - `component`: The component to remove<br>
    --
    --Remove a component from the window. If this component isn't part of the window, does nothing.<br>
    ---@param component Component  
    function interface.window:removeComponent(component)
    end

    -- TODO: descriptions for callbacks below

    -- Triggers every frame that the window is drawn. Allows for using gfx together with ui
    ---@param listener fun()
    function interface.window:onDraw(listener)            
    end

    ---@param listener fun()
    function interface.window:onInitialized(listener)            
    end

    ---@param listener fun()
    function interface.window:onExit(listener)            
    end

    ---@param listener fun(deltaTime :number?)
    function interface.window:onTick(listener)            
    end

    ---@param listener fun()
    function interface.window:onFocus(listener)            
    end

    ---@param listener fun()
    function interface.window:onBlur(listener)            
    end

    ---@param listener fun()
    function interface.window:onTryExit(listener)            
    end
    
    ---@param listener fun()
    function interface.window:onTryOkay(listener)            
    end
    
    ---@param listener MouseMoveCallback
    function interface.window:onMouseMove(listener)            
    end
    
    ---@param listener MouseDownCallback
    function interface.window:onMouseDown(listener)            
    end

    ---@param listener MouseDownCallback
    function interface.window:onMouseUp(listener)            
    end

    ---@param listener MouseWheelCallback
    function interface.window:onMouseWheel(listener)            
    end

    ---@param listener KeyPressCallback
    function interface.window:onKeyPress(listener)            
    end

    ---@param listener KeyPressCallback
    function interface.window:onKeyRelease(listener)            
    end

--#endregion

--```
--nil interface.showWindow(Window newWindow)
--```
--Push a Window into the top of the modal stack<br>
---@param newWindow Window
function interface.showWindow(newWindow)
end

--```
--nil interface.closeWindow(Window newWindow)
--```
--Pop a Window off the top of the modal stack. If the given Window is not the top item in the stack, this will have no effect.<br>
---@param newWindow Window
function interface.closeWindow(newWindow)
end

--```
--nil interface.addComponent(Component newComponent)
--```
--Add a component to master game window.<br>
---@param newComponent Component  
function interface.addComponent(newComponent)
end


--```
--nil interface.removeComponent(Component newComponent)
--```
--Remove a component from the master game window.<br>
---@param component Component  
function interface.removeComponent(component)
end


--```
--nil interface.grabTextInput()
--```
--Signal to the interface engine that textinput events are expected and will be handled (for example, your textbox just gained focus and is ready for such events). Once called, it should not be called again until after calling interface.dropTextInput; see below.<br>
--From the API user's perspective, the grabTextInput-dropTextInput pair implements an on-off switch. The purpose of this switch is to help the interface engine determine when to enter and exit text input state. In this state, the engine asks for OS help with text input (which may or may not involve enabling an Input Method) and delivers textinput events received from the OS to the API user.<br>
--The engine should only enter text input state when the API user expects textinput events (for example, when a textbox is in focus). To correctly communicate this, grabTextInput should be called when processing of textinput events starts and dropTextInput when it ends. Note that textinput events may be delivered regardless of the state of this on-off switch, most likely as a result of another API user calling grabTextInput and dropTextInput.<br>
function interface.grabTextInput() end

--```
--nil interface.dropTextInput()
--```
--Signal to the interface engine that textinput events are not expected and will not be handled (for example, your textbox just lost focus and will not handle such events anymore). Once called, it should not be called again until after calling interface.grabTextInput; see above.<br>
function interface.dropTextInput() end

--```
--nil interface.textInputRect(number x, number y, number w, number h)
--```
--Enables composition, for multi-byte unicode characters.<br>
---@param x integer  
---@param y integer  
---@param w integer  
---@param h integer  
function interface.textInputRect(x, y, w, h)
end


-- LuaLS doesn't like optionals that aren't last sooo multiple functions it is

--```
--interface.beginConfirm(title, message, buttonText, callback)
--```
-- Opens a confirm prompt, and runs a callback after the user's input.<br>
--  - `title`: Header message for the confirm prompt. Default "Title"<br>
--  - `message`: Body message for the confirm prompt, can be multiple lines. Default "Message"<br>
--  - `buttonText`: Text to display for the confirm button. Default "Confirm"<br>
--  - `callback`: Callback function to run after the user gives input. Receives a single boolean as an argument.<br>
--<br>
-- Only the `callback` argument is required. The rest are optional. The final arg to the function will be used as the callback. If the user clicks "Confirm" or presses enter, `true` is passed in. If the user clicks "Cancel", presses escape, or closes the dialog any other way, `false` is passed.<br>
---@param title string
---@param message string
---@param buttonText string
---@param callback fun(confirmed: boolean)
function interface.beginConfirm(title, message, buttonText, callback) end
-- Opens a confirm prompt, and runs a callback after the user's input.<br>
--  - `title`: Header message for the confirm prompt. Default "Title"<br>
--  - `message`: Body message for the confirm prompt, can be multiple lines. Default "Message"<br>
--  - `buttonText`: Text to display for the confirm button. Default "Confirm"<br>
--  - `callback`: Callback function to run after the user gives input. Receives a single boolean as an argument.<br>
--<br>
-- Only the `callback` argumenu is required. The resu are optional. The final arg to the function will be used as the callback. If the user clicks "Confirm" or presses enter, `true` is passed in. If the user clicks "Cancel", presses escape, or closes the dialog any other way, `false` is passed.<br>
---@param title string
---@param message string
---@param callback fun(confirmed: boolean)
function interface.beginConfirm(title, message, callback) end
-- Opens a confirm prompt, and runs a callback after the user's input.<br>
--  - `title`: Header message for the confirm prompt. Default "Title"<br>
--  - `message`: Body message for the confirm prompt, can be multiple lines. Default "Message"<br>
--  - `buttonText`: Text to display for the confirm button. Default "Confirm"<br>
--  - `callback`: Callback function to run after the user gives input. Receives a single boolean as an argument.<br>
--<br>
-- Only the `callback` argument is required. The rest are optional. The final arg to the function will be used as the callback. If the user clicks "Confirm" or presses enter, `true` is passed in. If the user clicks "Cancel", presses escape, or closes the dialog any other way, `false` is passed.<br>
---@param title string
---@param callback fun(confirmed: boolean)
function interface.beginConfirm(title, callback) end
-- Opens a confirm prompt, and runs a callback after the user's input.<br>
--  - `title`: Header message for the confirm prompt. Default "Title"<br>
--  - `message`: Body message for the confirm prompt, can be multiple lines. Default "Message"<br>
--  - `buttonText`: Text to display for the confirm button. Default "Confirm"<br>
--  - `callback`: Callback function to run after the user gives input. Receives a single boolean as an argument.<br>
--
-- Only the `callback` argument is required. The rest are optional. The final arg to the function will be used as the callback. If the user clicks "Confirm" or presses enter, `true` is passed in. If the user clicks "Cancel", presses escape, or closes the dialog any other way, `false` is passed.<br>
---@param callback fun(confirmed: boolean)
function interface.beginConfirm(callback) end


--```
--interface.beginInput(title, prompt, text, shadow, callback)
--```
-- Opens an input prompt, and runs a callback after the user's input.<br>
--  - `title`: Header message for the input prompt. Default "Title"<br>
--  - `prompt`: Body message for the input prompt, can be multiple lines. Default "Enter some text:"<br>
--  - `text`: Default text for the textbox. Defaults to empty string.<br>
--  - `shadow`: Default shadow text displayed when textbox is empty and defocused. Defaults to empty string.<br>
--  - `callback`: Callback function to run after the user gives input. Receives either a string or nil as the only argument.<br>
--<br>
-- Only the `callback` argument is required. The rest are optional. The final arg to the function will be used as the callback. If the user clicks "Okay" or presses enter, the textbox's text is passed. If the user clicks "Cancel", presses escape, or closes the dialog any other way, `nil` is passed.<br>
---@param title string
---@param prompt string
---@param text string
---@param shadow string
---@param callback fun(userInput: string?)
function interface.beginInput(title, prompt, text, shadow, callback)
end
-- Opens an input prompt, and runs a callback after the user's input.<br>
--  - `title`: Header message for the input prompt. Default "Title"<br>
--  - `prompt`: Body message for the input prompt, can be multiple lines. Default "Enter some text:"<br>
--  - `text`: Default text for the textbox. Defaults to empty string.<br>
--  - `shadow`: Default shadow text displayed when textbox is empty and defocused. Defaults to empty string.<br>
--  - `callback`: Callback function to run after the user gives input. Receives either a string or nil as the only argument.<br>
--<br>
-- Only the `callback` argument is required. The rest are optional. The final arg to the function will be used as the callback. If the user clicks "Okay" or presses enter, the textbox's text is passed. If the user clicks "Cancel", presses escape, or closes the dialog any other way, `nil` is passed.<br>
---@param title string
---@param prompt string
---@param text string
---@param callback fun(userInput: string?)
function interface.beginInput(title, prompt, text, callback)
end
-- Opens an input prompt, and runs a callback after the user's input.<br>
--  - `title`: Header message for the input prompt. Default "Title"<br>
--  - `prompt`: Body message for the input prompt, can be multiple lines. Default "Enter some text:"<br>
--  - `text`: Default text for the textbox. Defaults to empty string.<br>
--  - `shadow`: Default shadow text displayed when textbox is empty and defocused. Defaults to empty string.<br>
--  - `callback`: Callback function to run after the user gives input. Receives either a string or nil as the only argument.<br>
--<br>
-- Only the `callback` argument is required. The rest are optional. The final arg to the function will be used as the callback. If the user clicks "Okay" or presses enter, the textbox's text is passed. If the user clicks "Cancel", presses escape, or closes the dialog any other way, `nil` is passed.<br>
---@param title string
---@param prompt string
---@param callback fun(userInput: string?)
function interface.beginInput(title, prompt, callback)
end
-- Opens an input prompt, and runs a callback after the user's input.<br>
--  - `title`: Header message for the input prompt. Default "Title"<br>
--  - `prompt`: Body message for the input prompt, can be multiple lines. Default "Enter some text:"<br>
--  - `text`: Default text for the textbox. Defaults to empty string.<br>
--  - `shadow`: Default shadow text displayed when textbox is empty and defocused. Defaults to empty string.<br>
--  - `callback`: Callback function to run after the user gives input. Receives either a string or nil as the only argument.<br>
--<br>
-- Only the `callback` argument is required. The rest are optional. The final arg to the function will be used as the callback. If the user clicks "Okay" or presses enter, the textbox's text is passed. If the user clicks "Cancel", presses escape, or closes the dialog any other way, `nil` is passed.<br>
---@param title string
---@param callback fun(userInput: string?)
function interface.beginInput(title, callback)
end
-- Opens an input prompt, and runs a callback after the user's input.<br>
--  - `title`: Header message for the input prompt. Default "Title"<br>
--  - `prompt`: Body message for the input prompt, can be multiple lines. Default "Enter some text:"<br>
--  - `text`: Default text for the textbox. Defaults to empty string.<br>
--  - `shadow`: Default shadow text displayed when textbox is empty and defocused. Defaults to empty string.<br>
--  - `callback`: Callback function to run after the user gives input. Receives either a string or nil as the only argument.<br>
--<br>
-- Only the `callback` argument is required. The rest are optional. The final arg to the function will be used as the callback. If the user clicks "Okay" or presses enter, the textbox's text is passed. If the user clicks "Cancel", presses escape, or closes the dialog any other way, `nil` is passed.<br>
---@param callback fun(userInput: string?)
function interface.beginInput(callback)
end


--```
--interface.beginMessageBox(title, message, large, callback)
--```
-- Opens a message box, and runs a callback after the user closes it.<br>
--  - `title`: Header message for the message box. Default "Title"<br>
--  - `message`: Body message for the message box, can be multiple lines. Default "Message"<br>
--  - `large`: boolean that controls if the message box should be a fixed-size larger variant, that is both taller and wider. Default false.<br>
--  - `callback`: Callback function to run after the user closes the message box. Runs no matter how it is closed, and takes no arguments.<br>
--<br>
--All arguments are optional. The final arg to the function will be used as the callback.<br>
---@param title string
---@param message string
---@param large boolean
---@param callback fun()
function interface.beginMessageBox(title, message, large, callback)
end
-- Opens a message box, and runs a callback after the user closes it.<br>
--  - `title`: Header message for the message box. Default "Title"<br>
--  - `message`: Body message for the message box, can be multiple lines. Default "Message"<br>
--  - `large`: boolean that controls if the message box should be a fixed-size larger variant, that is both taller and wider. Default false.<br>
--  - `callback`: Callback function to run after the user closes the message box. Runs no matter how it is closed, and takes no arguments.<br>
--<br>
--All arguments are optional. The final arg to the function will be used as the callback.<br>
---@param title string
---@param message string
---@param callback fun()
function interface.beginMessageBox(title, message, callback)
end
-- Opens a message box, and runs a callback after the user closes it.<br>
--  - `title`: Header message for the message box. Default "Title"<br>
--  - `message`: Body message for the message box, can be multiple lines. Default "Message"<br>
--  - `large`: boolean that controls if the message box should be a fixed-size larger variant, that is both taller and wider. Default false.<br>
--  - `callback`: Callback function to run after the user closes the message box. Runs no matter how it is closed, and takes no arguments.<br>
--<br>
--All arguments are optional. The final arg to the function will be used as the callback.<br>
---@param title string
---@param callback fun()
function interface.beginMessageBox(title, callback)
end
-- Opens a message box, and runs a callback after the user closes it.<br>
--  - `title`: Header message for the message box. Default "Title"<br>
--  - `message`: Body message for the message box, can be multiple lines. Default "Message"<br>
--  - `large`: boolean that controls if the message box should be a fixed-size larger variant, that is both taller and wider. Default false.<br>
--  - `callback`: Callback function to run after the user closes the message box. Runs no matter how it is closed, and takes no arguments.<br>
--<br>
--All arguments are optional. The final arg to the function will be used as the callback.<br>
---@param callback fun()
function interface.beginMessageBox(callback)
end

--```
--interface.beginThrowError(errorMessage, callback)
--```
-- Opens an error dialog box, and runs a callback after the user closes it.<br>
--  - `errorMessage`: Body message for the error prompt, can be multiple lines. Default "Error Text"<br>
--  - `callback`: Callback function to run after the user closes the error prompt. Runs no matter how it is closed, and takes no arguments.<br>
--<br>
-- All arguments are optional. The final arg to the function will be used as the callback.<br>
---@param errorMessage string
---@param callback fun()
function interface.beginThrowError(errorMessage, callback)
end
-- Opens an error dialog box, and runs a callback after the user closes it.<br>
--  - `errorMessage`: Body message for the error prompt, can be multiple lines. Default "Error Text"<br>
--  - `callback`: Callback function to run after the user closes the error prompt. Runs no matter how it is closed, and takes no arguments.<br>
--<br>
-- All arguments are optional. The final arg to the function will be used as the callback.<br>
---@param callback fun()
function interface.beginThrowError(callback)
end

--```
-- interface.activeMenu(menuSection)
--```
--Gets or sets the active menu.<br>
--  - `menuSection`: The menusection. See the reference of menusection constants in the [elements api](https://powdertoy.co.uk/Wiki/W/Lua_API:Elements.html#Menu_sections).
---@param menuSection MenuSection
function interface.activeMenu(menuSection)
end
--```
-- menuSection = interface.activeMenu()
--```
--Gets or sets the active menu.<br>
--  - `menuSection`: The menusection. See the reference of menusection constants in the [elements api](https://powdertoy.co.uk/Wiki/W/Lua_API:Elements.html#Menu_sections).
---@return MenuSection | integer
function interface.activeMenu()
end


--```
--interface.activeTool(toolIndex, identifier)
--```
--Gets or sets an active element selection.<br>
--  - `toolIndex`: The tool index. Should be between 0 and `interface.NUM_TOOLINDICES`. The indices correspond to:<br>
--     - `0`: Left click<br>
--     - `1`: Right click<br>
--     - `2`: Middle click<br>
--     - `3`: "Replace Mode" element<br>
--  - `identifier`. The tool identifier. This is a string that uniquely identifies a tool, for example `"DEFAULT_PT_BGLA"` or `"DEFAULT_TOOL_HEAT"`.
---@param toolIndex 0|1|2|3
---@param identifier string
function interface.activeTool(toolIndex, identifier)
end
--```
--identifier = interface.activeTool(toolIndex)
--```
--Gets or sets an active element selection.<br>
--  - `toolIndex`: The tool index. Should be between 0 and `interface.NUM_TOOLINDICES`. The indices correspond to:<br>
--     - `0`: Left click<br>
--     - `1`: Right click<br>
--     - `2`: Middle click<br>
--     - `3`: "Replace Mode" element<br>
--  - `identifier`. The tool identifier. This is a string that uniquely identifies a tool, for example `"DEFAULT_PT_BGLA"` or `"DEFAULT_TOOL_HEAT"`.
---@param toolIndex 0|1|2|3
---@return string
function interface.activeTool(toolIndex)
end


--```
--interface.brushID(brushIndex)
--```
--Gets or set the brush index.<br>
--  - `brushIndex`: The index of the brush to set. Should be between 0 and `sim.NUM_BRUSHES`. For default brushes, the following constants can be used:<br>
--     - `sim.BRUSH_CIRCLE`: Circle brush<br>
--     - `sim.BRUSH_SQUARE`: Square brush<br>
--     - `sim.BRUSH_TRIANGLE`: Triangle brush<br>
--     - `sim.NUM_DEFAULTBRUSHES`: Number of default brushes, excluding custom brushes
---@param brushIndex Brush
function interface.brushID(brushIndex)
end
--```
--brushIndex = interface.brushID()
--```
--Gets or set the brush index.<br>
--  - `brushIndex`: The index of the brush to set. Should be between 0 and `sim.NUM_BRUSHES`. For default brushes, the following constants can be used:<br>
--     - `sim.BRUSH_CIRCLE`: Circle brush<br>
--     - `sim.BRUSH_SQUARE`: Square brush<br>
--     - `sim.BRUSH_TRIANGLE`: Triangle brush<br>
--     - `sim.NUM_DEFAULTBRUSHES`: Number of default brushes, excluding custom brushes
---@return number|Brush
function interface.brushID()
end

--```
--interface.brushRadius(w, h)
--w, h = interface.brushRadius()
--```
--Gets or sets the radius of the brush<br>
--  - `w`: Brush width<br>
--  - `h`: Brush height
---@param w integer
---@param h integer
function interface.brushRadius(w, h)
end
--```
--w, h = interface.brushRadius()
--```
--Gets or sets the radius of the brush<br>
--  - `w`: Brush width<br>
--  - `h`: Brush height
---@return integer w, integer h
function interface.brushRadius()
end

--```
--interface.console(shown)
--```
--Control or check whether the console is open<br>
--  - `shown`: boolean true/false on whether or not the console is shown.<br>
--If you set it to false while in the console, it will close. Scripts can also use it to open the console. This action is non-blocking, so script execution will continue. But as soon as control is returned to the engine, further Lua callbacks will stop (because no event handlers run while the console is open).
---@param shown boolean
function interface.console(shown)
end
--```
--shown = interface.console()
--```
--Control or check whether the console is open<br>
--  - `shown`: boolean true/false on whether or not the console is shown.<br>
--If you set it to false while in the console, it will close. Scripts can also use it to open the console. This action is non-blocking, so script execution will continue. But as soon as control is returned to the engine, further Lua callbacks will stop (because no event handlers run while the console is open).
---@return boolean
function interface.console()
end

--```
--interface.menuEnabled(menuSection, enabled)
--```
--Controls whether menusections are enabled (shown) in the UI.<br>
--  - `menuSection`: The menusection. See the reference of menusection constants in the [elements api](https://powdertoy.co.uk/Wiki/W/Lua_API:Elements.html#Menu_sections).<br>
--  - `enabled`: boolean true/false describing if the menu section is enabled.<br>
--If using an invalid menusection, an Invalid Menu error is raised.
---@param menuSection MenuSection
---@param enabled boolean
function interface.menuEnabled(menuSection, enabled)
end
--```
--enabled = interface.menuEnabled(menuSection)
--```
--Controls whether menusections are enabled (shown) in the UI.<br>
--  - `menuSection`: The menusection. See the reference of menusection constants in the [elements api](https://powdertoy.co.uk/Wiki/W/Lua_API:Elements.html#Menu_sections).<br>
--  - `enabled`: boolean true/false describing if the menu section is enabled.<br>
--If using an invalid menusection, an Invalid Menu error is raised.
---@param menuSection MenuSection
---@return boolean
function interface.menuEnabled(menuSection)
end

--```
--numMenus = interface.numMenus()
--```
--Returns the number of menus<br>
--  - `numMenus`: The number of enabled menus.<br>
--Menus that aren't enabled don't count towards this limit.
---@return integer
function interface.numMenus()
end

--```
--interface.perfectCircleBrush(flag)
--```
--Gets / Sets the "Perfect Circle" option<br>
--  - `flag`: boolean true / false on whether the setting is enabled or not
---@param flag boolean
function interface.perfectCircleBrush(flag)
end
--```
--flag = interface.perfectCircleBrush()
--```
--Gets / Sets the "Perfect Circle" option<br>
--  - `flag`: boolean true / false on whether the setting is enabled or not
---@return boolean
function interface.perfectCircleBrush()
end

--```
--mouseX, mouseY = interface.mousePosition()
--```
--Returns the current mouse position<br>
--  - `mouseX`: mouse x position<br>
--  - `mouseY`: mouse y position<br>
--This is the position of the mouse in the full interface, so it ignores zoom window and can be outside of sim bounds. To convert into sim coords and adjust for zoom window, see [sim.adjustCoords](https://powdertoy.co.uk/Wiki/W/Lua_API:Simulation.html#simulation.adjustCoords).
---@return integer mouseX, integer mouseY
function interface.mousePosition()
end

--Changes a few special properties as to what size the game renders at.<br>
--Scale is a multiplier by which every pixel shall get multiplied at, currently it can either be 1 (612x384) or 2 (1224x768).<br>
--Full screen is a toggle (0 or 1) that enables "kiosk mode", which basically scales the game up to fill the screen and makes the rest of the edge black.<br>
---@param scale integer  
---@param fullscreen boolean  
function interface.windowSize(scale, fullscreen)
end

ui = interface

-- Tbh no idea what those are, found in https://github.com/The-Powder-Toy/The-Powder-Toy/blob/master/src/lua/luascripts/compat.lua

--### **REPLACED BY `ui.MOUSEUP_BLUR`**
---@deprecated
interface.MOUSE_UP_BLUR = nil

interface.MOUSEUP_BLUR = nil

--### **REPLACED BY `ui.MOUSEUP_DRAWEND`**
---@deprecated
interface.MOUSE_UP_DRAW_END = nil

interface.MOUSEUP_DRAWEND  = nil

--### **REPLACED BY `ui.MOUSEUP_NORMAL`**
---@deprecated
interface.MOUSE_UP_NORMAL = nil

interface.MOUSEUP_NORMAL = nil
