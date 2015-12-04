local composer = require( "composer" )
local logging = require( "logging" )


local function onSystemEvent( event )
  if event.type == "applicationStart" then

  elseif event.type == "applicationExit" then

  elseif event.type == "applicationSuspend" then -- log this as end session too because android maintains the app in the background usually

  elseif event.type == "applicationResume" then
  	
  end
end

Runtime:addEventListener( "system", onSystemEvent )


composer.gotoScene( "apple_scene", { effect="crossFade", time=500 } )

