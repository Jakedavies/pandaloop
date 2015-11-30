local physics = require("physics")
local composer = require( "composer" )
local scene = composer.newScene()
local widget = require( "widget" )
local json = require( "json" )
local input = ''
local backgroundLayers = {}
local textBox
local levels = require("levels")
local lives = 3
local lives_display
local sentenceManager = require('sentence_manager')
local wordBank
function scene:create(event)
    --
    -- self in this case is "scene", the scene object for this level.
    -- Make a local copy of the scene's "view group" and call it "sceneGroup".
    -- This is where you must insert everything (display.* objects only) that you want
    -- Composer to manage for you.

    local correctWordOrder
    if(event.params and event.params.level) then
      correctWordOrder = levels[level]["correctWordOrder"]
      wordBank = levels[level]["wordBank"]
    else
      correctWordOrder = levels[1]['correctWordOrder']
      wordBank = levels[1]["wordBank"]
    end
    sentenceManager.init(correctWordOrder)

    local sceneGroup = self.view

    local b = display.newImage("assets/sprites/country-platform-files/country-platform-files/layers/country-platform-back.png", display.contentHeight, display.contentWidth)
    b.x = display.contentCenterX
    b.y = display.contentCenterY
    b.width = display.contentWidth
    b.height = display.contentHeight


    function b:touch(event)
      if event.phase == "began" then
        print('update character position')
        transition.moveTo(player, {x=event.x})
      end
    end
    b:addEventListener("touch", b)

    physics.start()
    sceneGroup:insert(b)
end

--
-- This gets called twice, once before the scene is moved on screen and again once
-- afterwards as a result of calling composer.gotoScene()
--
function timerListener(event)
  createFallingWord()
  timer.performWithDelay(wordSpawnDelay, timerListener)
end
function scene:show( event )
    local sceneGroup = self.view

    if(event.phase == "will") then
    player = display.newImage('assets/sprites/knight.png')
    player.height = 90
    player.width = 50
    player.xScale = -1
    player.y = display.contentHeight - player.height/2
    player.x = display.contentCenterX


    lives_display = display.newText(lives, display.contentWidth - 10, 10, native.systemFont, 16)
    sceneGroup:insert(lives_display)

    wordSpawnDelay = 1000
    physics.addBody( player, "static", { density = 1.0, friction = 0.3, bounce = 0.2 } )
    -- spawns words at a set interval

    timer.performWithDelay(wordSpawnDelay, timerListener)
    end
end

--
-- This function gets called everytime you call composer.gotoScene() from this module.
-- It will get called twice, once before we transition the scene off screen and once again
-- after the scene is off screen.
function scene:hide( event )
    local sceneGroup = self.view
end
function updateLives()
  lives_display.text = lives
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
      if(sentenceManager.finished()) then
        -- end the game here
        -- the user has won
      end
    else
      -- subtract a life
      lives = lives -1
      updateLives();
    end
    self:removeSelf()
  end
end

function createFallingWord()
  local randomWord = wordBank[math.random(1, #wordBank)]
  local width = display.contentWidth
  local randomx = math.random(1, width)
  local newFallingWord = display.newText( randomWord, randomx, 0, #randomWord *10,16)
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
