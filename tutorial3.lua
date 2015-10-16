
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
    composer.gotoScene( "MCCheck", { effect="crossFade", time=500 } )
end
function loadNo()
    composer.gotoScene( "loopTutorial", { effect="crossFade", time=500 } )
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
        background.y = display.contentCenterY + 200
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
    backgroundLayer3.height = display.contentHeight




    --
    -- Insert it into the scene to be managed by Composer
    --
    sceneGroup:insert(backgroundLayer3)
    sceneGroup:insert(backgroundLayer2)


    speech = display.newImage('assets/sprites/comic-2.png')
      speech.x = display.contentCenterX
      speech.xScale = -1
      speech.y =  display.contentCenterY +85
      speech.height = 150
      speech.width = 290
      speechx= speech.x
      sceneGroup:insert(speech)



     buttonBackground = display.newImage("assets/sprites/touch.png");
    buttonBackground.x = display.contentCenterX - 50
    buttonBackground.y = display.contentCenterY + 95
    buttonBackground.width = 80

    button = widget.newButton()
    button: setLabel("Yes")
    button: setEnabled(true)
    button.x = display.contentCenterX -50
    button.y = display.contentCenterY + 95
    button:addEventListener("tap", loadNext)

     buttonBackground2 = display.newImage("assets/sprites/touch.png");
    buttonBackground2.x = display.contentCenterX + 45
    buttonBackground2.y = display.contentCenterY + 95
    buttonBackground2.width = 100

    button2 = widget.newButton()
    button2: setLabel("Nope")
    button2: setEnabled(true)
    button2.x = display.contentCenterX + 45
    button2.y = display.contentCenterY + 95
    button2:addEventListener("tap", loadNo)

    sceneGroup:insert(buttonBackground)
    sceneGroup:insert(button)
    sceneGroup:insert(buttonBackground2)
    sceneGroup:insert(button2)



      knight = display.newImage('assets/sprites/wizard_0.png')
      knight.x = display.contentCenterX - 100
      knight.y =  display.contentCenterY + 210
      knight.height = 130
      knight.width = 100
      knight.xScale = -1
      kx = knight.x
      knight:toFront()
      sceneGroup:insert(knight)


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

    local message =  display.newText("You, do know about for loops right?  \n Because it seems like you don't... ", display.contentCenterX + 5, display.contentCenterY + 40,  native.systemFontBold, 10)
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
