local STEP = 10 -- the amount of units that the button will move per DELAY ms
local DELAY = 100 -- the delay for each step to take

buttonMovementWindow = nil -- the window
topBarButton = nil -- the top bar button
jumpButton = nil -- the button to be moved
movementEvent = nil -- event to be scheduled to move the button continuously

function init()
  connect(g_game, { onGameEnd = destroy })

  -- registering the window
  buttonMovementWindow = g_ui.displayUI('button_movement', modules.game_interface.getRightPanel())
  buttonMovementWindow:hide()

  -- registering the top bar button (used spelllist as the icon, but could be any other one)
  topBarButton = modules.client_topmenu.addRightGameToggleButton('topBarButton', tr(''), '/images/topbuttons/spelllist', toggle)
  topBarButton:setOn(false)

  -- registering the jump button
  jumpButton = buttonMovementWindow:getChildById('JumpButton');
  jumpButton:setOn(false)
end

function terminate()
  disconnect(g_game, { onGameEnd = destroy })
  destroy()
end

function destroy()
  if buttonMovementWindow then
    buttonMovementWindow:destroy()
    topBarButton:destroy()
    jumpButton:destroy()
    topBarButton = nil
    buttonMovementWindow = nil
    jumpButton = nil
  end
  removeEvent(movementEvent)
end

-- function to move the button inside of the window
function moveX()
  -- getting the window bounds in the x axis so that the button is contained within the window, no matter the size
  local windowXBounds = buttonMovementWindow:getWidth() - buttonMovementWindow:getPaddingLeft() - buttonMovementWindow:getPaddingRight() - jumpButton:getWidth()

  if jumpButton:getMarginRight() >= windowXBounds then
    resetButtonPosition()
  else
    jumpButton:setMarginRight(jumpButton:getMarginRight() + STEP)
    movementEvent = scheduleEvent(moveX, DELAY) -- scheduling an event recursively to move the button continuously with a delay of 100 ms (avoiding stack overflows)
  end
end

-- function to randomize the top margin and set the margin right to 0
function resetButtonPosition()
  -- getting the window bounds in the y axis so that the button is contained within the window
  local windowYBounds = buttonMovementWindow:getHeight() - buttonMovementWindow:getPaddingTop() - buttonMovementWindow:getPaddingBottom() - jumpButton:getHeight()
  local rand = math.random(0, windowYBounds);

  -- setting the correct margins
  jumpButton:setMarginTop(rand)
  jumpButton:setMarginRight(0)

  -- it is important to remove the event before scheduling another, otherwise there would be multiple of the same event
  removeEvent(movementEvent)
  movementEvent = scheduleEvent(moveX, DELAY)
end

-- toggles the window open and start/ends the recursion of the button movement
function toggle()
  if topBarButton:isOn() then
    topBarButton:setOn(false)
    buttonMovementWindow:hide()
    removeEvent(movementEvent)
  else
    topBarButton:setOn(true)
    buttonMovementWindow:show()
    buttonMovementWindow:raise()
    buttonMovementWindow:focus()
    resetButtonPosition()
  end
end
