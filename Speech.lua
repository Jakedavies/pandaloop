local widget = require( "widget" )


--Question Object
Speech = {}
Speech.__index = Speech
 
 --Instantiate to empty we will manually set everything as we need it
 function Speech:new()
 	  local speech = display.newImage('assets/sprites/comic-2.png')
      speech.x = display.contentCenterX
      speech.xScale = -1
      speech.y =  display.contentCenterY
      speech.height = 100
      speech.width = 290
      speechx= speech.x

    local message =  display.newText("NO MESSAGE SET", display.contentCenterX + 5, display.contentCenterY + 115,  native.systemFontBold, 10)
    message:setFillColor(0, 0, 0 )

    local o = {_speech = speech, _message = message}
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
end
function Speech:setY(y)
	self._speech.y = y
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