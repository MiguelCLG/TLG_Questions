-- Q3 - Fix or improve the name and the implementation of the below method

-- @summary Remove a player from the party
-- @param playerId - The player id
-- @param memberName - The party member name to be removed from party
function removePartyMember(playerId, memberName)

  -- Get the player party
  -- Here I am assuming that Player() has an override of some kind to search for both IDs and/or Names
  -- Also assuming that memberNames are unique,
  -- if not, then I would change the parameter memberName to memberID
  -- or create a method to find a player by name
	player = Player(playerId)
	local party = player:getParty()

  -- it is better to assign the memberName here as I assume that Player(memberName) is going to run a search query,
  -- therefore we can run it only once making the following loop much more efficient
  local partyMember = Player(memberName)

  -- loop through the party members in a key value pair
  -- once we find the member, we remove it and break out of the loop
	for k, v in pairs(party:getMembers()) do
		if v == partyMember then
			party:removeMember(partyMember)
      break
		end
	end
end
