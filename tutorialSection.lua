
local composer = require( "composer" )
local scene = composer.newScene()
local widget = require( "widget" )
local json = require( "json" )
local input = ''
local textBox

require('question')
require('backgrounds')
require('mainCharacter')
require('button')
require('speech')


local isPaused = true

function sleep()
    --donothing
end
function loadNext()
    audio.stop(1)
    composer.gotoScene( "loopTutorial2", { effect="crossFade", time=500 } )
end

function loadNo()
    --composer.gotoScene( "forTutorial", { effect="crossFade", time=500 } )
end
--
-- This function gets called when composer.gotoScene() gets called an either:
--    a) the scene has never been visited before or
--    b) you called composer.removeScene() or composer.removeHidden() from some other
--       scene.  It's possible (and desirable in many cases) to call this once, but
--       show it multiple times.
--
function scene:create(event)
    --
    -- self in this case is "scene", the scene object for this level.
    -- Make a local copy of the scene's "view group" and call it "sceneGroup".
    -- This is where you must insert everything (display.* objects only) that you want
    -- Composer to manage for you.
    local sceneGroup = self.view

    backgrounds = Backgrounds:new()
    sceneGroup:insert(backgrounds:getLayer1())
    sceneGroup:insert(backgrounds:getLayer2())
    sceneGroup:insert(backgrounds:getLayer3())

    knight = MainCharacter:new()
    knight:setX(display.contentCenterX - 100)
    knight:setY(display.contentCenterY + 210)
    knight:setWidthHeight(130,100)
    knight:toFront()
    sceneGroup:insert(knight:getAsset())


    local q1 = Question:new()
    local s1 = Speech:new()

    s1:setX(display.contentCenterX)
    s1:setY(display.contentCenterY - 180)
    s1:setHeight(100)
    s1:setWidth(display.contentWidth)
    s1:setMessage("for(int i = 0; i < 9001; i ++){ \n    doWizardStuff(); \n}")
    q1:setSpeech(s1)

    local btn1 = Button:new()
    btn1:setX(display.contentCenterX)
    btn1:setY(display.contentCenterY - 40)
    btn1:setLabel("That looks cool")
    btn1:setWidth(250)
    btn1:setIndex(1)
    q1:addBtn(btn1)

    local btn2 = Button:new()
    btn2:setX(display.contentCenterX)
    btn2:setY(display.contentCenterY)
    btn2:setLabel("That looks scary...")
    btn2:setWidth(250)
    btn2:setIndex(2)
    q1:addBtn(btn2)

    local btn3 = Button:new()
    btn3:setX(display.contentCenterX)
    btn3:setY(display.contentCenterY + 30)
    btn3:setLabel("That looks super scary...")
    btn3:setWidth(250)
    btn3:setIndex(2)
    q1:addBtn(btn3)

    local btn4 = Button:new()
    btn4:setX(display.contentCenterX)
    btn4:setY(display.contentCenterY + 60)
    btn4:setLabel("That looks really scary...")
    btn4:setWidth(250)
    btn4:setIndex(2)
    q1:addBtn(btn4)

   for i, asset in pairs(q1:getAssetsAll()) do
        sceneGroup:insert(asset)
   end


end

--
-- This gets called twice, once before the scene is moved on screen and again once
-- afterwards as a result of calling composer.gotoScene()
--
function scene:show( event )
    --
    -- Make a local reference to the scene's view for scene:show()
    --
    local sceneGroup = self.view



    --
    -- event.phase == "did" happens after the scene has been transitioned on screen.
    -- Here is where you start up things that need to start happening, such as timers,
    -- tranistions, physics, music playing, etc.
    -- In this case, resume physics by calling physics.start()
    -- Fade out the levelText (i.e start a transition)
    -- Start up the enemy spawning engine after the levelText fades
    --
    if event.phase == "did" then

    local message =  display.newText(" Alright, well for loops are a great way \n to repeat a section of code a specific number of times. \n They are a crucial part of control flow. \n The top of your screen shows a for loop!  ", display.contentCenterX + 5, display.contentCenterY + 115,  native.systemFontBold, 10)
    message:setFillColor(0, 0, 0 )
    sceneGroup:insert(message)




  -- Create the widget

    else -- event.phase == "will"
        -- The "will" phase happens before the scene transitions on screen.  This is a great
        -- place to "reset" things that might be reset, i.e. move an object back to its starting
        -- position. Since the scene isn't on screen yet, your users won't see things "jump" to new
        -- locations. In this case, reset the score to 0.

    end
end

--
-- This function gets called everytime you call composer.gotoScene() from this module.
-- It will get called twice, once before we transition the scene off screen and once again
-- after the scene is off screen.
function scene:hide( event )
    local sceneGroup = self.view
    display.remove(textBox)
    textBox = nil
    sceneGroup:remove(backgroundLayer2)
    sceneGroup:remove(background)
    sceneGroup:remove(backgroundLayer3)
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
