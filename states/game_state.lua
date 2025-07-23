local SnakeGame = require("snake_game")

local GameState = {}
GameState.__index = GameState

function GameState:new()
    local game = SnakeGame:new()
    return setmetatable({game = game}, GameState)
end

function GameState:update(dt)
    self.game:update(dt)
end

function GameState:draw()
    self.game:draw()
end

function GameState:changeDirection(dx, dy)
    self.game:changeDirection(dx, dy)
end

function GameState:reset()
    self.game:reset()
end

return GameState:new()
