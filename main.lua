local composer = require( "composer" )
local logging = require( "logging" )


local function onSystemEvent( event )
  if event.type == "applicationStart" then

  elseif event.type == "applicationExit" then

  elseif event.type == "applicationSuspend" then -- log this as end session too because android maintains the app in the background usually

  elseif event.type == "applicationResume" then
  	
  end
end
audio.setVolume(0)
Runtime:addEventListener( "system", onSystemEvent )


composer.gotoScene( "new_user", { effect="crossFade", time=500 } )

