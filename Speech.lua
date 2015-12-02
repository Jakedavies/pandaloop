local widget = require( "widget" )

--Question Object
Speech = {}
Speech.__index = Speech
 

 --If it is a tutorial then we use a speech buble otherwise just a background image
 function Speech:new(tutorial)
 
 	speechwidth = 200
 	local speech 
 	  if not tutorial then 
 	  	  speech = display.newImage('assets/sprites/touch.png')
		  speechwidth = 300
  	  else
		  speech = display.newImage('assets/sprites/comic-2.png')
	  end

      speech.x = display.contentCenterX
      speech.xScale = -1
      speech.y =  display.contentCenterY
      speech.height = 100
      speech.width = 290
      speechx= speech.x
	  speech.anchorX = 0.5

      --Tutorials have more text so we need a smaller font.
      local fontSize = 14
      if tutorial == true then
      	fontSize = 12
  	  end
		
	local options = {
	   text = "None",
	   x = display.contentCenterX,
	   y = display.contentCenterY,
	   fontSize = fontSize,
	   width = speechwidth,
	   height = 0,
	   align = "center"
	}

   local message =  display.newText(options)
    message:setFillColor( 0, 0, 0)

    local o = {_speech = speech, _message = message, _tutorial = tutorial}
    setmetatable(o, self)
    return o
end

function Speech:getAssetSpeech()
	return self._speech
end
function Speech:getAssetMessage()
	return self._message
end
function Speech:getAssetsAll()
	return {self._speech, self._message}
end

function Speech:setX(x)
	self._speech.x = x
	self._message.x = x 
end
function Speech:setY(y)
	offset = -15
	
	if not self._tutorial then
		offset = 1
	end

	self._speech.y = y 
	self._message.y = y + offset
end
function Speech:getX()
	return self._speech.x
end
function Speech:getY()
	return self._speech.y
end

function Speech:setHeight(height)
	self._speech.height = height
end
function Speech:getHeight()
	return self.speech._height
end
function Speech:setWidth(width)
	self._speech.width = width 
end
function Speech:getWidth()
	return self._speech.width
end

function Speech:setMessage(message)
	self._message.text = message
end
function Speech:setMessageX(x)
	self._message.x = x 
end
function Speech:setMessageY(y)
	self._message.y = y
end
