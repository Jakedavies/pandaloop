
local CORRECT_QUESTIONS = 1
local INCORRECT_QUESTIONS = 2
local SYNTAX_ERROR = 3
local SEMANTIC_ERROR = 4

local EASY_LEVEL_THRESH = 0.6
local MEDIUM_LEVEL_THRESH = 0.75
local HARD_LEVEL_THRESH = 0.8

local questionToggle = 0

local level = 0

local questionTracker = {
	{0},
	{0},
	{0},
	{0}
}

-- 1   2          3       4      5
--for(int i = 0; i < 10; i ++){dostuffs();};
local positionInLoop = [0,0,0,0,0]

function addFirstElementWrong()
	positionInLoop[1] += 1
end
function addSecondElementWrong()
	positionInLoop[2] += 1
end
function addThirdElementWrong()
	positionInLoop[3] += 1
end
function addFourthElementWrong()
	positionInLoop[4] += 1
end
function addFifthElementWrong()
	positionInLoop[5] += 1
end	

function giveSuggestion(positionForWrong, errorType)
	if getProbableMisunderstanding(positionForWrong) then 
		return getErrorMessage(positionForWrong)
	end
end


--Todo, connect this to error skew fxn so that we can skew the suggestions towards syntax vs semantic errors.
function getErrorMessage(positionForWrong)
	--Semantic Error Tips
	local one = ["Remember, the beginning of the for loop begins with exactly what it is, 'for' ", "The syntax for a  valid for loop is 'for(int i = 0; i < 10; i ++{}) '", "first part of the for loop"]
	local two = ["Remember, we have to declare a variable in the first position of the for loop...", "You can declare an int as int i = [someValue]", "declaring a variable"];
	local three = ["Remember, we need to check something here so that the loop knows when to terminate","The middle position is where a check should be in place to know when the loop should terminate...", "the for loops conditional statement"]
	local four = ["At the end of each loop, the third position executes, here we want to modify our variable. ","We have a variable, what needs to happen here?", "modifying the variable"]
	local five = ["Remember, here is where we do stuff! But DO NOT modify your variable here...","In the inner brackets, we want to do stuff.", "what to do in the for loop"]
	
	--Semantic Errors Tips
	--TODO: Write semantic error tips
	
	local tips = [one,two,three,four,five]
	local ret = [tips[positionForWrong][questionToggle], tips[positionForWrong][questionToggle][3]]
	
	questionToggle = questionToggle%1 --Toggle questionToggle
	return ret	
end


function getProbableMisunderstanding(pos)
		if questionTracker[INCORRECT_QUESTIONS] == 0 then
			return -1
		end
    	if positionInLoop[pos]/questionTracker[INCORRECT_QUESTIONS] > .6 then
			return true
		end
end



function addCorrect()
	questionTracker[CORRECT_QUESTIONS] += 1
end
function addIncorrect()
	questionTracker[INCORRECT_QUESTIONS] += 1
end
function addSyntaxError()
	questionTracker[SYNTAX_ERROR] += 1
end
function addSemanticError()
	questionTracker[SEMANTIC_ERROR] += 1
end


--Returns 0 if same number of syntax as semantic errors
function getErrorSkew()
	if questionTracker[CORRECT_QUESTIONS]+questionTracker[INCORRECT_QUESTIONS] > 0 then
		if questionTracker[SYNTAX_ERROR]/questionTracker[INCORRECT_QUESTIONS] > questionTracker[SEMANTIC_ERROR]/questionTracker[SEMANTIC_ERROR] then
			return SYNTAX_ERROR
		else
			return SEMANTIC_ERROR
		end
	else
		return 0
	end
end


function calculateLevel()
	if questionTracker[CORRECT_QUESTIONS]+questionTracker[INCORRECT_QUESTIONS] > 0 then
		local thresh = questionTracker[CORRECT_QUESTIONS]/(questionTracker[CORRECT_QUESTIONS]+questionTracker[INCORRECT_QUESTIONS])
		if thresh > HARD_LEVEL_THRESH then 
			return 2
		elseif thresh > MEDIUM_LEVEL_THRESH then 
			return 1
		else 
			return 0
		end
	else
		return -1
	end
end


