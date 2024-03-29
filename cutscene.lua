--Attack of the killer cubes

local composer = require( "composer" )
local scene = composer.newScene()

local widget = require( "widget" )
local json = require( "json" )
local correctText =  "for(int i =0; i< x; i++)\n{print(penis2);\n}"
local status
local circleCenter

--
-- define local functions here
--

--
-- This function gets called when composer.gotoScene() gets called an either:
--    a) the scene has never been visited before or
--    b) you called composer.removeScene() or composer.removeHidden() from some other
--       scene.  It's possible (and desirable in many cases) to call this once, but
--       show it multiple times.
    sceneGroup.insert(player)
-
local sceneGroup
function scene:create( event )
    --
    status = event.params.status
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

end

--
-- This gets called twice, once before the scene is moved on screen and again once
-- afterwards as a result of calling composer.gotoScene()
--
local transitionState
local panda
local circle
local transitionTime
local player
local levelText
function scene:show( event )
    --
    -- Make a local reference to the scene's view for scene:show()
    --
    sceneGroup = self.view

    --
    -- event.phase == "did" happens after the scene has been transitioned on screen.
    -- Here is where you start up things that need to start happening, such as timers,
    -- tranistions, physics, music playing, etc.
    -- In this case, resume physics by calling physics.start()
    -- Fade out the levelText (i.e start a transition)
    -- Start up the enemy spawning engine after the levelText fades
    --
    if event.phase == "did" then
        transitionState = 0
        transitionTime = 170
        animation()
    else -- event.phase == "will"
        -- The "will" phase happens before the scene transitionitions on screen.  This is a great
        -- place to "reset" things that might be reset, i.e. move an object back to its starting
        -- position. Since the scene isn't on screen yet, your users won't see things "jump" to new
        -- locations. In this case, reset the score to 0.
    end
end
local button1
local button
local button2
local buttonBackground2
local buttonBackground1
local statustext
function animationDoneListener(event)
    if status == true then
        statustext = 'You win'

        buttonBackground2 = display.newImage("assets/sprites/touch.png");
        buttonBackground2.x = display.contentCenterX
        buttonBackground2.y = display.contentCenterY + 80
        sceneGroup:insert(buttonBackground2)

        button2 = widget.newButton()
        button2: setLabel("Main Menu")
        button2: setEnabled(true)
        button2.x = display.contentCenterX
        button2.y = display.contentCenterY + 80
        button2:addEventListener("tap", onGoToMenuClick)
        sceneGroup:insert(button2)
    else
        transition.to(panda, {time=500, x= display.contentCenterX, y= display.contentCenterY - 100})
        transition.to(blood, {time=500, x= display.contentCenterX, y= display.contentCenterY - 100, alpha = 1})

        buttonBackground1 = display.newImage("assets/sprites/touch.png");
        buttonBackground1.x = display.contentCenterX - 75
        buttonBackground1.y = display.contentCenterY + 80
        sceneGroup:insert(buttonBackground1)

        statustext = 'You lose'
        button = widget.newButton()
        button: setLabel("Try Again")
        button: setEnabled(true)
        button.x = display.contentCenterX - 75
        button.y = display.contentCenterY + 80
        button:addEventListener("tap", onGoToGameClick)
        sceneGroup:insert(button)



        buttonBackground2 = display.newImage("assets/sprites/touch.png");
        buttonBackground2.x = display.contentCenterX + 75
        buttonBackground2.y = display.contentCenterY + 80
        sceneGroup:insert(buttonBackground2)
        button2 = widget.newButton()
        button2: setLabel("Main Menu")
        button2: setEnabled(true)
        button2.x = display.contentCenterX + 75
        button2.y = display.contentCenterY + 80
        button2:addEventListener("tap", onGoToMenuClick)
        sceneGroup:insert(button2)

        tip = display.newText({text = "Tip: Dont forget the difference between ", 0, 0, font = native.systemFont, fontSize = 16, alpha = 0 })
        tip.x = display.contentCenterX
        tip.y = display.contentCenterY + 120
        tip.fontSize = 15
        tip:setFillColor( 100 )
        sceneGroup:insert(tip)

        tip2 = display.newText({text = "<= and < when using a for loop", 0, 0, font = native.systemFont, fontSize = 16, alpha = 0 })
        tip2.x = display.contentCenterX
        tip2.y = display.contentCenterY + 135
        tip2.fontSize = 15
        tip2:setFillColor( 100 )
        sceneGroup:insert(tip2)

    end
    levelText = display.newText({text = statustext, 0, 0, font = native.systemFontBold, fontSize = 30, alpha = 0 })
    levelText.x = display.contentCenterX
    levelText.y = display.contentCenterY
    levelText.fontSize = 20
    levelText:setFillColor( 100 )
    sceneGroup:insert(levelText)

end
function onGoToGameClick()
    composer.gotoScene( "game", { effect="crossFade", time=500 } )
end
function onGoToMenuClick()
    composer.gotoScene( "splash", { effect="crossFade", time=500 } )
end
function pandaTransitionListener(event)
    rotatePanda()
end


