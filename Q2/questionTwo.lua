-- Q2 - Fix or improve the implementation of the below method

-- @summary this method is supposed to print names of all guilds that have less than memberCount max members
-- @param memberCount - max number of members in guild
function printSmallGuildNames(memberCount)
	-- Verify that memberCount is a positive number
	if memberCount <= 0 then
		print("ERROR: memberCount is not a positive number")
		return
	end

	-- create query, using string format in order to avoid SQL injections
	local selectGuildQuery = string.format("SELECT name FROM guilds WHERE max_members < %d;", memberCount)
	local resultId = db.storeQuery(selectGuildQuery)

	-- check if the query result is valid
	if not resultId then
		print("ERROR: guilds not found")
	end

  -- go through the list of guilds and print their names for each iteration until there are no more guilds in the result
	repeat
		local guildName = result.getString(resultId, "name")

		if guildName then
			print(guildName)
		end
	until not result.next(resultId)

	-- preventing memory leaks by freeing the result
	result.free(resultId)
end


