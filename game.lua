--Attack of the killer cubes

local composer = require( "composer" )
local scene = composer.newScene()

local widget = require( "widget" )
local json = require( "json" )
local input = '';
local correctText =  "for(int i =0; i< x; i++)\n{print(penis2);\n}"

--
-- define local functions here
--
local function handleCheckMyCode( event )
    --
    -- When you tap the "I Win" button, reset the "nextlevel" scene, then goto it.
    --
    -- Using a button to go to the nextlevel screen isn't realistic, but however you determine to 
    -- when the level was successfully beaten, the code below shows you how to call the gameover scene.
    --

    -- Check the fucking code here 
    if event.phase == "ended" then
        print('in onclick handler')
        print ('correct text')
        print(correctText)
        print('input')
        print(input)
        if(input == "for(int i =0; i< x; i++)\n{print(penis2);\n}") then
            print('text matches')
            composer.gotoScene("menu", { time= 500, effect = "crossFade" })
        end
    end
    return true
end
local function inputListener( event )
    if event.phase == "began" then
        -- user begins editing textBox
        input = event.text
    elseif event.phase == "ended" then
       input = event.text
    elseif event.phase == "editing" then
        print( event.text )

        input = event.text
        print(input)
    end
end

--
-- This function gets called when composer.gotoScene() gets called an either:
--    a) the scene has never been visited before or
--    b) you called composer.removeScene() or composer.removeHidden() from some other
--       scene.  It's possible (and desirable in many cases) to call this once, but 
--       show it multiple times.
--
function scene:create( event )
    --
    -- self in this case is "scene", the scene object for this level. 
    -- Make a local copy of the scene's "view group" and call it "sceneGroup". 
    -- This is where you must insert everything (display.* objects only) that you want
    -- Composer to manage for you.
    local sceneGroup = self.view

    --
    -- make a copy of the current level value out of our
    -- non-Global app wide storage table.
    --

    --
    -- create your objects here
    --
    
    --
    -- These pieces of the app only need created.  We won't be accessing them any where else
    -- so it's okay to make it "local" here
    --
    local background = display.newRect(display.contentCenterX, display.contentCenterY, display.contentWidth, display.contentHeight)
    background:setFillColor( 0.6, 0.7, 0.3 )
    --
    -- Insert it into the scene to be managed by Composer
    --
    sceneGroup:insert(background)


    code = display.newText('for(int i =0; i< x; i++)\n{print(penis);\n}', 0, 0, native.systemFontBold, 14 )
    code:setFillColor( 0 )
    code.x = display.contentCenterX
    code.y = display.contentCenterY - 100

    sceneGroup:insert(code)

    --
    -- levelText is going to be accessed from the scene:show function. It cannot be local to
    -- scene:create(). This is why it was declared at the top of the module so it can be seen 
    -- everywhere in this module
    levelText = display.newText('fix the code to win', 0, 0, native.systemFontBold, 16 )
    levelText:setFillColor( 0 )
    levelText.x = display.contentCenterX
    levelText.y = display.contentCenterY
    --
    -- Insert it into the scene to be managed by Composer
    --
    sceneGroup:insert( levelText )


    local textBox = native.newTextBox( display.contentCenterX, display.contentCenterY + 50, display.contentWidth, 200 )
    textBox.text = "for(int i =0; i< x; i++)\n{print(penis);\n}"
    textBox.isEditable = true
    textBox:addEventListener( "userInput", inputListener )
    sceneGroup:insert(textBox)
    -- 
    -- because we want to access this in multiple functions, we need to forward declare the variable and
    -- then create the object here in scene:create()
    --

    --
    -- these two buttons exist as a quick way to let you test
    -- going between scenes (as well as demo widget.newButton)
    --

    local checkMyCode = widget.newButton({
        label = "Check my code!",  
        onEvent = handleCheckMyCode
    })
    sceneGroup:insert(checkMyCode)
    checkMyCode.x = display.contentCenterX
    checkMyCode.y = display.contentHeight - 60

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
    
    if event.phase == "will" then
        -- The "will" phase happens before the scene is transitioned off screen. Stop
        -- anything you started elsewhere that could still be moving or triggering such as:
        -- Remove enterFrame listeners here
        -- stop timers, phsics, any audio playing
        timer.cancel( spawnTimer )
    end

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