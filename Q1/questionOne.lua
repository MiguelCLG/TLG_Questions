-- Q1 - Fix or improve the implementation of the below methods

-- @summary Define the storage key and timeout for readability
-- @param STORAGE_KEY - The storage key to use
-- @param TIMEOUT - The timeout for the addEvent call (it is better to do this if we need to keep timeouts consistent and in more methods, if we need this in several other files, we can make this a global constant in an utils file)
local STORAGE_KEY = 1000
local TIMEOUT = 1000

-- @summary Method to release player's storage value
-- @param player - The player object
local function releaseStorage(player)
	player:setStorageValue(STORAGE_KEY, -1)
end

-- @summary Method to handle player logout
-- @param player - The player object
-- @return boolean - True if the logout was successful, false otherwise
function onLogout(player)
	-- Schedule the releaseStorage function to run asynchronously after a delay
	if player:getStorageValue(STORAGE_KEY) == 1 then
		addEvent(releaseStorage, TIMEOUT, player)
		return true
	end

  print("There was an error with the logout")
	return false
end
