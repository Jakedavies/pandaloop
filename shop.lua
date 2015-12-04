local composer = require( "composer" )
local scene = composer.newScene()
local widget = require( "widget" )
local json = require( "json" )
local files = require("files")
local logging = require("logging")
local characters = require("characters")
local myCharacters
require('physics')
physics.start()
require("mainCharacter")
require("CreditWidget")


require("backgrounds")
local background = Backgrounds:new()


function scene:create(event)
  local sceneGroup = self.view
  system.setTapDelay( delayTime )
end






local allowed = true

function buyAsset(event)
    if(allowed) then
      if(not contains(myCharacters, event.target.assetPath)) then
        print('buying asset');
        if(logging.getCredits() >= 100) then
          logging.addCharacter(event.target.assetPath)
          logging.removeCredits(100)
          composer.gotoScene('shop')
        else
          native.showAlert('Not enough monies','You dont have enough credits for that!')
        end
        
      else
        print('switching character')
        logging.changeActive(event.target.assetPath)
        composer.gotoScene('shop')
      end
      allowed  = false
      timer.performWithDelay( 200, function()
      allowed = true
       end )
    end
end
function scene:show( event )
    local sceneGroup = self.view

   
    
        myCharacters = logging.getCharacters()
    

    if event.phase == "did" then  -- Create the widget

    else -- event.phase == "will"

      -- I have no idea why this doesn't update when we go back to the scene but the buttons do? 
      local widget = CreditWidget:new(logging.getCredits())
      widget:play()
      local credits = logging.getCredits()
      print('credits')
      print(credits)
      widget:getNumber().text = credits
      sceneGroup:insert(widget:getAsset())
      sceneGroup:insert(widget:getNumber())
      print(widget:getNumber().text)

      local count = 1
      local buttons = {}
      for key,val in pairs(characters) do 
        local m1 = MainCharacter:new();
        m1:setAsset(val)
        local xpos = (count * ((display.contentWidth/#characters) ))- (display.contentWidth/(#characters * 2))
        m1:setX(xpos)
        m1:setY(display.contentCenterY + 70)
        m1:shrink(0.06)
        sceneGroup:insert(m1:getAsset())
  
        --We will leave this section alone, just because it's only bad once ;)
        buttons[#buttons+1] = Button:new()
        buttons[#buttons]:setX(xpos)
        buttons[#buttons]:setY(display.contentCenterY + 130)
        buttons[#buttons]:setLabel("BUY")
        if(contains(myCharacters, val)) then
          if(val == logging.getActive()) then
           buttons[#buttons]:setLabel("ACTIVE")
          else
           buttons[#buttons]:setLabel("OWNED")
          end
        end
        buttons[#buttons]:shrinkX()
        buttons[#buttons]:getAssetForeground().assetPath = val
        sceneGroup:insert(buttons[#buttons]:getAssetBackground())
        sceneGroup:insert(buttons[#buttons]:getAssetForeground())
        buttons[#buttons]:getAssetForeground():addEventListener("touch", buyAsset)
        count = count +1
      end
      
      for i = 1,20 do 
        
        x = math.random(0, display.contentWidth)
        
        local dollar = display.newImage('assets/DOLLAR_DOLLAR_BILL_YO.png')
        dollar.x = x
        dollar.y = display.contentCenterY - display.contentCenterY*2
        sceneGroup:insert(dollar)
        physics.addBody(dollar)
   
      end

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
function contains(items, lookup)
  for _,v in pairs(items) do
    if v == lookup then
      return true
    end
  end
  return false
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
