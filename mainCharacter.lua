
--Hacky OOP because lua is silly.

      knight = display.newImage('assets/sprites/knight.png')
      knight.x = display.contentCenterX -500
      knight.y =  display.contentCenterY + 200
      knight.height = 90
      knight.width = 50
      knight.xScale = -1
      kx = knight.x

--Question Object
MainCharacter = {}
MainCharacter.__index = MainCharacter
 
 --Instantiate to empty we will manually set everything as we need it
 function MainCharacter:new()
    local o = {_asset = knight}
    setmetatable(o, self)
    return o
end

function MainCharacter:setAsset(asseturl)
    self._asset = display.newImage(asseturl)
end
function MainCharacter:getAsset()
    return self._asset
end

function MainCharacter:setY(y)
    self._asset.y = y
end
function MainCharacter:getY()
    return self._asset.y
end

function MainCharacter:setX(x)
    self._asset.x = x
end
function MainCharacter:getX()
    return self._asset.x
end

function MainCharacter:setWidthHeight(width, height)
    self._asset.width = width
    self._asset.height = height
end

function MainCharacter:invert()
    self._asset.xScale = -1
end
function MainCharacter:toFront()
  self._asset:toFront();
end

