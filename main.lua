-- main.lua
-- Entry point for the Snake game. Handles game state, input, and LOVE callbacks.

local GameState = require("gamestate")
local Input = require("input")

local gameState
local input = Input:new()

function love.load()
    gameState = GameState:new()

    -- Bind direction keys
    input:bind("up", function()
        if gameState.current == "playing" then
            gameState.states.playing:changeDirection(0, -1)
        end
    end)

    input:bind("down", function()
        if gameState.current == "playing" then
            gameState.states.playing:changeDirection(0, 1)
        end
    end)

    input:bind("left", function()
        if gameState.current == "playing" then
            gameState.states.playing:changeDirection(-1, 0)
        end
    end)

    input:bind("right", function()
        if gameState.current == "playing" then
            gameState.states.playing:changeDirection(1, 0)
        end
    end)

    -- ENTER to switch between states or restart
    input:bind("return", function()
        if gameState.current == "menu" then
            gameState:switch("playing")
        elseif gameState.current == "playing" then
            local game = gameState.states.playing
            if game.gameOver then game:reset() end
        end
    end)
end

function love.update(dt)
    gameState:update(dt)
end

function love.draw()
    gameState:draw()
end

function love.keypressed(key)
    if key == "escape" then
        love.event.quit()
    else
        input:handleKey(key)
    end
end
