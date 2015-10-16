
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

function pausePhysics( event )
        if isPaused == false then
            physics.pause()
            isPaused = true
        elseif isPaused == true then
            physics.start()
            isPaused = false
        end

end

function sleep()
    --donothing
end
function loadNext()
    composer.gotoScene( "game", { effect="crossFade", time=500 } )
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



     local backgroundLayer3 = display.newImage("assets/sprites/country-platform-files/country-platform-files/layers/country-platform-back.png", display.contentHeight, display.contentWidth)
    backgroundLayer3.x = display.contentCenterX
    backgroundLayer3.y = display.contentCenterY +50
    backgroundLayer3.width = display.contentWidth
    backgroundLayer3.height = display.contentHeight + 50




    --
    -- Insert it into the scene to be managed by Composer
    --
    sceneGroup:insert(backgroundLayer3)



      knight = display.newImage('assets/sprites/knight.png')
      knight.x = display.contentCenterX
      knight.y =  display.contentCenterY + 200
      knight.height = 90
      knight.width = 50
      knight.xScale = -1
      kx = knight.x
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

    sfx = audio.loadSound( "assets/music/CausticChip16.ogg" )
    audio.play(sfx)

    local authors =  display.newText("Authors: \n Nolan Koriath\n Jake Davies", display.contentCenterX, display.contentCenterY-50, "/fonts/Pacifico.ttf", 30)
    authors:setFillColor(0, 0, 0 )
    sceneGroup:insert(authors)

    local t1 = display.newText("Assets", display.contentCenterX, display.contentCenterY+40, "/fonts/Pacifico.ttf", 20)
    local t2 =display.newText("Button Texture. Author: Arnaud de Saint Mloir \n \t Modifications: Removed Text", display.contentCenterX, display.contentCenterY+70, "/fonts/Pacifico.ttf", 12)
    local t3 = display.newText("Knight and Wizard. \n \t Author:  Stacy ( laetissima - opengameart.com)", display.contentCenterX, display.contentCenterY+130, "/fonts/Pacifico.ttf", 12)
    local t4 =display.newText("Credit Music. Author: Jan123 - opengameart.com", display.contentCenterX, display.contentCenterY+170, "/fonts/Pacifico.ttf", 12)
    t1:setFillColor(0, 0, 0 )
    t2:setFillColor(0, 0, 0 )
    t3:setFillColor(0, 0, 0 )
    t4:setFillColor(0, 0, 0 )
    sceneGroup:insert(t1)
    sceneGroup:insert(t2)
    sceneGroup:insert(t3)
    sceneGroup:insert(t4)
  -- Create the widget

    else -- event.phase == "will"
        -- The "will" phase happens before the scene transitions on screen.  This is a great
        -- place to "reset" things that might be reset, i.e. move an object back to its starting
        -- position. Since the scene isn't on screen yet, your users won't see things "jump" to new
        -- locations. In this case, reset the score to 0.
                audio.stop(1)

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
