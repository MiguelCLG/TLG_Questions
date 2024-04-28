# Implementation and difficulties

We need to modify and add a few files in both the server and the client.

## Server side

In the server case, we need to add 3 files:

- `data/spells/lib/spells.lua` - this file already exists and we just need to add the area of effect as a 2D integer matrix, that takes 0, 1, 2 and 3 as inputs:
  - 0 - no effect
  - 1 - effect
  - 2 - center, no effect
  - 3 - center, w/ effect
- `data/spells/spells.xml` - this file already exists where we need to add a new role for the spell with the correct properties (e.g Attack spell needs to be inside it's own group and).
- `data/spells/scripts/attack/tempest.lua` - the new spell file called `tempest` where we set the implementation parameters.

- Tried a few different shapes but couldn't get it to work as intended, technically it should work with AREA_CROSS3X3, but it seems to do the same as AREA_CROSS2X2, the closest I got, was when I created AREA_CROSS_ALTERNATE_3X3, where the correct sprites would show but the center position is wrong.

- Debugged the server and it seems to be working as intended, at least the area of effect is working (damage to creatures is being outputed), but the spell visuals are not.

- There might be a trick to it, but since there is no official documentation, I would have to implement a new formula to get it to work.

- The formula would be to loop through the matrix and output the sprite animation for the spell (`CONST_ME_ICETORNADO`) in the tiles marked as `1`, keeping the `2` as the center.

## Client side

- We just need to add the spell to the spell list in this file `/modules/gamelib/spells.lua`, by specifying it in the `SpellInfo` and the `SpellIcon` properties.
