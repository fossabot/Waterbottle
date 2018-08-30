--[[
	Server Network Module V1 by Nathan Hall [WelpNathan] 
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
local remoteEvent = Instance.new('RemoteEvent', replicatedStorage)
local remoteFunction = Instance.new('RemoteFunction', replicatedStorage)

-- Store the events/functions in an array to call later.
Network.events = {}
Network.functions = {}

-- Listens for a RemoteEvent FireServer with a callback function.
-- @param fName The function name which can be aquired.
-- @param fCallback The function which will be called when the RemoteEvent is fired.
function Network:ListenEvent(fName, fCallback)
	Network.events[fName] = fCallback
end

-- Listens for a RemoteFunction InvokeServer with a callback function.
-- @param fName The function name which can be aquired.
-- @param fCallback The function which will be called when the RemoteFunction is fired.
function Network:ListenFunction(fName, fCallback)
	Network.functions[fName] = fCallback
end

-- Fires the RemoteEvent to an array of clients.
-- @param clients An array of clients for the event to be sent to.
-- @param fName The function which will be called on the clients.
-- @param ... Contains the arguments of the function.
function Network:FireEvent(client, fName, ...)
	for _, client in next, client do
		remoteEvent:FireClient(client, fName, ...)
	end
end

-- Fires the RemoteFunction to one client.
-- @param client The player which the servers will invoke.
-- @param fName The function which will be called on the client.
-- @param ... Contains the arguments of the function.
function Network:FireFunction(client, fName, ...)
	return remoteFunction:InvokeClient(client, fName, ...)
end

-- Call the event when the client requests it to be called.
remoteEvent.OnServerEvent:Connect(function(client, fName, ...)
	if not Network.events[fName] then
		error('[Server Network] ' .. tostring(fName) .. ' has not been registered via the Network:ListenEvent() function.')
	end
	return Network.events[fName](client, ...)
end)

-- Call the function when the client requests it to be called.
remoteFunction.OnServerInvoke = function(client, fName, ...)
	if not Network.functions[fName] then
		error('[Server Network] ' .. tostring(fName) .. ' has not been registered via the Network:ListenFunction() function.')
	end
	return Network.functions[fName](client, ...)
end

return Network
