--Attack of the killer cubes

local composer = require( "composer" )
local scene = composer.newScene()

local widget = require( "widget" )
local json = require( "json" )
local input = ''
local textBox
local correctText =  "for(int i =0; i < 5; i++)\n{print('apple');\n}"

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
        if(input == correctText) then

            composer.gotoScene("cutscene", { time= 500, effect = "crossFade", params = { status = true}})
            print('text matches')
        else
            composer.gotoScene("cutscene", { time= 500, effect = "crossFade", params = { status = false}})
            print('you suck')
            
        end
    end
    return true
end
local function inputListener( event )
    if event.phase == "editing" then
        input = event.text
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
    local backgroundLayer3 = display.newImage("assets/sprites/country-platform-files/country-platform-files/layers/country-platform-back.png", display.contentHeight, display.contentWidth)
    backgroundLayer3.x = display.contentCenterX
    backgroundLayer3.y = display.contentCenterY 
    backgroundLayer3.width = display.contentWidth
    backgroundLayer3.height = display.contentHeight
    
    --
    -- Insert it into the scene to be managed by Composer
    --
    sceneGroup:insert(backgroundLayer3)


    code = display.newText('for(int i =0; i< x; i++)\n{print(apple);\n}', 0, 0, native.systemFontBold, 14 )
    code:setFillColor(0)
    code.x = display.contentCenterX
    code.y = display.contentCenterY - 100

    sceneGroup:insert(code)

    --
    -- levelText is going to be accessed from the scene:show function. It cannot be local to
    -- scene:create(). This is why it was declared at the top of the module so it can be seen 
    -- everywhere in this module
    levelText = display.newText('Make apple print 5 times', 0, 0, native.systemFontBold, 16 )
    levelText:setFillColor( 0 )
    levelText.x = display.contentCenterX
    levelText.y = display.contentCenterY
    --
    -- Insert it into the scene to be managed by Composer
    --
    sceneGroup:insert( levelText )



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
        onEvent = handleCheckMyCode,
        --properties for a rounded rectangle button...
        shape="roundedRect",
        width = 200,
        height = 40,
        cornerRadius = 2,
        -- probably fix the color on this
        fillColor = { default={ 1, 1, 1, 1 }, over={ 1, 1, 1, 1 } },
        strokeColor = { default={ 0, 0, 0, 0 }, over={ 0.8, 0.8, 1, 1 } },
        strokeWidth = 4
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
        textBox = native.newTextBox( display.contentCenterX, display.contentCenterY + 50, display.contentWidth, 200 )
        textBox.text = "for(int i =0; i < ???; i++)\n{print('apple');\n}"
        textBox.isEditable = true
        textBox:addEventListener( "userInput", inputListener )
        sceneGroup:insert(textBox)
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
