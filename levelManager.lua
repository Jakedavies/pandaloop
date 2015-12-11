
local CORRECT_QUESTIONS = 1
local INCORRECT_QUESTIONS = 2
local SYNTAX_ERROR = 3
local SEMANTIC_ERROR = 4

local EASY_LEVEL_THRESH = 0.5
local MEDIUM_LEVEL_THRESH = 0.6
local HARD_LEVEL_THRESH = 0.9


--Corresponds to the position in the foor loop that questions are correct or incorrect. 
-- 1   2          3       4      5
--for(int i = 0; i < 10; i ++){dostuffs();};
positionInLoop = {0,0,0,0,0}

questionToggle = 1

local level = 0
local wordBank = {
      'for(',
      'int',
      'i = %int%;',
      'int i = 0;',
      '){',
      'stopApplesFromFalling();',
      '};'
 }
 
local currentWordNum = 1

function getCurrWord()
	return currentWordNum
end

local questionTracker = {
	0,
	0,
	0,
	0
}

function addWrongInPosition(pos)
		positionInLoop[getLookup(pos)] = positionInLoop[getLookup(pos)] + 1
		print(positionInLoop[getLookup(pos)])
end

function giveSuggestion(pos, errorType)

	if calculateLevel() == 2 or calculateLevel() == -1 then
		return false --This user has over 80% correct or this is one of the first catches wrong...
	end

	if getProbableMisunderstanding(pos) then 
		return getErrorMessage(pos)
	else
		return false
	end
end

function getErrorMessage(pos)

	if questionToggle == 0 then 
		questionToggle = 2
	end


	--Semantic Error Tips
	local one = {"Remember, the beginning of the for loop begins with exactly what it is, 'for' ", "The syntax for a  valid for loop is 'for(int i = 0; i < 10; i ++{}) '", "first part of the for loop"}
	local two = {"Remember, we have to declare a variable in the first position of the for loop...", "You can declare an int as int i = [someValue]", "declaring a variable"}
	local three = {"Remember, we need to check something here so that the loop knows when to terminate","The middle position is where a check should be in place to know when the loop should terminate...", "the for loops conditional statement"}
	local four = {"At the end of each loop, the third position executes, here we want to modify our variable. ","We have a variable, what needs to happen here?", "modifying the variable"}
	local five = {"Remember, here is where we do stuff! But DO NOT modify your variable here...","In the inner brackets, we want to do stuff.", "what to do in the for loop"}

	
	
	local tips = {one,two,three,four,five}
	
		local tip = tips[getLookup(pos)]
		local ret = {tip[questionToggle], tip[3]}
		
		if questionToggle == 2 then 
			questionToggle = 0
		end
		
		questionToggle = (questionToggle%1) --Toggle questionToggle
		return ret

end

--Find where to lookup the suggestion in the table. 
function getLookup(pos)
	local size = table.getn(wordBank)
		if pos == nil then 
			return false
		end
		
			canRun = false
			percent = pos/size
			local lookup = 1
			if percent >= .8 then 
				lookup = 5
			elseif percent >= .6 then 
				lookup = 4
			elseif percent >= .4 then 
				lookup = 3
			elseif percent >= .2 then
				lookup = 2
			else
				lookup = 1
			end
			
			return lookup

end

function getProbableMisunderstanding(pos)
		if pos == nil then
			return false
		end

		if questionTracker[INCORRECT_QUESTIONS] == 0 then
			return false
		elseif positionInLoop[getLookup(pos)]/questionTracker[INCORRECT_QUESTIONS] >= .8 then
			return true
		end
end

function setWords(wBank)
	wordBank = {
      'for(',
      'int',
      'i = %int%;',
      'int i = 0;',
      '){',
      'stopApplesFromFalling();',
      '};'
    }

end
function addCorrect()
	questionTracker[CORRECT_QUESTIONS] = questionTracker[CORRECT_QUESTIONS]+ 1
	currentWordNum = currentWordNum +1
end
function addIncorrect()
	questionTracker[INCORRECT_QUESTIONS] =  questionTracker[INCORRECT_QUESTIONS] + 1
end
function addSyntaxError()
	questionTracker[SYNTAX_ERROR] = questionTracker[SYNTAX_ERROR]  + 1
end
function addSemanticError()
	questionTracker[SEMANTIC_ERROR] = questionTracker[SEMANTIC_ERROR] + 1
end


--Returns 0 if same number of syntax as semantic errors
-- May not actually use this if the syntactic errors do not make sense. 
-- Our error types are conceptual to the errors, so they would be defined as they are on line 12
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
	if questionTracker[INCORRECT_QUESTIONS] == 1 then
		--This user has caught their first wrong skip
		return -1
	end

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


