local widget = require( "widget" )


--Question Object
QuestionManager = {}
QuestionManager.__index = QuestionManager
 
 --Instantiate to empty we will manually set everything as we need it
 function QuestionManager:new(questions, sceneGroup)
    local o = {_questions = {}, _position = 1, _sceneGroup = sceneGroup}
    setmetatable(o, self)
    return o
end

function QuestionManager:addQuestion(question)
	self._questions.insert(question)
end

function QuestionManager:loadNextQuestion()
	local questionOld = self._questions[position]
	self._position += 1
	local questionNew = self._questions[position]
	return questionNew
end