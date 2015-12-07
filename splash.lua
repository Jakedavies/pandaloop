
local composer = require( "composer" )
local scene = composer.newScene()
local widget = require( "widget" )
local json = require( "json" )
local input = ''
local textBox
local logging = require('logging')




require("mainCharacter")
require("backgrounds")
background = Backgrounds:new()
require("button")
require("creditWidget")
local allowed = true


function loadNext()
    if(allowed) then
      print('going to apple')
      composer.gotoScene( "apple_scene", { effect="crossFade", time=500 } )
      allowed  = false
      timer.performWithDelay( 200, function()
      allowed = true
        end )
    end
    
end
function loadTutorial()
 if(allowed) then
      print('going to apple')
    composer.gotoScene( "tutorialSection", { effect="crossFade", time=500 } )
    allowed  = false
      timer.performWithDelay( 200, function()
      allowed = true
        end )
    end
end
function loadCredits()
    if(allowed) then
      print('going to apple')
        audio.stop(1)
    composer.gotoScene( "credits", { effect="crossFade", time=500 } )
    allowed  = false
      timer.performWithDelay( 200, function()
      allowed = true
        end )
    end
end
function loadStore()
 if(allowed) then
      print('going to apple')
  audio.stop(1)
  composer.gotoScene( "shop", { effect="crossFade", time=500})
  allowed  = false
      timer.performWithDelay( 200, function()
      allowed = true
        end )
    end
end
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
    --require backgroud assets
    local sceneGroup = self.view

    print(logging.getUserId())
    -- Order is important on these
    
    sceneGroup:insert(background:getLayer3())
    sceneGroup:insert(background:getLayer2())
    sceneGroup:insert(background:getLayer1())

    local title = display.newText("Panda Looper", display.contentCenterX, display.contentCenterY-20, native.systemFontBold, 45)
    sceneGroup:insert(title);
    title:setFillColor( 1, 1, 1 )

    villian = MainCharacter:new()
    villian:setAsset('mikos-walk.gif')
    villian:setX(display.contentCenterX - 100)
    villian:setY(display.contentCenterY + 200)
    px = villian:getX()
    sceneGroup:insert(villian:getAsset())

      local path = system.pathForFile( "consented.txt", system.DocumentsDirectory )

      -- Open the file handle
      local file, errorString = io.open( path, "r" )

      if not file then
          -- Error occurred; output the cause
          print( "File error: " .. errorString )
          native.showAlert( "Education" , "This game uses user data to improve how it teaches. If you use this app, you consent to the use of this data. If you do not consent. Please close this app and uninstall it. ", {"Great"}, consent)
      else
          -- Read data from file
          local contents = file:read( "*a" )
          -- Output the file contents
          if contents == "true" then
            -- Close the file handle

            io.close( file )
          else
            io.close(file)
            native.showAlert( "Education" , "This game uses user data to improve how it teaches. If you use this app, you consent to the use of this data. If you do not consent. Please close this app and uninstall it. ",{"Great"}, consent)
          end
      end
      file = nil
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
    if(event.phase == "did") then
      
      mainCharacter = display.newImage(logging.getActive())
      mainCharacter.height = 90
      mainCharacter.width = 50
      mainCharacter.xScale = -1
      mainCharacter.y = display.contentHeight - mainCharacter.height/2
      mainCharacter.x = display.contentCenterX-300
      sceneGroup:insert(mainCharacter)
  
      --
      -- event.phase == "did" happens after the scene has been transitioned on screen.
      -- Here is where you start up things that need to start happening, such as timers,
      -- tranistions, physics, music playing, etc.
      -- In this case, resume physics by calling physics.start()
      -- Fade out the levelText (i.e start a transition)
      -- Start up the enemy spawning engine after the levelText fades
      --
      if event.phase == "did" then
          sfx = audio.loadSound( "assets/music/relax_background1.ogg" )
          audio.play(sfx)
      local i = 0
  
      widget = CreditWidget:new(logging.getCredits())
      widget:play()
      sceneGroup:insert(widget:getAsset())
      sceneGroup:insert(widget:getNumber())
  
      --We will leave this section alone, just because it's only bad once ;)
      btn1 = Button:new()
      btn1:setX(display.contentCenterX)
      btn1:setY(display.contentCenterY + 60)
      btn1:setLabel("play")
      btn1:getAssetForeground():addEventListener("tap", loadNext)
      sceneGroup:insert(btn1:getAssetBackground())
      sceneGroup:insert(btn1:getAssetForeground())
  
      btn2 = Button:new()
      btn2:setX(display.contentCenterX)
      btn2:setY(display.contentCenterY + 100)
      btn2:setLabel("credits")
      btn2:getAssetForeground():addEventListener("tap", loadCredits)
      sceneGroup:insert(btn2:getAssetBackground())
      sceneGroup:insert(btn2:getAssetForeground())
  
  
      btn3 = Button:new()
      btn3:setX(display.contentCenterX)
      btn3:setY(display.contentCenterY + 140)
      btn3:setLabel("tutorial")
      btn3:getAssetForeground():addEventListener("tap", loadTutorial)
      sceneGroup:insert(btn3:getAssetBackground())
      sceneGroup:insert(btn3:getAssetForeground())
  
  
      btn4 = Button:new()
      btn4:setX(display.contentCenterX)
      btn4:setY(display.contentCenterY + 180)
      btn4:setLabel("store")
      btn4:getAssetForeground():addEventListener("tap", loadStore)
      sceneGroup:insert(btn4:getAssetBackground())
      sceneGroup:insert(btn4:getAssetForeground())
      --Chase the panda!
        while px < display.contentWidth +150 do
          px = px + 2
          transition.to( villian:getAsset(), { time=5000, x=(px), y=(villian:getY())})
          kx = kx + 2
          transition.to(mainCharacter, { time=5000, x=(kx), y=(mainCharacter.y)})
        end
      else
          audio.stop(1)
      end
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
    audio.stop()

end

---------------------------------------------------------------------------------
-- END OF YOUR IMPLEMENTATION
---------------------------------------------------------------------------------
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
return scene
