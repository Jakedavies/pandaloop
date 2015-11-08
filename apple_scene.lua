local physics = require("physics")
local composer = require( "composer" )
local scene = composer.newScene()
local widget = require( "widget" )
local json = require( "json" )
local input = ''
local backgroundLayers = {}
local textBox
local wordBank = {
  'for(',
  'int',
  'i = %int%;',
  'int i = 0;',
  '){',
  'stopApplesFromFalling();',
  '};'
}
local correctWordOrder = {
  'for(',
  'int',
  'i = %int%;',
  'int i = 0;',
  '){',
  'stopApplesFromFalling();',
  '};'
}

local sentenceManager = require('sentence_manager')
sentenceManager.init(correctWordOrder)

function scene:create(event)
    --
    -- self in this case is "scene", the scene object for this level.
    -- Make a local copy of the scene's "view group" and call it "sceneGroup".
    -- This is where you must insert everything (display.* objects only) that you want
    -- Composer to manage for you.
    local sceneGroup = self.view

    local b = display.newImage("assets/sprites/country-platform-files/country-platform-files/layers/country-platform-back.png", display.contentHeight, display.contentWidth)
    b.x = display.contentCenterX
    b.y = display.contentCenterY
    b.width = display.contentWidth
    b.height = display.contentHeight

    physics.start()
    sceneGroup:insert(b)
end

--
-- This gets called twice, once before the scene is moved on screen and again once
-- afterwards as a result of calling composer.gotoScene()
--
function scene:show( event )
    local sceneGroup = self.view

    player = display.newImage('assets/sprites/knight.png')
    player.height = 90
    player.width = 50
    player.xScale = -1
    player.y = display.contentHeight - player.height/2
    player.x = display.contentCenterX
    physics.addBody( player, "static", { density = 1.0, friction = 0.3, bounce = 0.2 } )
    -- spawns words at a set interval
    local function timerListener(event)
      createFallingWord()
      timer.performWithDelay(1000, timerListener)
    end
    timer.performWithDelay(1000, timerListener)
end
--
-- This function gets called everytime you call composer.gotoScene() from this module.
-- It will get called twice, once before we transition the scene off screen and once again
-- after the scene is off screen.
function scene:hide( event )
    local sceneGroup = self.view
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
-- Custom functions
---------------------------------------------------------------------------------
function wordCollisionListener(self, event)
  if(event.phase == "began") then
    -- remove the collision listener from the object after something has collided
    self.collision = nil
    print(self.word .. 'was caught')
    if(sentenceManager.tryAddWord(self.word)) then
      -- update the senctence displayed
      if(sentenceManager.finished) then
        -- end the game here
        -- the user has won
      end
    else
      -- subtract a life
    end
  end
end

function createFallingWord()
  local randomWord = wordBank[math.random(1, #wordBank)]
  local newFallingWord = display.newRect(display.contentCenterX, 0 , 10, 10)
  local body = physics.addBody(newFallingWord, {density=0.9, friction =0.3, bounce=0.0})
  newFallingWord.word = randomWord

  newFallingWord.collision = wordCollisionListener
  newFallingWord:addEventListener("collision", newFallingWord)
end

---------------------------------------------------------------------------------
-- END OF YOUR IMPLEMENTATION
---------------------------------------------------------------------------------
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
return scene
