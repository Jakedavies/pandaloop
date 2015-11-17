local composer = require( "composer" )
local logging = require( "logging" )


local function onSystemEvent( event )
  if event.type == "applicationStart" then
    logging.beginSession()
  elseif event.type == "applicationExit" then
    logging.endSession()
  elseif event.type == "applicationSuspend" then -- log this as end session too because android maintains the app in the background usually
    logging.endSession()
  elseif event.type == "applicationResume" then
    logging.beginSession()
  end
end

Runtime:addEventListener( "system", onSystemEvent )

composer.gotoScene( "new_user", { effect="crossFade", time=500 } )
