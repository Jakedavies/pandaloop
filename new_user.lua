local composer = require( "composer" )
local scene = composer.newScene()
local widget = require( "widget" )
local json = require( "json" )
local input = ''
local textBox

--
-- This function gets called when composer.gotoScene() gets called an either:
--    a) the scene has never been visited before or
--    b) you called composer.removeScene() or composer.removeHidden() from some other
--       scene.  It's possible (and desirable in many cases) to call this once, but
--       show it multiple times.
--

function consent()
  print('saving consent')
    -- Path for the file to write
  local path = system.pathForFile( "consented.txt", system.DocumentsDirectory )

  -- Open the file handle
  local file, errorString = io.open( path, "w" )

  if not file then
      -- Error occurred; output the cause
      print( "File error: " .. errorString )
  else
    print("writing file")
    -- Write data to file
    file:write( "true" )
    -- Close the file handle
    io.close( file )
  end

end

function scene:create(event)
  local sceneGroup = self.view
end

--
-- This gets called twice, once before the scene is moved on screen and again once
-- afterwards as a result of calling composer.gotoScene()
--

local function submit()
  print("advance the step")

  composer.gotoScene( "splash", { effect="crossFade", time=500 } )
end

-- textbox needs to be declared at this scop so it can be manually destroyed
local textbox
function scene:show( event )
    local sceneGroup = self.view

    if event.phase == "did" then  -- Create the widget
    else -- event.phase == "will"

      local backgroundLayer3 = display.newImage("assets/sprites/country-platform-files/country-platform-files/layers/country-platform-back.png", display.contentHeight, display.contentWidth)
      backgroundLayer3.x = display.contentCenterX
      backgroundLayer3.y = display.contentCenterY
      backgroundLayer3.width = display.contentWidth
      backgroundLayer3.height = display.contentHeight
      sceneGroup:insert(backgroundLayer3)

      sceneGroup:insert(display.newText("Welcome To Pandalooper!", display.contentCenterX, 100, "fonts/Pacifico.ttf", 25))
      sceneGroup:insert(display.newText("To begin, lets start with you name?", display.contentCenterX, display.contentCenterY+50))
      textbox = native.newTextBox(display.contentCenterX, display.contentCenterY+100, (display.contentWidth /4) *3, 50)
      textbox.isEditable = true
      textbox.text = "Enter your name here to get started"

      -- create the button to submit this
      button = widget.newButton()
      button:setLabel("Submit")
      button:setEnabled(true)
      button.x = display.contentCenterX
      button.y = display.contentCenterY + 170
      sceneGroup:insert(button)
      button:addEventListener("tap", submit)
    end
end

--
-- This function gets called everytime you call composer.gotoScene() from this module.
-- It will get called twice, once before we transition the scene off screen and once again
-- after the scene is off screen.
function scene:hide( event )
    if(event.phase == "did") then
    else
      textbox:removeSelf()
      local sceneGroup = self.view
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
