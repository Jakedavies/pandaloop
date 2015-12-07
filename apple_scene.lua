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
local logging = require('logging')
local alertShow = true
suggest = require('levelManager')
local textPreview
<<<<<<< HEAD


||||||| parent of b3ed691 (corona just wasted 6 hours of my lif)
local player


=======
local player
local sceneGroup
local started
<<<<<<< HEAD
<<<<<<< HEAD
composer.recycleOnSceneChange = true
>>>>>>> b3ed691 (corona just wasted 6 hours of my lif)
||||||| parent of b1226dd (idk halp)
composer.recycleOnSceneChange = true
=======
>>>>>>> b1226dd (idk halp)

||||||| parent of 2963bb6 (please dont make me lua ever again)

=======
local constrast
local fallenwords = {}
local paused = true
wordSpawnDelay = 500
>>>>>>> 2963bb6 (please dont make me lua ever again)

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


    timerListener()



    sceneGroup:insert(b)
end

--
-- This gets called twice, once before the scene is moved on screen and again once
-- afterwards as a result of calling composer.gotoScene()
--

function timerListener(event)
  if not paused then
    createFallingWord()
    print('falling')
  end
  timer.performWithDelay(wordSpawnDelay, timerListener)
end
local function pause()
  print("setting physics to 0")
  physics.pause()
  paused = true
end
local function unpause()
  physics.start()
  paused = false
end
function scene:show( event )
<<<<<<< HEAD
<<<<<<< HEAD
    sceneGroup = self.view
    textPreview = display.newText('', display.contentCenterX, display.contentHeight + 20, native.systemFont, 16)
    if(event.phase == "will") then
<<<<<<< HEAD
<<<<<<< HEAD
||||||| parent of 3b126f0 (apple scene so gay)
=======
||||||| parent of b3ed691 (corona just wasted 6 hours of my lif)
    sceneGroup = self.view
    textPreview = display.newText('', display.contentCenterX, display.contentHeight + 20, native.systemFont, 16)
    if(event.phase == "will") then
=======

    if(event.phase == "will" and started == false) then
||||||| parent of 2963bb6 (please dont make me lua ever again)

    if(event.phase == "will" and started == false) then
=======
    local params = event.params
    sceneGroup = self.view
    if(event.phase == "will") then
      if(params.powerup == 'slow') then
        wordSpawnDelay = 1000
      else
        wordSpawnDelay = 500
      end
      
      if(params.powerup == 'contrast') then
        constrast = true
      else
        constrast = false
      end
      
      if(params.powerup == 'lives') then
         lives = 10
      else
         lives = 5
      end
      
      unpause()
>>>>>>> 2963bb6 (please dont make me lua ever again)
      started = true
      local correctWordOrder
      if(event.params and event.params.level) then
        correctWordOrder = levels[level]["correctWordOrder"]
        wordBank = levels[level]["wordBank"]
        setWords(wordBank)
      else
        correctWordOrder = levels[1]['correctWordOrder']
        wordBank = levels[1]["wordBank"]
      end
      sentenceManager.init(correctWordOrder)

      textPreview = display.newText('', display.contentCenterX, display.contentHeight + 20, native.systemFont, 16)
      sceneGroup:insert(textPreview)
<<<<<<< HEAD
>>>>>>> b3ed691 (corona just wasted 6 hours of my lif)
      lives = 5
>>>>>>> 3b126f0 (apple scene so gay)
||||||| parent of 2963bb6 (please dont make me lua ever again)
      lives = 5
=======
     
>>>>>>> 2963bb6 (please dont make me lua ever again)
      player = display.newImage(logging.getActive())
      player.height = 90
      player.width = 50
      player.xScale = -1
      player.y = display.contentHeight - player.height/2
      player.x = display.contentCenterX
      physics.addBody( player, "static", { density = 1.0, friction = 0.3, bounce = 0.2 } )
      sceneGroup:insert(player)
  
      lives_display = display.newText(lives, display.contentWidth - 10, 10, native.systemFont, 16)
      sceneGroup:insert(lives_display)
  

      sceneGroup:insert(player)
      
      -- spawns words at a set interval
      
<<<<<<< HEAD
      timerListener()
<<<<<<< HEAD
||||||| parent of 0ec442b (character dragging)
    player = display.newImage(logging.getActive())
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
=======
    player = display.newImage(logging.getActive())
    player.height = 90
    player.width = 50
    player.xScale = -1
    player.y = display.contentHeight - player.height/2
    player.x = display.contentCenterX
||||||| parent of 3b126f0 (apple scene so gay)
      player:addEventListener( "touch", myObject)
    end
end
=======
||||||| parent of 2963bb6 (please dont make me lua ever again)
            self.markX = self.x    -- store x location of object
            self.markY = self.y    -- store y location of object
      
        elseif event.phase == "moved" then
      
            local x = (event.x - event.xStart) + self.markX
            
            self.x = x   -- move object based on calculations above
        end
        
        return true
      end
      timerListener()
