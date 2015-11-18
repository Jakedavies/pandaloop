
local composer = require( "composer" )
local scene = composer.newScene()
local widget = require( "widget" )
local json = require( "json" )
local input = ''
local textBox
function loadProgress(j)
    progressView:setProgress(j)
end

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



    local background = display.newImage("assets/sprites/country-platform-files/country-platform-files/layers/country-platform-tiles-example.png", display.contentHeight, display.contentWidth)
    background.x = display.contentCenterX
    background.y = display.contentCenterY +200
    sceneGroup:insert(background)

    local backgroundLayer2 = display.newImage("assets/sprites/country-platform-files/country-platform-files/layers/country-platform-forest.png", display.contentHeight, display.contentWidth)
    backgroundLayer2.x = display.contentCenterX
    backgroundLayer2.y = display.contentCenterY + 200
    backgroundLayer2.width = display.contentWidth
    backgroundLayer2.height = display.contentHeight /3

     local backgroundLayer3 = display.newImage("assets/sprites/country-platform-files/country-platform-files/layers/country-platform-back.png", display.contentHeight, display.contentWidth)
    backgroundLayer3.x = display.contentCenterX
    backgroundLayer3.y = display.contentCenterY + 50
    backgroundLayer3.width = display.contentWidth
    backgroundLayer3.height = display.contentHeight +500




    --
    -- Insert it into the scene to be managed by Composer
    --
    sceneGroup:insert(backgroundLayer3)
    sceneGroup:insert(backgroundLayer2)


    speech = display.newImage('assets/sprites/comic-2.png')
      speech.x = display.contentCenterX
      speech.xScale = -1
      speech.y =  display.contentCenterY + 130
      speech.height = 100
      speech.width = 290
      speechx= speech.x
      sceneGroup:insert(speech)





      knight = display.newImage('assets/sprites/wizard_0.png')
      knight.x = display.contentCenterX - 100
      knight.y =  display.contentCenterY + 210
      knight.height = 130
      knight.width = 100
      knight.xScale = -1
      kx = knight.x
      knight:toFront()
      sceneGroup:insert(knight)

    buttonBackground = display.newImage("assets/sprites/touch.png");
    buttonBackground.x = display.contentCenterX
    buttonBackground.y = display.contentCenterY - 180
    buttonBackground.width = display.contentWidth
    buttonBackground.height = 180


    button = widget.newButton()
    button: setLabel("for(int i = 0; i < 9001; i ++){ \n    doWizardStuff(); \n}")
    button: setEnabled(true)
    button.x = display.contentCenterX
    button.y = display.contentCenterY - 180



    buttonBackground3 = display.newImage("assets/sprites/touch.png");
    buttonBackground3.x = display.contentCenterX
    buttonBackground3.y = display.contentCenterY - 35
    buttonBackground3.width = display.contentWidth
    buttonBackground3.height = 50

    button3 = widget.newButton()
    button3: setLabel("That looks scary...")
    button3: setEnabled(true)
    button3.x = display.contentCenterX
    button3.y = display.contentCenterY - 35
    button3:addEventListener("tap", loadNext)

    buttonBackground4 = display.newImage("assets/sprites/touch.png");
    buttonBackground4.x = display.contentCenterX
    buttonBackground4.y = display.contentCenterY +10
    buttonBackground4.width = display.contentWidth
    buttonBackground4.height = 50

    button4 = widget.newButton()
    button4: setLabel("Okay, how does it work?")
    button4: setEnabled(true)
    button4.x = display.contentCenterX
    button4.y = display.contentCenterY + 10
    button4:addEventListener("tap", loadNext)



    sceneGroup:insert(buttonBackground)
    sceneGroup:insert(button)

    sceneGroup:insert(buttonBackground3)
    sceneGroup:insert(button3)
    sceneGroup:insert(buttonBackground4)
    sceneGroup:insert(button4)



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
