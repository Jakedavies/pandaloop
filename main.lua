
local composer = require( "composer" )
_G.PARSE_APP_ID = "fQfHOZk9Oq6zcfWfGw9Zas2pL732QTK3omHwIl6k"
_G.PARSE_KEY = "L4gA4fCoEytFXsQtjHrlaZrSnrXeyomA0ibdKNXv"

local parse = require( "mod_parse" )
parse:init( { appId = PARSE_APP_ID, apiKey = PARSE_KEY } )
parse.showStatus = true
parse.showJSON = true
print("open app event")
parse:appOpened()

composer.gotoScene( "game", { effect="crossFade", time=500 } )
