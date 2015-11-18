local files = {}

function files.exists(document)
  local path = system.pathForFile( document, system.DocumentsDirectory )
  local file, errorString = io.open( path, "r" )

  if not file then
      -- Error occurred; output the cause
      print( "File error: " .. errorString )
      return false
  else
      -- Read data from file
      local contents = file:read( "*a" )
      -- Output the file contents
      if contents ~= "" then

        io.close( file )
        return true
      else

        io.close(file)
        return false
      end
  end
end

function files.getContents(document)
  local path = system.pathForFile( document, system.DocumentsDirectory )

  local file, errorString = io.open( path, "r" )

  if not file then
      -- Error occurred; output the cause

      print( "File error: " .. errorString )
      return false
  else
      -- Read data from file
      local contents = file:read( "*a" )
      -- Output the file contents
      if contents ~= "" then
        io.close( file )
        return contents
      else

        io.close(file)
        return false
      end
  end
end
function files.write(document, content)
  local path = system.pathForFile( document, system.DocumentsDirectory )

  -- Open the file handle
  local file, errorString = io.open( path, "w" )

  if not file then
      -- Error occurred; output the cause
      print( "File error: " .. errorString )
  else
    file:write( content)
    -- Close the file handle
    io.close( file )
  end
end
return files
