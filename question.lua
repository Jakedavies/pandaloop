--Hacky OOP because lua is silly.

--Question Object
Question = {}
Question.__index = Question
 
 --Instantiate to empty we will manually set everything as we need it
 function Question:new()
    local o = {_question = "", _answers = {}, _correctAnswer = "", _errorTypes = {}, _speech= '', _buttons = {}}
    setmetatable(o, self)
    return o
end

function Question:checkAnswer(button)
    local correctness = false
    if self._correctAnswer == self._answers[button:getIndex()] then
        correctness = true
        end
    return correctness
end

function Question:setButtons(buttons)
    self._buttons = buttons
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
      self._correctAnswer = correct
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



function Question:getAssetsAll()
    local assets =  {self._buttons[1]:getAssetBackground(), self._buttons[1]:getAssetForeground(), self._buttons[2]:getAssetBackground(), self._buttons[2]:getAssetForeground(),self._buttons[3]:getAssetBackground(), self._buttons[3]:getAssetForeground(),self._buttons[4]:getAssetBackground(), self._buttons[4]:getAssetForeground()}
    table.insert(assets,self._speech:getAssetSpeech())
    table.insert(assets,self._speech:getAssetMessage())
    return assets
end


function Question:addBtn(btn)
    table.insert(self._buttons,btn)
end