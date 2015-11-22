local composer = require( "composer" )
local scene = composer.newScene()
local widget = require( "widget" )
local json = require( "json" )
local files = require("files")
local logging = require("logging")
require("mainCharacter")
require("CreditWidget")

function scene:create(event)
  local sceneGroup = self.view
end


function scene:show( event )
    local sceneGroup = self.view




    if event.phase == "did" then  -- Create the widget

    else -- event.phase == "will"

      widget = CreditWidget:new(logging.getCredits())
      widget:play()
      sceneGroup:insert(widget:getAsset())
      sceneGroup:insert(widget:getNumber())


      local m1 = MainCharacter:new();
      m1:setAsset('assets/sprites/characters/green_unicorn.png')
      m1:setX(display.contentCenterX - 90)
      m1:setY(display.contentCenterY + 70)
      m1:shrink(0.06)
      sceneGroup:insert(m1:getAsset())

      --We will leave this section alone, just because it's only bad once ;)
      local btn1 = Button:new()
      btn1:setX(display.contentCenterX - 90)
      btn1:setY(display.contentCenterY + 130)
      btn1:setLabel("BUY")
      btn1:getAssetForeground():addEventListener("tap", loadNext)
      btn1:shrinkX()
      sceneGroup:insert(btn1:getAssetBackground())
      sceneGroup:insert(btn1:getAssetForeground())

      local m2 = MainCharacter:new();
      m2:setAsset('assets/sprites/characters/king.png')
      m2:setX(display.contentCenterX)
      m2:setY(display.contentCenterY + 70)
      m2:shrink(0.06)
      sceneGroup:insert(m2:getAsset())


--We will leave this section alone, just because it's only bad once ;)
      local btn2 = Button:new()
      btn2:setX(display.contentCenterX)
      btn2:setY(display.contentCenterY + 130)
      btn2:setLabel("BUY")
      btn2:getAssetForeground():addEventListener("tap", loadNext)
      btn2:shrinkX()
      sceneGroup:insert(btn2:getAssetBackground())
      sceneGroup:insert(btn2:getAssetForeground())

      local m3 = MainCharacter:new();
      m3:setAsset('assets/sprites/characters/princess.png')
      m3:setX(display.contentCenterX + 90)
      m3:setY(display.contentCenterY + 70)
      m3:shrink(0.06)
      sceneGroup:insert(m3:getAsset())

--We will leave this section alone, just because it's only bad once ;)
      local btn3 = Button:new()
      btn3:setX(display.contentCenterX + 90)
      btn3:setY(display.contentCenterY + 130)
      btn3:setLabel("BUY")
      btn3:shrinkX()
      btn3:getAssetForeground():addEventListener("tap", loadNext)
      sceneGroup:insert(btn3:getAssetBackground())
      sceneGroup:insert(btn3:getAssetForeground())
    end
end
--
-- This function gets called everytime you call composer.gotoScene() from this module.
-- It will get called twice, once before we transition the scene off screen and once again
-- after the scene is off screen.
function scene:hide( event )
    if(event.phase == "did") then
    else
      local sceneGroup = self.view
    end
end

--
-- When you call composer.removeScene() from another module, composer will go through and
-- remove anything created with display.* and inserted into the scene's view group for you. In
-- many cases that's sufficent to remove your scene.
--
-- But there may be somethings you loaded, like audio in scene:create() that won't be disposed for
-- you. This is where you dispose of those things.
-- In most cases there won't be much to do here.
function scene:destroy( event )
    local sceneGroup = self.view
end

---------------------------------------------------------------------------------
-- END OF YOUR IMPLEMENTATION
---------------------------------------------------------------------------------
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
return scene
