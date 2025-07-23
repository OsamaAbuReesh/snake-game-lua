-- menu_state.lua
-- Handles the menu state display.

local MenuState = {}

function MenuState:update(dt)
    -- No updates needed for menu state
end

function MenuState:draw()
    love.graphics.printf("Press Enter to Start", 0, love.graphics.getHeight()/2, love.graphics.getWidth(), "center")
end

return MenuState
