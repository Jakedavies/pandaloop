local widget = require( "widget" )


--Question Object
Button = {}
Button.__index = Button

 --Instantiate to empty we will manually set everything as we need it
 function Button:new()
 	local buttonBackground = display.newImage("assets/sprites/touch.png")
	buttonBackground.x = display.contentCenterX
	buttonBackground.y = display.contentCenterY

	 local button = widget.newButton()
	 button:setLabel("HOLDER")
	 button:setEnabled(true)
	 button.x = display.contentCenterX
	 button.y = display.contentCenterY
    local o = {_assetBackground = buttonBackground, _assetForeground = button, _index, _label}
    setmetatable(o, self)
    return o
end

function Button:setWidth(width)
    self._assetBackground.width = width
end

function Button:setIndex(index)
    self._index=index
end
function Button:getIndex()
    return self._index
end
function Button:shrinkX()
  self._assetBackground.width = self._assetBackground.width/2
  self._assetForeground.width = self._assetForeground.width/2
end

function Button:setAssetBackground(asseturl)
	self._assetBackground = display.newImage(asseturl)
end
function Button:getAssetBackground()
	return self._assetBackground
end
function Button:getAssetForeground()
	self._assetForeground.button = self
	return self._assetForeground
end

function Button:getX()
	return self._asset.x
end
function Button:setX(x)
	 self._assetBackground.x = x
	 self._assetForeground.x = x
end

function Button:getY()
	return self._assetBackground.x
end
function Button:setY(y)
	 self._assetBackground.y = y
	 self._assetForeground.y = y
end
function Button:setLabel(label)
	self._assetForeground: setLabel(label)
	self._label = label
end
function Button:getLabel()
	return self._label
end
