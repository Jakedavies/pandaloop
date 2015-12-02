local loggin = {}

local parse = require ("mod_parse")



_G.PARSE_APP_ID = "fQfHOZk9Oq6zcfWfGw9Zas2pL732QTK3omHwIl6k"
_G.PARSE_KEY = "L4gA4fCoEytFXsQtjHrlaZrSnrXeyomA0ibdKNXv"
local user_id

parse:init({
	appId = "fQfHOZk9Oq6zcfWfGw9Zas2pL732QTK3omHwIl6k",
	apiKey = "L4gA4fCoEytFXsQtjHrlaZrSnrXeyomA0ibdKNXv"
	})
parse.showStatus = true

local questions = {}
local session
local questionsStartTime = {}
local sessionStart
local attempts = {}
local inventory = {}
local credits

local characters
local allCharacters = require('characters')
local active = allCharacters[1]
-- called when the question is
function loggin.createUser(name, save)
	parse:createObject("user", { ["credits"] = 100, ["name"] = name, ["active"] = active, ["characters" ] =  allCharacters[1]}, function(event)
		if not event.error then
			local uid = event.response.objectId
			user_id = uid
			save("user.txt", user_id)
			syncUser()
		else
			print("error starting question")
		end
	end
	)
end
function loggin.changeActive(new)
	active = new
	parse:updateObject("user", user_id, { ["active"] = new})
end
function loggin.addCharacter(character)
	characters[#characters+1] = character
	parse:updateObject("user", user_id, { ["characters"] = strjoin(',',characters)})
end
function loggin.getUserId()
	return user_id
end
function loggin.getCredits()
	if(credits ~= nil) then
		return credits
	else
		return 0
	end
end
function loggin.getCharacters()
	return characters
end
function loggin.getActive()
	return active
end
function loggin.addCredits(num)
	--optimistic update, do not use this in production
	credits = credits + num
	parse:updateObject("user", user_id, { ["credits"] = credits})
end
function loggin.removeCredits(num)
	--optimistic update, do not use this in production
	credits = credits - num
	parse:updateObject("user", user_id, { ["credits"] = credits})
end

function loggin.setUser(id)
	user_id = id
	syncUser()
end
function syncUser()
	parse:getObject("user", user_id, function(event)
		if not event.error then
			credits = event.response.credits
			characters = strsplit(',', event.response.characters)
			active = event.response.active
		else
			print('errrrrrr')
		end
	end
	)
end
function loggin.questionStarted(qid)
	parse:createObject( "question", { ["session"] = session, ["qid"] = qid, ["answered"] = false}, function(event)
		if not event.error then
			questions[qid] = event.response.objectId
			questionsStartTime[qid] = system.getTimer()
			if(attempts[qid] == nil) then
				attempts[qid] = 0;
			end
		else
			print("error starting question")
		end
	end
	)
end
-- called when the question is completed
function loggin.questionAnswered(qid, correct)
	if(questions[qid] ~= nil) then
		attempts[qid]= attempts[qid]+ 1
		parse:updateObject("question", questions[qid], {["attempt"] = attempts[qid], ["correct"] = correct, ["answered"] = true, ["time_taken"] = (system.getTimer() - questionsStartTime[qid])})
		-- reset the question
		questions[qid] = nil
	end
end

function loggin.beginSession()
	parse:createObject( "session", function(event)
		if not event.error then
			session = event.response.objectId
			sessionStart = system.getTimer()
		else
			print("error starting session")
		end
	end
	)
end
function loggin.endSession()
	if(session ~= nil) then
		parse:updateObject("session", session, {["exited"] = true, ["length"] = (system.getTimer() - sessionStart)})
	end
end

function strjoin(delimiter, list)
  local len = #list
  if len == 0 then 
    return "" 
  end
  local string = list[1]
  for i = 2, len do 
    string = string .. delimiter .. list[i] 
  end
  return string
end
function strsplit(delimiter, text)
  local list = {}
  local pos = 1
  if string.find("", delimiter, 1) then -- this would result in endless loops
    error("delimiter matches empty string!")
  end
  while 1 do
    local first, last = string.find(text, delimiter, pos)
    if first then -- found?
      table.insert(list, string.sub(text, pos, first-1))
      pos = last+1
    else
      table.insert(list, string.sub(text, pos))
      break
    end
  end
  return list
end


return loggin