=======
            self.markX = self.x    -- store x location of object
            self.markY = self.y    -- store y location of object
      
        elseif event.phase == "moved" then
      
            local x = (event.x - event.xStart) + self.markX
            
            self.x = x   -- move object based on calculations above
        end
        
        return true
      end

>>>>>>> 2963bb6 (please dont make me lua ever again)
      
      player:addEventListener( "touch", myObject)
    end
end
>>>>>>> 3b126f0 (apple scene so gay)
    
    -- touch listener function
    
 --Credit where credit is due
 --https://coronalabs.com/blog/2011/09/24/tutorial-how-to-drag-objects/
function player:touch( event )
    if event.phase == "began" then
	
        self.markX = self.x    -- store x location of object
        self.markY = self.y    -- store y location of object
	
    elseif event.phase == "moved" then
	
        local x = (event.x - event.xStart) + self.markX
        
        self.x = x   -- move object based on calculations above
    end
    
    return true
end

player:addEventListener( "touch", myObject )




    lives_display = display.newText(lives, display.contentWidth - 10, 10, native.systemFont, 16)
    sceneGroup:insert(lives_display)

    wordSpawnDelay = 1000
    physics.addBody( player, "static", { density = 1.0, friction = 0.3, bounce = 0.2 } )
    -- spawns words at a set interval

    timer.performWithDelay(wordSpawnDelay, timerListener)
>>>>>>> 0ec442b (character dragging)
    end
end

--
-- This function gets called everytime you call composer.gotoScene() from this module.
-- It will get called twice, once before we transition the scene off screen and once again
-- after the scene is off screen.
function scene:hide( event )
    local sceneGroup = self.view
    if(event.phase == 'did') then
      sceneGroup:remove(textPreview)
      sceneGroup:remove(lives_display)
      display.remove(player)
      player = nil
      for i, word in pairs(fallenwords) do
        display.remove(word)
      end
      physics.stop()
    end
    sceneGroup = nil
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
local function onComplete( event )
   if event.action == "clicked" then
        composer.gotoScene('splash')
    end
end

local function doneSuggeston( event )
  print('done suggestion general event')
   if event.action == "clicked" then
        print('done suggestion')
        unpause()
    end
end
---------------------------------------------------------------------------------
-- Custom functions
---------------------------------------------------------------------------------
local function wordCollisionListener(self, event)
  if(event.phase == "began" and paused == false) then
    -- remove the collision listener from the object after something has collided
    self.collision = nil
    print(self.word .. 'was caught')
    if(sentenceManager.tryAddWord(self.word)) then
            addCorrect()
            print("added Correct!")
            textPreview.text = textPreview.text .. self.word
      -- update the senctence displayed
      if(sentenceManager.finished()) then
        -- end the game here
        -- the user has won
        pause()
        native.showAlert("wOOOOO","You won!", {"Okay"}, onComplete )
      end
    else
      -- subtract a life
      addIncorrect()
      print("added Incorrect!")
      addWrongInPosition(getCurrentWordNumber())
      
      if giveSuggestion(getCurrentWordNumber(), 4) ~= false and giveSuggestion(getCurrentWordNumber(), 4) ~= nil then
        local trouble = "It looks like you are having trouble with "
        
        if alertShow == true then
          alertShow = false
          pause()
          native.showAlert("Semantic Error", trouble ..giveSuggestion(getCurrentWordNumber(),4)[2] .."\n"  ..giveSuggestion(getCurrentWordNumber(),4)[1], {"okay"}, doneSuggeston)
          timer.performWithDelay(12000, function() alertShow = true end)
        end
      end
      
      
      lives = lives -1
      updateLives();
      if(lives < 0) then
        print('lives are negative')
        pause()
        native.showAlert(":(","You lose", {"Okay"}, onComplete)
      end
    end
    self:removeSelf()
  end
end


function createFallingWord()
  local randomWord = wordBank[math.random(1, #wordBank)]
  local width = display.contentWidth
  local randomx = math.random(1, width)
  local newFallingWord = display.newText( randomWord, randomx, 0, #randomWord *10,16)
  if(constrast) then
    newFallingWord.setFillColor(0,0,0)
  else
    newFallingWord.setFillColor(1,1,1)
  end
  local body = physics.addBody(newFallingWord, {density=0.9, friction =0.3, bounce=0.0})
  
  newFallingWord.word = randomWord
  sceneGroup:insert(newFallingWord)
  newFallingWord.collision = wordCollisionListener
  newFallingWord:addEventListener("collision", newFallingWord)
  fallenwords[#fallenwords] = newFallingWord
end

---------------------------------------------------------------------------------
-- END OF YOUR IMPLEMENTATION
---------------------------------------------------------------------------------
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
return scene
