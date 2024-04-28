# Implementation basis

Unfortunately I did not have time to try and implement the dash feature, but here's how I would try and implement it.

- Get the character's look at direction (this would be the direction of the dash)
- Implement a keybind to trigger the dash function
- Set the number of movement units that the dash would take (this would probably be the number of "shades" as well)
- Implement a function similar to what we used in question 7 with `scheduleEvent()` (but with a lower delay) to move the character.
- In regards to the "shades", I would implement it like this:
  - duplicate the character sprite up to the number of units to be moved
  - bind them and adjust the position of each sprite backwards in relation to the previous one.
  - apply opacity to the duplicated sprites using the shader class.
  - release the shaders, destroying the duplicated sprites

This implementation would most likely use the `g_graphics` module found in the `luafunctions.cpp` file which are connected to the `Graphics` class. I would also need to create a shaders file that would decrease the opacity of each sprite.

Another solution would be to have a shader's file do most of the work and duplicate the sprites (probably by duplicating the vertices of the original sprite) while applying opacity to each. The implementation of the dash would only need to do the movement and add the shader to the character.
