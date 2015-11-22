--Hacky OOP because lua is silly.

--Question Object
CreditWidget = {}
CreditWidget.__index = CreditWidget
 --Instantiate to empty we will manually set everything as we need it
 function CreditWidget:new(credits)
     local sequenceData =
     {
         name="smoking",
         start=1,
         count=6,
         time=300,
         loopCount = 0,   -- Optional ; default is 0 (loop indefinitely)
     }
     local sheetData = { width=40, height=40, numFrames=6, sheetContentWidth=242, sheetContentHeight=42 }
     local imageSheet = graphics.newImageSheet( "assets/sprites/coin_sheet.png", sheetData )
     local smoke = display.newSprite(imageSheet, sequenceData)
     smoke.width = 10
     smoke.height = 10
     smoke.xScale = 0.5
     smoke.yScale = 0.5
     smoke.x = display.contentCenterX + 120
     smoke.y = 25

     local number = display.newText(credits, display.contentCenterX + 90, 25)
    local o = {_asset = smoke, _asset2 = number }
    setmetatable(o, self)
    return o
end
function CreditWidget:setAsset(asseturl)
    local smoke = display.newSprite( imageSheet, sequenceData )
    self._asset = smoke
end
function CreditWidget:getAsset()
    return self._asset
end
function CreditWidget:getNumber()
  return self._asset2
end
function CreditWidget:play()
  self._asset:play()
end
function CreditWidget:setY(y)
    self._asset.y = y
end
function CreditWidget:getY()
    return self._asset.y
end

function CreditWidget:setX(x)
    self._asset.x = x
end
function CreditWidget:getX()
    return self._asset.x
end

function CreditWidget:setWidthHeight(width, height)
    self._asset.width = width
    self._asset.height = height
end

function CreditWidget:invert()
    self._asset.xScale = -1
end
function CreditWidget:toFront()
  self._asset:toFront();
end
