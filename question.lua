--Hacky OOP because lua is silly.

require( "widget" )
--Question Object
Question = {}
Question.__index = Question
 
 --Instantiate to empty we will manually set everything as we need it
 function Question:new()
    local o = {_question = "", _answers = {}, _correctAnswer = "", _errorTypes = {}, _speech= '', _buttons = {}, _speechTutorial = nil}
    setmetatable(o, self)
    return o
end

function Question:getButtons()
    return self._buttons
end

function Question:setSpeech(speech)
    self._speech = speech
end
function Question:getSpeech()
    return self._speech
end
--Getters and setters
function Question:getQuestion()
    return self._question
end
function Question: setQuestion(quest)
    self._question = quest;
end
function Question: setAnswers(answers)
    self._answers = answers
end
function Question: getAnswers()
    local answers = { self._answer1,  self._answer2,  self._answer3,  self._answer4}
    return answers
end
function Question: setCorrect(correct)
      self._correctAnswer = correct:getLabel()
end
function Question: getCorrect()
    return self._correctAnswer
end

--Just set it equal to the whole array of types.
--This expects an array of types
function Question:setErrorTypes(etypes)
     self._errorTypes = etypes
end

function Question:checkAnswer(attempt)
    return self._correctAnswer == attempt
end

function Question:getCorrectIndex()
    local correct = 0
     for i, asset in pairs(self._answers) do
        if asset == self._correctAnswer then 
            correct = i 
        end
    end
    return correct
end


function Question:getAssetsAll()

    local assets = {}

    for i, asset in pairs(self._buttons) do
        table.insert(assets, self._buttons[i]:getAssetBackground())
        table.insert(assets, self._buttons[i]:getAssetForeground())
    end

    table.insert(assets, self._speech:getAssetSpeech())
    table.insert(assets, self._speech:getAssetMessage())

    if self._speechTutorial then
        table.insert(assets,self._speechTutorial:getAssetSpeech())
        table.insert(assets,self._speechTutorial:getAssetMessage())
    end

    return assets
end


function Question:addBtn(btn)
    table.insert(self._buttons,btn)   
    table.insert(self._answers, btn:getLabel()) 
end

function Question:setSpeechTutorial(speechTut)
    self._speechTutorial = speechTut
end
function Question:getSpeechTutorial()
    return self._speechTutorial
end