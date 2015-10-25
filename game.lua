--Attack of the killer cubes

local composer = require( "composer" )
local scene = composer.newScene()

local widget = require( "widget" )
local json = require( "json" )
local input = ''
local textBox
local correctText =  "9"

-- INIT PARSE
local parse = require( "mod_parse" )
_G.PARSE_APP_ID = "fQfHOZk9Oq6zcfWfGw9Zas2pL732QTK3omHwIl6k"
_G.PARSE_KEY = "L4gA4fCoEytFXsQtjHrlaZrSnrXeyomA0ibdKNXv"
parse:init( { appId = PARSE_APP_ID, apiKey = PARSE_KEY } )
parse.showStatus = true
parse.showJSON = true



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

        print("Question answered event")
        if(math.floor(input) == math.floor(correctText)) then
            parse:logEvent( "Question Answered", {["question_number"] = "1", ["correct"] = true})
            composer.gotoScene("cutscene", { time= 500, effect = "crossFade", params = { status = true}})
            print('text matches')
        else
            parse:logEvent( "Question Answered", {["question_number" ] = "1", ["correct"] = false})
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
    correctText = tostring(math.random(1000)+8999)
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
    backgroundLayer3.height = display.contentHeight + 200
    backgroundLayer3:toFront()


    --
    -- Insert it into the scene to be managed by Composer
    --
    sceneGroup:insert(backgroundLayer3)
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
        textBox = native.newTextBox( display.contentCenterX, display.contentCenterY - 50, display.contentWidth, 200 )
        textBox.text = "14"
        textBox.isEditable = true
        textBox.width = 30
        textBox.height = 20
        textBox:addEventListener( "userInput", inputListener )
        sceneGroup:insert(textBox)
        local paint = { 0.2, 0.2, 0.2 }
        local fill = { 0, 0, 0 }
        circleCenter = {x = display.contentCenterX, y = display.contentCenterY - 60}
        square = display.newRect(circleCenter.x, circleCenter.y, 300, 300)
        square.fill = paint

        local paint = { 0.1, 0.1, 0.1 }
        circleCenter = {x = display.contentCenterX - 20, y = display.contentCenterY - 30}
        square2 = display.newRect(circleCenter.x, circleCenter.y, 200, 70)
        square2.fill = paint

        code7 = display.newText('Edit the for loop to call', 0, 0, native.systemFontBold, 14 )
        code7:setFillColor(1)
        code7.x = display.contentCenterX
        code7.y = display.contentCenterY -  140

        code = display.newText(' the confusePanda function ' .. correctText ..' times ', 0, 0, native.systemFontBold, 14 )
        code:setFillColor(1)
        code.x = display.contentCenterX
        code.y = display.contentCenterY -  120

        code2 = display.newText('to confuse him until he disapears', 0, 0, native.systemFontBold, 14 )
        code2:setFillColor(1)
        code2.x = display.contentCenterX
        code2.y = display.contentCenterY -  100

        code3 = display.newText('for(int i = 0; i < ', 0, 0, native.systemFontBold, 14 )
        code3:setFillColor(1)
        code3.x = display.contentCenterX - 60
        code3.y = display.contentCenterY -  50

        code4 = display.newText('; i++){', 0, 0, native.systemFontBold, 14 )
        code4:setFillColor(1)
        code4.x = display.contentCenterX + 30
        code4.y = display.contentCenterY - 50

        code5 = display.newText('confusePanda()', 0, 0, native.systemFontBold, 14 )
        code5:setFillColor(1)
        code5.x = display.contentCenterX - 20
        code5.y = display.contentCenterY - 30


        code6 = display.newText('}', 0, 0, native.systemFontBold, 14 )
        code6:setFillColor(1)
        code6.x = display.contentCenterX - 90
        code6.y = display.contentCenterY - 10

        -- The "will" phase happens before the scene transitions on screen.  This is a great
        -- place to "reset" things that might be reset, i.e. move an object back to its starting
        -- position. Since the scene isn't on screen yet, your users won't see things "jump" to new
        -- locations. In this case, reset the score to 0.


        print("question start event")
        parse:logEvent( "Question", { ["number"] = "1" })
    end
end

--
-- This function gets called everytime you call composer.gotoScene() from this module.
-- It will get called twice, once before we transition the scene off screen and once again
-- after the scene is off screen.
function scene:hide( event )
    local sceneGroup = self.view
    display.remove(textBox)
    display.remove(code)
    display.remove(code2)
    display.remove(code3)
    display.remove(code4)
    display.remove(code5)
    display.remove(code6)
    display.remove(square)
    display.remove(code7)
    display.remove(square2)
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
