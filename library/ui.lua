---@meta
---@diagnostic disable:lowercase-global
---@diagnostic disable:duplicate-set-field

interface = {}

--Component
--#region<br>

    ---@class Component
    Component = {}

    --Sets the visibility of the component<br>
    ---@param visible boolean  
    function Component:visible(visible)    
    end
    --Returns the visibility of the component<br>
    ---@return boolean 
    function Component:visible()
    end

    --Returns the width and height of the component<br>
    ---@return integer, integer 
    function Component:size()
    end
    --Sets the size of the component to be width by height<br>
    ---@param width integer  
    ---@param height integer  
    function Component:size(width, height)
    end

    --Sets the position of the component to be x, y<br>
    ---@param x integer  
    ---@param y integer  
    function Component:position(x,y)    
    end
    --Returns the x and y coord of the component<br>
    ---@return integer, integer 
    function Component:position()   
    end
--#endregion

--Button
--#region

    --Extends Component, fires "action" when clicked<br>
    ---@class Button : Component
    Button = {}

    --Extends Component, fires "action" when clicked<br>
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
    --Sets the listener for button actions Example:<br>
    --```
    --local newButton = Button:new(10, 10, 100, 17, "Press to change text")
    --newButton:action(function(sender) sender:text("Text changed") end)
    --interface.addComponent(newButton)
    --```
    ---@param actionListener ButtonCallback  
    function Button:action(actionListener)    
    end

    --Returns the button text<br>
    ---@return string
    function Button:text()
    end
    --Sets the text of the button<br>
    ---@param text string  
    function Button:text(text)
    end

    --Returns the enabled state of the button<br>
    ---@return boolean 
    function Button:enabled()
    end
    --Sets the enabled state of the button<br>
    ---@param enabled boolean  
    function Button:enabled(enabled)
    end
--#endregion

--ProgressBar
--#region

    --Extends Component, used to indicate progress for long running tasks<br>
    ---@class ProgressBar : Component
    ProgressBar = {}

    --Extends Component, used to indicate progress for long running tasks<br>
    ---@param x integer  
    ---@param y integer  
    ---@param width integer  
    ---@param height integer  
    ---@param progress integer  
    ---@param status string  
    ---@return ProgressBar
    function ProgressBar:new(x, y, width, height, progress, status)
    end

    --Progress ranges from 0 to 100, but a special case of -1 will change the behaviour of the progress bar to intermediate (constantly scrolling to indicate progress)<br>
    --Returns the progress value<br>
    ---@return integer
    function ProgressBar:progress()
    end
    --Sets the progress value<br>
    ---@param progress integer  
    function ProgressBar:progress(progress)
    end

    --Status is simple a text representation of the current action being performed, for example "Working" or just a percentage<br>
    --Returns the progress bar status<br>
    ---@return string
    function ProgressBar:status()
    end
    --Sets the progress bar status<br>
    ---@param status string  
    function ProgressBar:status(status)
    end
--#endregion

--Slider
--#region

    --Extends Component, fires "onValueChanged" when the value is changed (i.e used by the user)<br>
    ---@class Slider : Component
    Slider = {}

    --Extends Component, fires "onValueChanged" when the value is changed (i.e used by the user)<br>
    ---@param x integer  
    ---@param y integer  
    ---@param width integer  
    ---@param height integer  
    ---@param steps integer?  
    ---@return Slider
    function Slider:new(x, y, width, height, steps)
    end

    ---@alias SliderCallback fun(sender: Slider, value : integer)

    --Sets the listener for slider actions<br>
    ---@param actionListener SliderCallback  
    function Slider:onValueChanged(actionListener)    
    end

    --Returns the value of the slider<br>
    ---@return integer
    function Slider:value()
    end
    --Sets the value of the slider<br>
    ---@param value integer  
    function Slider:value(value)
    end

    --Returns the number of steps the slider has<br>
    ---@return integer
    function Slider:steps()
    end
    --Sets the number of steps for the slider<br>
    ---@param steps integer  
    function Slider:steps(steps)
    end
--#endregion

