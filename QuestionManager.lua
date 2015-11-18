local widget = require( "widget" )
require( "composer" )


--Question Object
QuestionManager = {}
QuestionManager.__index = QuestionManager
 

function checkAnswer(button, correctIndex, self)
	if correctIndex == 0 then 
		self:loadNextQuestion()
	end
end

 --Instantiate to empty we will manually set everything as we need it
 function QuestionManager:new(sceneGroup)
    local o = {_questions = {}, _position = 1, _callback , _currentCorrectIndex = 0}
    setmetatable(o, self)
    return o
end

function QuestionManager:addQuestion(question)
	table.insert(self._questions, question )
end

function QuestionManager:loadFirstQuestion(callback)
	self._callback = callback
    local correctIndex = self._questions[self._position]:getCorrectIndex()

    for i, button in pairs(self._questions[self._position]:getButtons()) do
        button:getAssetForeground():addEventListener("tap", function() checkAnswer(button, correctIndex, self) end)
    end
    return self._questions[self._position]
end

function QuestionManager:loadNextQuestion()

	self._position = self._position + 1 --advance question
	
    local correctIndex = self._questions[self._position]:getCorrectIndex()

    print(self._position)
    for i, button in pairs(self._questions[self._position]:getButtons()) do
        button:getAssetForeground():addEventListener("tap", function() checkAnswer(button, correctIndex, self) end)
    end

    return self._questions[self._position]
end