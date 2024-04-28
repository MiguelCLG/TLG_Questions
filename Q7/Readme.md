# Implementation and difficulties

## Server side

- There is no need for any server side implementation

## Client Side

Created a new module called `game_button_movement` inside the modules folder of the client. Followed the repository's wiki, as they have the base to create a new module.

This module has 3 files:

- `button_movement.otmod` - registers the new module
- `button_movement.otui` - registers the UI components style used in the module and their events (e.g `onClick()`, `onHover()`, etc..)
- `button_movement.lua` - the implementation of the module

The implementation does need an `init()` function that connects the game and registers the components that are going to be used (e.g Main Window, the UI window button (up-right corner), and the Jump button).

It also needs a `terminate()` function to disconnect the game and call the `destroy()` function to destroy the components, so that they don't linger when the module is unloaded.

At first, I tried finding a tick/update function (like Unreal or Unity) to do the movement, but there seems to be none, therefore I used the `ScheduleEvent()` function to keep the `moveX()` looping within a certain delay, reseting once it reaches the final destination.

There were several ways to move the button, I used the margins to keep it moving, but I also could have used the button's position.

We can find the UI function calls in the `luafunctions.cpp` file, which I used as "documentation". In here we can bind c++ functions, implement them in their respective classes and use them in lua.

There are 2 main function in the implementation:

- `moveX()` - calculates the window size and moves the button by `STEP` amount, then it will add an event to call itself recursively by `DELAY` delay. Once it reaches the window's bounds, it calls `resetButtonPosition()`.
- `resetButtonPosition()` - since we are using margins to move, this resets the button's marginRight to 0 and randomizes the top margin within the window's bounds. Also removes an already existing event and sets another to keep the button moving. This function is called in both the `moveX()` function and `onClick()` of the button (set in the `otui` file).