--Checkbox
--#region

    --Extends Component, fires "action" when the checkbox is checked or unchecked<br>
    ---@class Checkbox : Component
    Checkbox = {}

    --Extends Component, fires "action" when the checkbox is checked or unchecked<br>
    ---@param x integer  
    ---@param y integer  
    ---@param width integer  
    ---@param height integer  
    ---@param text string?  
    ---@return Checkbox
    function Checkbox:new(x, y, width, height, text)
    end

    ---@alias CheckboxCallback fun(sender: Checkbox, checked: boolean)

    --Sets the listener for checkbox actions<br>
    ---@param actionListener CheckboxCallback  
    function Checkbox:action(actionListener)
    end

    --Returns the checkbox text<br>
    ---@return string
    function Checkbox:text()
    end    
    --Sets the text of the checkbox<br>
    ---@param text string  
    function Checkbox:text(text)
    end

    --Returns the checked state of the checkbox<br>
    ---@return boolean
    function Checkbox:checked()
    end
    --Sets the checked state of the checkbox<br>
    ---@param checked boolean  
    function Checkbox:checked(checked)
    end
--#endregion

--Label
--#region

    --Extends Component, is a simple selectable, readonly text field<br>
    ---@class Label : Component
    Label = {}

    --Extends Component, is a simple selectable, readonly text field<br>
    ---@param x integer  
    ---@param y integer  
    ---@param width integer  
    ---@param height integer  
    ---@param text string?  
    ---@return Label
    function Label:new(x, y, width, height, text)
    end

    --Returns the label text<br>
    ---@return string
    function Label:text()
    end
    --Sets the text of the label<br>
    ---@param text string  
    function Label:text(text)
    end
--#endregion

--Textbox
--#region

    --Extends Component, is a text input field, the placeholder text is shown if the component is no focused and contains no text<br>
    ---@class Textbox : Component
    Textbox = {}

    --Extends Component, is a text input field, the placeholder text is shown if the component is no focused and contains no text<br>
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

    --Sets the listener for text changed actions<br>
    ---@param textChangedListener TextboxCallback  
    function Textbox:onTextChanged(textChangedListener)    
    end

    --Returns the text in the field<br>
    ---@return string
    function Textbox:text()
    end
    --Sets the text of the field<br>
    ---@param text string  
    function Textbox:text(text)
    end

    --Returns the readonly status of the field.<br>
    ---@return boolean
    function Textbox:readonly()
    end
    --Sets the readonly status of the field.<br>
    ---@param readonly boolean  
    function Textbox:readonly(readonly)
    end
--#endregion

--Window
--#region

    --A modal form to display components, using -1 for either x or y values will centre the Window on that axis.<br>
    ---@class Window
    Window = {}

    --A modal form to display components, using -1 for either x or y values will centre the Window on that axis.<br>
    ---@param x integer  
    ---@param y integer  
    ---@param width integer  
    ---@param height integer 
    ---@return Window 
    function Window:new(x, y, width, height)
    end

    -- Sets the window position. Both coordinates must be greater or equal to 1
    ---@param x integer
    ---@param y integer
    function Window:position(x,y)            
    end

    -- Gets the window position
    ---@return integer x, integer y
    function Window:position()            
    end

    -- Sets the window size. Both arguments must be greater or equal to 10
    ---@param w integer
    ---@param h integer
    function Window:size(w,h)            
    end

    -- Gets the window size
    ---@return integer w, integer h
    function Window:size()            
    end

    --Add a component to the window (The component must not have already been added to another Window object)
    ---@param newComponent Component  
    function Window:addComponent(newComponent)
    end

    --Remove a component from the window<br>
    ---@param component Component  
    function Window:removeComponent(component)
    end

    -- TODO: descriptions for callbacks below

    -- Triggers every frame that the window is drawn. Allows for using gfx together with ui
    ---@param listener fun()
    function Window:onDraw(listener)            
    end

    ---@param listener fun()
    function Window:onInitialized(listener)            
    end

    ---@param listener fun()
    function Window:onExit(listener)            
    end

    ---@param listener fun(deltaTime :number?)
    function Window:onTick(listener)            
    end

    ---@param listener fun()
    function Window:onFocus(listener)            
    end

    ---@param listener fun()
    function Window:onBlur(listener)            
    end

    ---@param listener fun()
    function Window:onTryExit(listener)            
    end
    
    ---@param listener fun()
    function Window:onTryOkay(listener)            
    end
    
    ---@param listener MouseMoveCallback
    function Window:onMouseMove(listener)            
    end
    
    ---@param listener MouseDownCallback
    function Window:onMouseDown(listener)            
    end

    ---@param listener MouseDownCallback
    function Window:onMouseUp(listener)            
    end

    ---@param listener MouseWheelCallback
    function Window:onMouseWheel(listener)            
    end

    ---@param listener KeyPressCallback
    function Window:onKeyPress(listener)            
    end

    ---@param listener KeyPressCallback
    function Window:onKeyRelease(listener)            
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

ui = interface
