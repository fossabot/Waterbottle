--[[
  Client Network Module V1 by Nathan Hall [WelpNathan] 
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
  or via Twitter! (https://twitter.com/WelpNathan)
	
  ------
	
  Network:ListenEvent(<string> fName, <function> fCallback)
    Listens for a RemoteEvent FireServer with a callback function.
			
  Network:ListenFunction(<string> fName, <function> fCallback)
    Listens for a RemoteFunction InvokeServer with a callback function.
			
  Network:FireEvent(Player<table> clients, <string> fName, <tuple> ...)
    Fires the RemoteEvent to an array of clients.

  Network:FireFunction(Player client, <string> fName, <tuple> ...)
    Fires the RemoteFunction to a client.
--]]

local Network = {}

-- Get the required variables for the module to function.
local replicatedStorage = game:GetService('ReplicatedStorage')
local remoteEvent = replicatedStorage:WaitForChild('RemoteEvent')
local remoteFunction = replicatedStorage:WaitForChild('RemoteFunction')

-- Store the events/functions in an array to call later.
Network.events = {}
Network.functions = {}

-- Listens for a RemoteEvent FireClient with a callback function.
-- @param fName The function name which can be aquired.
-- @param fCallback The function which will be called when the RemoteEvent is fired.
function Network:ListenEvent(fName, fCallback)
	Network.events[fName] = fCallback
end

-- Listens for a RemoteFunction InvokeClient with a callback function.
-- @param fName The function name which can be aquired.
-- @param fCallback The function which will be called when the RemoteFunction is fired.
function Network:ListenFunction(fName, fCallback)
	Network.functions[fName] = fCallback
end

-- Fires the RemoteEvent to the server.
-- @param fName The function which will be called on the server.
-- @param ... Contains the arguments of the function.
function Network:FireEvent(fName, ...)
	remoteEvent:FireServer(fName, ...)
end

-- Fires the RemoteFunction to the server.
-- @param fName The function which will be called on the server.
-- @param ... Contains the arguments of the function.
function Network:FireFunction(fName, ...)
	return remoteFunction:InvokeServer(fName, ...)
end

-- When the RemoteEvent is called on the client.
remoteEvent.OnClientEvent:Connect(function(fName, ...)
	if not Network.events[fName] then
		error('[Client Network] ' .. tostring(fName) .. ' has not been registered via the Network:ListenEvent() function.')
	end
	return Network.events[fName](...)
end)

-- When the RemoteFunction is called on the client.
remoteFunction.OnClientInvoke = function(fName, ...)
	if not Network.functions[fName] then
		error('[Client Network] ' .. tostring(fName) .. ' has not been registered via the Network:ListenFunction() function.')
	end
	return Network.functions[fName](...)
end

return Network
