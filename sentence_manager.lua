local manager = {}
local expected
local currentWordNumber = 1

function getCurrentWordNumber()
  return currentWordNumber
end

-- must be called first, expects a table of words in the correct expected order
function manager.init(expectedWords)
currentWordNumber = 1
  expected = expectedWords
end

-- return true if word is the next word in the sequence
function manager.tryAddWord(word)
  if(expected[currentWordNumber] == word) then
    currentWordNumber = currentWordNumber + 1
    return true
  else
    return false
  end
end
-- returns true if all the words have been complted
function manager.finished()
  return currentWordNumber > #expected
end

return manager
