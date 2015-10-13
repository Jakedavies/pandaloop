
local composer = require( "composer" )
local scene = composer.newScene()
local widget = require( "widget" )
local json = require( "json" )
local input = ''
local textBox


function loadNext()
  composer.gotoScene( "game", { effect="crossFade", time=2000} )
end

function sleep()
  -- do nothing
end

function addprogress()
  progress = progressView:getProgress() + .1
  progressView:setProgress(progress)
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

    local background = display.newImage("/img/gplaypattern.png")
    background.x = display.contentCenterX
    background.y = display.contentCenterY
    --
    -- Insert it into the scene to be managed by Composer
    --
    sceneGroup:insert(background)

    local title =  display.newText("PANDA\n  LOOP", display.contentCenterX, display.contentCenterY-50, "/fonts/Pacifico.ttf", 40)
    title:setFillColor( 0, 0, 0 )
    sceneGroup:insert(title)

    panda = display.newImage('mikos-walk.gif')
    
      panda.x = display.contentCenterX
      panda.y =  display.contentCenterY + 100
      sceneGroup:insert( panda)  
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

     progressView = widget.newProgressView
    {
    left = display.contentCenterX - 150,
    top = display.contentCenterY + 200,
    width = 300,
    height = 30,
    isAnimated = true
    }
    sceneGroup:insert(progressView)




    --
    -- event.phase == "did" happens after the scene has been transitioned on screen. 
    -- Here is where you start up things that need to start happening, such as timers,
    -- tranistions, physics, music playing, etc. 
    -- In this case, resume physics by calling physics.start()
    -- Fade out the levelText (i.e start a transition)
    -- Start up the enemy spawning engine after the levelText fades
    --
    if event.phase == "did" then
       timer.performWithDelay(1000, addprogress(), 9)

       timer.performWithDelay(7000,loadNext())


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
