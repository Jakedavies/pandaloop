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
function buyPowerUp(event)
    if(allowed) then
      print('buying asset');
      if(logging.getCredits() >= 100) then
        if(event.target.name == "slow") then
          logging.buySlow()
        end
        if(event.target.name == "contrast") then
          logging.buyContrast()
        end
        if(event.target.name == "lives") then
          logging.buyLives()
        end
        composer.gotoScene('shop')
      else
        native.showAlert('Not enough monies','You dont have enough credits for that!')
      end 
      allowed  = false
      timer.performWithDelay( 200, function()
      allowed = true
       end )
    end
end
function backToSplash(event)
    if(allowed) then
      composer.gotoScene('splash')
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
        m1:setY(display.contentCenterY + 90)
        m1:shrink(0.06)
        sceneGroup:insert(m1:getAsset())
  
        --We will leave this section alone, just because it's only bad once ;)
        buttons[#buttons+1] = Button:new()
        buttons[#buttons]:setX(xpos)
        buttons[#buttons]:setY(display.contentCenterY + 150)
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
      
      local m1 = MainCharacter:new();
      m1:setAsset("assets/sprites/powerups/constrast.png")
      local xpos = display.contentWidth/4
      m1:setX(xpos)
      m1:setY(display.contentCenterY - 60)
      m1:shrink(0.65)
      sceneGroup:insert(m1:getAsset())

      --We will leave this section alone, just because it's only bad once ;)
      p1 = Button:new()
      p1:setX(xpos)
      p1:setY(display.contentCenterY + 0)
      p1:shrinkX()
      p1:getAssetForeground().name = 'contrast'
      sceneGroup:insert(p1:getAssetBackground())
      sceneGroup:insert(p1:getAssetForeground())
      p1:setLabel("BUY")
      if(logging.getContrast()) then
      p1:setLabel("OWNED")
      else
      p1:getAssetForeground():addEventListener("touch", buyPowerUp)
      end
      
      local m2 = MainCharacter:new();
      m2:setAsset("assets/sprites/powerups/lives.png")
      local xpos = display.contentWidth/2
      m2:setX(xpos)
      m2:setY(display.contentCenterY - 60)
      m2:shrink(0.5)
      sceneGroup:insert(m2:getAsset())

      --We will leave this section alone, just because it's only bad once ;)
      p2 = Button:new()
      p2:setX(xpos)
      p2:setY(display.contentCenterY + 0)
      p2:setLabel("BUY")
      p2:shrinkX()
      p2:getAssetForeground().name = 'lives'
      sceneGroup:insert(p2:getAssetBackground())
      sceneGroup:insert(p2:getAssetForeground())
      if(logging.getLives()) then
        p2:setLabel("OWNED")
      else
        p2:getAssetForeground():addEventListener("touch", buyPowerUp)
      end
      
      
      local m3 = MainCharacter:new();
      m3:setAsset("assets/sprites/powerups/slow.png")
      local xpos = 3* display.contentWidth/4
      m3:setX(xpos)
      m3:setY(display.contentCenterY - 60)
      m3:shrink(0.5)
      sceneGroup:insert(m3:getAsset())

      --We will leave this section alone, just because it's only bad once ;)
      p3 = Button:new()
      p3:setX(xpos)
      p3:setY(display.contentCenterY + 0)
      p3:setLabel("BUY")
      p3:shrinkX()
      p3:getAssetForeground().name = 'slow'
      sceneGroup:insert(p3:getAssetBackground())
      sceneGroup:insert(p3:getAssetForeground())
      if(logging.getSlow()) then
      p3:setLabel("OWNED")
      else
      p3:getAssetForeground():addEventListener("touch", buyPowerUp)
      end
        
      for i = 1,20 do 
        
        x = math.random(0, display.contentWidth)
        
        local dollar = display.newImage('assets/DOLLAR_DOLLAR_BILL_YO.png')
        dollar.x = x
        dollar.y = display.contentCenterY - display.contentCenterY*2
        dollar:toBack()
        sceneGroup:insert(dollar)
        physics.addBody(dollar)
   
      end
       --We will leave this section alone, just because it's only bad once ;)
      back = Button:new()
      back:setX(xpos+ 20)
      back:setY(display.contentCenterY + 250)
      back:setLabel("BACK")
      sceneGroup:insert(back:getAssetBackground())
      sceneGroup:insert(back:getAssetForeground())
      back:getAssetForeground():addEventListener("touch", backToSplash)

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
