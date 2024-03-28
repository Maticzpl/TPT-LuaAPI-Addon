---@meta
---@diagnostic disable:lowercase-global
---@diagnostic disable:duplicate-set-field

-- Various methods that allow lua to draw on the simulation screen. 
graphics = {}

--```
--number, number graphics.textSize(string text)
--```
--Returns the width and height of the specified text.<br>
---@param text string  
---@return integer, integer 
function graphics.textSize(text)
end

--```
--graphics.drawText(number x, number y, string text, [number r, number g, number b, [number a]])
--```
--Draws the specified text at (x,y). Providing the color is optional, if not provided defaults to white.<br>
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
--Draws a line from (x1,y1) to (x2,y2). Providing the color is optional, if not provided defaults to white.<br>
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
--Draws a hollow rectangle at (x,y) with the specified width and height. Providing the color is optional, if not provided defaults to white.<br>
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
--Draws a filled rectangle at (x,y) with the specified width and height. Providing the color is optional, if not provided defaults to white.<br>
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
--Draws a hollow circle at (x,y) with radius of (radiusW,radiusH). Providing the color is optional, if not provided defaults to white.<br>
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
--Draws a filled circle at (x,y) with radius of (radiusW,radiusH). Providing the color is optional, if not provided defaults to white.<br>
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
--graphics.drawPixel(number x, number y, [number r, number g, number b, [number a]])
--```
-- Draws a pixel at (x, y). Providing the color is optional, if not provided defaults to white. 
---@param x integer
---@param y integer
function graphics.drawPixel(x, y)
end
--```
--graphics.drawPixel(number x, number y, [number r, number g, number b, [number a]])
--```
-- Draws a pixel at (x, y). Providing the color is optional, if not provided defaults to white. 
---@param x integer
---@param y integer
---@param r integer
---@param g integer
---@param b integer
---@param a integer?
function graphics.drawPixel(x, y, r, g, b, a)
end

--```
--graphics.getColors(number color)
--```
--Converts color from hex. Return number r,g,b,a.<br>
---@param color integer  
---@return integer, integer, integer, integer
function graphics.getColors(color)
end


--```
--graphics.getHexColor( [number r], [number g], [number b], [number a])
--```
--Converts color to hex.<br>
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
--Sets the clip rect used while drawing graphics to the screen. Graphics drawn outside the given rectangle will be clipped out. The default clip rect is the entire screen, and clip rects will be reset to this after every frame.<br>
--Returns the old clip rect (x, y, w, h).
---@param x integer?  
---@param y integer?  
---@param w integer?  
---@param h integer?  
---@return integer x, integer y, integer w, integer h 
function graphics.setClipRect(x, y, w, h)
end

gfx = graphics

graphics.WIDTH = 629
graphics.HEIGHT = 424
