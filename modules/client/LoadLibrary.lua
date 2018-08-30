--[[
	Library Loader Module V1 by Nathan Hall [WelpNathan] 
  Part of the Waterbottle Scripting Library.
  https://github.com/WelpNathan/Waterbottle
	
  This lua module is licensed under the MIT License.
  https://github.com/WelpNathan/Waterbottle/blob/master/LICENSE

  In short, this allows you to do the following:
  * Use this code for commercial use.
  * Use this code for private use.
  * Modify the code in any way.
  * Distribute the code.

	I do not hold any liability of warranty for usage on how you use the code.
	Refer to the MIT license for a full description.
	
	For questions, please reach out to me on the Roblox Developer Forum (@WelpNathan)
	or via Twitter (https://twitter.com/WelpNathan)
	
	------
	
	Lib:LoadLibrary(<string> libraryName)
    Returns the cached version of a module script.
    
  ------

  Using this library:
    This module will allow you to load any server library.

    local LoadLibrary = require('LOCATION OF THIS MODULE')
    local Network = LoadLibrary('Network')
--]]
	
local serverAPIs = script:GetDescendants()

local Lib = {}

-- Initialise the library cache.
local libraryCache = {}
for _, library in pairs(serverAPIs) do
	libraryCache[library.Name] = library
end

-- Returns the cached version of a module script.
-- @param libraryName The library name which should be aquired.
function Lib.LoadLibrary(libraryName)
	local library = libraryCache[libraryName]
	if library then
		return require(library)
	end
	warn(libraryName .. ' does not exist and will not be loaded.')
end

-- When the library is called, return the load lib function.
setmetatable(Lib, {
	__call = function(_, libraryName)
		return Lib.LoadLibrary(libraryName)
	end,
	__index = function(_, libraryName)
		return Lib.LoadLibrary(libraryName)
	end
})

return Lib
