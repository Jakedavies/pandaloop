
local composer = require( "composer" )
local scene = composer.newScene()
local widget = require( "widget" )
local json = require( "json" )
local input = ''
local textBox
local QuestionIndex = 1
local buttonWidth = display.contentWidth - display.contentWidth/25


require('question')
require('backgrounds')
require('mainCharacter')
require('button')
require('speech')
require('QuestionBank')


      
--FXNS


local isPaused = true


function sleep()
    --donothing
end
function loadNext()
    audio.stop(1)
    composer.gotoScene( "splash", { effect="crossFade", time=500 } )
end

function loadNo()
    --composer.gotoScene( "forTutorial", { effect="crossFade", time=500 } )
end

function list(event)
    if event.phase == "began" then 
        checkAnswer(event.target.button.index, event.target.button.question, event.target.button.sceneGroup)
    end
end

function addEventListeners(question)
    for i, button in pairs(question:getButtons()) do
        button.question = question
        button.sceneGroup = question.sceneGroup
        button:getAssetForeground():addEventListener("touch", list)
    end
end
function removeAllAssets(question, sceneGroup)
    for i, assets in pairs(question:getAssetsAll()) do
            sceneGroup:remove(assets)
    end
    for i, buttons in pairs(question:getButtons()) do
            buttons:getAssetForeground():removeEventListener("touch", list)
    end
end 

function checkAnswer(Index, Question, sceneGroup)
    if Index == Questions[QuestionIndex][4][1] then
        removeAllAssets(Question,sceneGroup)
        QuestionIndex = QuestionIndex + 1
        loadQuestion(sceneGroup)
    elseif 0 == Questions[QuestionIndex][4][1] then
        removeAllAssets(Question,sceneGroup)
        QuestionIndex = QuestionIndex + 1
        loadQuestion(sceneGroup)
    else
        native.showPopup(Questions[QuestionIndex][5][Index])
        print(Questions[QuestionIndex][5][Index])
    end
end
       
    function loadQuestion(sceneGroup)

        if Questions[QuestionIndex] then
            local q1 = Question:new()
            local s1 = Speech:new(false)

            s1:setMessage(Questions[QuestionIndex][1])
            s1:setX(display.contentCenterX)
            s1:setY(display.contentCenterY - 190)
            s1:setHeight(120)
            s1:setWidth(display.contentWidth)
            q1:setSpeech(s1)
            sceneGroup:insert(s1:getAssetSpeech())
            sceneGroup:insert(s1:getAssetMessage())

            if(Questions[QuestionIndex][2]) then
                local sTutorial = Speech:new(true)
                sTutorial:setX(display.contentCenterX)
                sTutorial:setY(display.contentCenterY+120)
                sTutorial:setHeight(150)
                sTutorial:setWidth(display.contentWidth-display.contentWidth/4)
                sTutorial:setMessage(Questions[QuestionIndex][2])
                q1:setSpeechTutorial(sTutorial)
                sceneGroup:insert(sTutorial:getAssetSpeech())
                sceneGroup:insert(sTutorial:getAssetMessage())
            end

            --Add the buttons
            local positions = {-100, -60, -20, 20}
            for i = 1, 4 do
                if Questions[QuestionIndex][3][i] then
                    local btn1Q1 = Button:new()
                    btn1Q1:setX(display.contentCenterX)
                    btn1Q1:setY(display.contentCenterY + positions[i])
                    btn1Q1:setLabel(Questions[QuestionIndex][3][i])
                    btn1Q1:setWidth(buttonWidth)
                    btn1Q1:setIndex(i)
                    btn1Q1.index = i
                    q1.sceneGroup = sceneGroup
                    q1:addBtn(btn1Q1)
                    addEventListeners(q1)
                    sceneGroup:insert(btn1Q1:getAssetBackground())
                    sceneGroup:insert(btn1Q1:getAssetForeground())
                    if Questions[QuestionIndex][4] == i then 
                        q1:setCorrect(i)
                    end
                end

            end
        else
            loadNext()
        end
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

    backgrounds = Backgrounds:new()
    sceneGroup:insert(backgrounds:getLayer1())
    sceneGroup:insert(backgrounds:getLayer2())
    sceneGroup:insert(backgrounds:getLayer3())

    tutorialSpeaker = MainCharacter:new()
    tutorialSpeaker:setAsset('assets/sprites/wizard_0.png')
    tutorialSpeaker:setX(display.contentCenterX - 100)
    tutorialSpeaker:setY(display.contentCenterY + 210)
    tutorialSpeaker:setWidthHeight(80,80)
    tutorialSpeaker:toFront()
    sceneGroup:insert(tutorialSpeaker:getAsset())

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

    loadQuestion(sceneGroup)
        
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
