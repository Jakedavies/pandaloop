
local composer = require( "composer" )
local scene = composer.newScene()

local widget = require( "widget" )
local json = require( "json" )
local input = '';
local correctText =  "for(int i =0; i< x; i++)\n{print(penis2);\n}"


---------------------------------------------------------------------------------
-- All code outside of the listener functions will only be executed ONCE
-- unless "composer.removeScene()" is called.
---------------------------------------------------------------------------------

-- local forward references should go here

local function handleCheckMyCode( event )
    --
    -- When you tap the "I Win" button, reset the "nextlevel" scene, then goto it.
    --
    -- Using a button to go to the nextlevel screen isn't realistic, but however you determine to 
    -- when the level was successfully beaten, the code below shows you how to call the gameover scene.
    --

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
    elseif event.phase == "editing" then
      print('editing');
        input = event.text
        print(input)
    end
end

---------------------------------------------------------------------------------

-- "scene:create()"
function scene:create( event )

   local sceneGroup = self.view

   -- Initialize the scene here.
   -- Example: add display objects to "sceneGroup", add touch listeners, etc.
    local background = display.newRect(0,0, 150, 50)
    background.width = display.contentWidth
    background.height = display.contentHeight
    background.x = display.contentWidth / 2
    background.y = display.contentHeight / 2
    background:setFillColor(31/255, 166/255, 122/255 )
    circleSize = display.contentHeight/4
    fontSize = display.contentHeight/15


    -- Insert it into the scene to be managed by Composer
    sceneGroup:insert(background)

    --
    -- levelText is going to be accessed from the scene:show function. It cannot be local to
    -- scene:create(). This is why it was declared at the top of the module so it can be seen 
    -- everywhere in this module
    levelText = display.newEmbossedText('fix the code to win', 0, 0,  "/fonts/Pacifico.ttf", 14)
    levelText:setFillColor( 1 )
    levelText.x = display.contentCenterX
    levelText.y = display.contentCenterY-150
    sceneGroup:insert( levelText )



    code = display.newText('for(int i =0; i< x; i++){ \n print(apple);\n}', 0, 0, native.systemFontBold, 14)
    code.x = display.contentCenterX
    code.y = display.contentCenterY - 50
    sceneGroup:insert(code)

    textBox = native.newTextField(background.x,background.y+80, 300, 150, "/fonts/Pacifico.ttf", 14)
    textBox.text = "This is line 1.\nAnd this is line2"
    textBox.isEditable = true
    textBox:addEventListener( "userInput", inputListener )
    sceneGroup:insert(textBox)


    local checkMyCode = widget.newButton({
        label = "Check my code!",  
        onEvent = handleCheckMyCode
    })
    sceneGroup:insert(checkMyCode)
    checkMyCode.x = display.contentCenterX
    checkMyCode.y = display.contentHeight - 60


end

function loadNext()
  composer.gotoScene( "game", { effect="crossFade", time=900 } )
end

-- "scene:show()"
function scene:show( event )

   local sceneGroup = self.view
   local phase = event.phase

   if ( phase == "will" ) then
      -- Called when the scene is still off screen (but is about to come on screen).
   elseif ( phase == "did" ) then
      -- Called when the scene is now on screen.
      -- Insert code here to make the scene come alive.
      -- Example: start timers, begin animation, play audio, etc.

   end
end

-- "scene:hide()"
function scene:hide( event )

   local sceneGroup = self.view
   local phase = event.phase

   if ( phase == "will" ) then
      -- Called when the scene is on screen (but is about to go off screen).
      -- Insert code here to "pause" the scene.
      -- Example: stop timers, stop animation, stop audio, etc.
   elseif ( phase == "did" ) then
      -- Called immediately after scene goes off screen.
   end
end

-- "scene:destroy()"
function scene:destroy( event )

   local sceneGroup = self.view

   -- Called prior to the removal of scene's view ("sceneGroup").
   -- Insert code here to clean up the scene.
   -- Example: remove display objects, save state, etc.
end

---------------------------------------------------------------------------------




-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

---------------------------------------------------------------------------------

return scene