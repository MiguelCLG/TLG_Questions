// Q4 - Assume all method calls work fine. Fix the memory leak issue in below method

/**
 * @summary Adds an item to a player's inventory.
 * @param recipient The name of the player to add the item to.
 * @param itemId The ID of the item to add.
 */
void Game::addItemToPlayer(const std::string &recipient, uint16_t itemId)
{
  Player *player = g_game.getPlayerByName(recipient);

  if (!player)
  {
    // this might cause memory leaks since we are dynamically allocating the memory,
    // therefore, only in the case that we create a new object, we have to free it
    player = new Player(nullptr);
    if (!IOLoginData::loadPlayerByName(player, recipient))
    {
      // if we can't load the player by their name, then it doesn't exist,
      // we then free the new player object created in the previous instruction and exit the method.
      delete player;
      return;
    }
  }

  Item *item = Item::CreateItem(itemId);

  if (!item)
  {
    // If item creation failed, delete the player object (if it's newly created)
    if (!g_game.getPlayerByName(recipient)) // Check if player is newly created
    {
      delete player; // free the memory
    }
    return;
  }

  g_game.internalAddItem(player->getInbox(), item, INDEX_WHEREEVER, FLAG_NOLIMIT);

  if (player->isOffline())
  {
    IOLoginData::savePlayer(player);
  }
}
