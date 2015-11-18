background = display.newImage("assets/sprites/country-platform-files/country-platform-files/layers/country-platform-tiles-example.png", display.contentHeight, display.contentWidth)
background.x = display.contentCenterX
background.y = display.contentCenterY + 150

backgroundLayer2 = display.newImage("assets/sprites/country-platform-files/country-platform-files/layers/country-platform-forest.png", display.contentHeight, display.contentWidth)
backgroundLayer2.x = display.contentCenterX
backgroundLayer2.y = display.contentCenterY + 140
backgroundLayer2.width = display.contentWidth
backgroundLayer2.height = display.contentHeight / 3

backgroundLayer3 = display.newImage("assets/sprites/country-platform-files/country-platform-files/layers/country-platform-back.png", display.contentHeight, display.contentWidth)
backgroundLayer3.x = display.contentCenterX
backgroundLayer3.y = display.contentCenterY
backgroundLayer3.width = display.contentWidth
backgroundLayer3.height = display.contentHeight
    
Backgrounds = {}
Backgrounds.__index = Backgrounds
 
--Lets 
 function Backgrounds:new()
    local o = {_layer1 = background, _layer2 = backgroundLayer2, _layer3 = backgroundLayer3}
    setmetatable(o, self)
    return o
  end
  
  
--Access the Layers
function Backgrounds:getLayer1()
    return self._layer1
end
function Backgrounds:getLayer2()
    return self._layer2
end
function Backgrounds:getLayer3()
    return self._layer3
end

   