function rotatePanda()
   local xpos = circleCenter.x
   local ypos = circleCenter.y
   if status == true and transitionTime > 30 then
        print(transitionState)
         if transitionState == 0 then
             transitionTime = transitionTime - 20
             transitionState = transitionState+1
             transition.to( panda, { time=transitionTime, x=(xpos + 70), y=(ypos-70), onComplete=pandaTransitionListener })
         elseif transitionState == 1 then
             transitionState = transitionState+1
             transition.to( panda, { time=transitionTime, x=(xpos+100), y=(ypos), onComplete=pandaTransitionListener} )
         elseif transitionState == 2 then
             transitionState = transitionState+1
             transition.to( panda, { time=transitionTime, x=(xpos+70), y=(ypos +70), onComplete=pandaTransitionListener} )
             print('going to 50 50')
         elseif transitionState == 3 then
            transitionState = transitionState+1
             transition.to( panda, { time=transitionTime, x=(xpos), y=(ypos+100), onComplete=pandaTransitionListener} )
         elseif transitionState == 4 then
             transitionState = transitionState+1
             transition.to( panda, { time=transitionTime, x=(xpos-70), y=(ypos+70), onComplete=pandaTransitionListener} )
         elseif transitionState == 5 then
             transitionState = transitionState+1
             transition.to( panda, { time=transitionTime, x=(xpos-100), y=ypos, onComplete=pandaTransitionListener} )
         elseif transitionState == 6 then
            transitionState = transitionState+1
             transition.to( panda, { time=transitionTime, x=(xpos - 70), y=(ypos-70), onComplete=pandaTransitionListener} )
        elseif transitionState == 7 then
            transitionState = 0
            transition.to( panda, { time=transitionTime, x=(xpos), y=(ypos-100), onComplete=pandaTransitionListener} )
        end
    elseif status == false and transitionTime > 100 then
         if transitionState == 0 then
             transitionTime = transitionTime - 50
             transitionState = transitionState+1
             transition.to( panda, { time=transitionTime, x=(xpos + 50), y=(ypos-50), onComplete=pandaTransitionListener })
         elseif transitionState == 1 then
             transitionState = transitionState+1
             transition.to( panda, { time=transitionTime, x=(xpos+100), y=(ypos), onComplete=pandaTransitionListener} )
         elseif transitionState == 2 then
             transitionState = transitionState+1
             transition.to( panda, { time=transitionTime, x=(xpos+50), y=(ypos +50), onComplete=pandaTransitionListener} )
         elseif transitionState == 3 then
            transitionState = transitionState+1
             transition.to( panda, { time=transitionTime, x=(xpos), y=(ypos+100), onComplete=pandaTransitionListener} )
         elseif transitionState == 4 then
             transitionState = transitionState+1
             transition.to( panda, { time=transitionTime, x=(xpos-50), y=(ypos+50), onComplete=pandaTransitionListener} )
         elseif transitionState == 5 then
             transitionState = transitionState+1
             transition.to( panda, { time=transitionTime, x=(xpos-100), y=ypos, onComplete=pandaTransitionListener} )
         elseif transitionState == 6 then
            transitionState = transitionState+1
             transition.to( panda, { time=transitionTime, x=(xpos - 50), y=(ypos-50), onComplete=pandaTransitionListener} )
        elseif transitionState == 7 then
            transitionState = 0
            transition.to( panda, { time=transitionTime, x=(xpos), y=(ypos-100), onComplete=pandaTransitionListener} )
        end
    else
        -- show smoke if you won, if not show death animation?
        if status == true then
            -- consecutive frames
            local sequenceData =
            {
                name="smoking",
                start=1,
                count=15,
                time=300,
                loopCount = 0,   -- Optional ; default is 0 (loop indefinitely)
            }
            local sheetData = { width=256, height=256, numFrames=15, sheetContentWidth=1280, sheetContentHeight=768 }
            local imageSheet = graphics.newImageSheet( "smoke5x3frames.png", sheetData )
            local smoke = display.newSprite( imageSheet, sequenceData )
            smoke.x=xpos
            smoke.y=ypos
            smoke:play()
            transition.to(circle, {time = 500, alpha = 0})
            transition.to(smoke, {time=600, alpha =0})
            transition.to(panda, {time=500, alpha =0, onComplete=animationDoneListener})
        else
            transition.to(circle, {time = 500, alpha = 0})
            transition.to(player, {alpha = 0, time = 500, onComplete=animationDoneListener})
            transition.to(panda, {x= circleCenter.x, y= circleCenter.y})
        end
    end
end
function animation()
    -- draw the circle thing
    local paint = { 0.7, 0.7, 0.7 }
    local fill = { 0, 0, 0 }
    circleCenter = {x = display.contentCenterX, y = display.contentCenterY + 100}
    circle = display.newCircle(circleCenter.x, circleCenter.y, 100)
    circle.stroke = paint
    circle.fill = none
    circle.strokeWidth = 4

    local sequenceData =
    {
        name="smoking",
        start=1,
        count=15,
        time=300,
        loopCount = 0,   -- Optional ; default is 0 (loop indefinitely)
    }
    local sheetData = { width=500, height=510, numFrames=6, sheetContentWidth=3700, sheetContentHeight=510 }
    local imageSheet = graphics.newImageSheet( "blood.png", sheetData )

    player = display.newImage('assets/sprites/knight.png')
    player.height = 90
    player.width = 50
    player.xScale = -1


    player:translate(display.contentCenterX, display.contentCenterY - 100)

    panda = display.newImage('mikos-walk.gif')
    panda:translate(circleCenter.x, circleCenter.y-100)

    if(status == true) then
        rotatePanda(panda)
    else
        rotatePanda(panda)
    end
 end





--
-- This function gets called everytime you call composer.gotoScene() from this module.
-- It will get called twice, once before we transition the scene off screen and once again
-- after the scene is off screen.
function scene:hide( event )
    local sceneGroup = self.view

    if event.phase == "will" then
        display.remove(circle)
        display.remove(player)
        display.remove(panda)
        display.remove(button1)
        display.remove(button)
        display.remove(button2)
        display.remove(buttonBackground1)
        display.remove(buttonBackground2)
        display.remove(levelText)

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
