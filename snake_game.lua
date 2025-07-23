-- snake_game.lua
-- Main Snake game logic, including snake movement, collision, and drawing.

local HighScore = require("highscore")
local Entity = require("entity")

local SnakeGame = {}
SnakeGame.__index = SnakeGame

local function createSnakeSegment(x, y)
    local segment = Entity:new()
    segment:addComponent("position", {x = x, y = y})
    segment:addComponent("renderer", {color = {0, 1, 0}, size = 20})
    return segment
end

function SnakeGame:new()
    local game = {
        snake = { createSnakeSegment(10, 10) },
        direction = {dx = 1, dy = 0},
        food = {x = 15, y = 15},
        gridSize = 20,
        score = 0,
        highScore = HighScore:load(),
        timer = 0,
        speed = 0.2,
        gameOver = false
    }
    return setmetatable(game, SnakeGame)
end

function SnakeGame:update(dt)
    if self.gameOver then return end
    self.timer = self.timer + dt
    if self.timer >= self.speed then
        self.timer = 0
        self:moveSnake()
        self:checkCollision()
    end
end

function SnakeGame:moveSnake()
    local head = self.snake[1]:getComponent("position")
    local newHeadX = head.x + self.direction.dx
    local newHeadY = head.y + self.direction.dy

    table.insert(self.snake, 1, createSnakeSegment(newHeadX, newHeadY))

    if newHeadX == self.food.x and newHeadY == self.food.y then
        self.score = self.score + 1
        self:spawnFood()
    else
        table.remove(self.snake)
    end
end

function SnakeGame:changeDirection(dx, dy)
    if (dx == -self.direction.dx and dy == -self.direction.dy) then return end
    self.direction.dx = dx
    self.direction.dy = dy
end

function SnakeGame:spawnFood()
    self.food.x = math.random(0, love.graphics.getWidth() / self.gridSize - 1)
    self.food.y = math.random(0, love.graphics.getHeight() / self.gridSize - 1)
end

function SnakeGame:checkCollision()
    local head = self.snake[1]:getComponent("position")
    if head.x < 0 or head.x >= love.graphics.getWidth() / self.gridSize or
       head.y < 0 or head.y >= love.graphics.getHeight() / self.gridSize then
        self:gameOverCheck()
        return
    end
    for i = 2, #self.snake do
        local segmentPos = self.snake[i]:getComponent("position")
        if head.x == segmentPos.x and head.y == segmentPos.y then
            self:gameOverCheck()
            return
        end
    end
end

function SnakeGame:gameOverCheck()
    self.gameOver = true
    if self.score > self.highScore then
        self.highScore = self.score
        HighScore:save(self.highScore)
    end
end

function SnakeGame:reset()
    self.snake = { createSnakeSegment(10, 10) }
    self.direction = {dx = 1, dy = 0}
    self.food = {x = 15, y = 15}
    self.score = 0
    self.gameOver = false
end

function SnakeGame:draw()
    love.graphics.setColor(1, 0, 0)
    love.graphics.rectangle("fill", self.food.x * self.gridSize, self.food.y * self.gridSize, self.gridSize, self.gridSize)

    for _, segment in ipairs(self.snake) do
        local pos = segment:getComponent("position")
        local renderer = segment:getComponent("renderer")
        love.graphics.setColor(renderer.color)
        love.graphics.rectangle("fill", pos.x * self.gridSize, pos.y * self.gridSize, renderer.size, renderer.size)
    end

    love.graphics.setColor(1, 1, 1)
    love.graphics.print("Score: " .. self.score .. " | High Score: " .. self.highScore, 10, 10)

    if self.gameOver then
        love.graphics.printf("Game Over! Press Enter to Restart", 0, love.graphics.getHeight()/2, love.graphics.getWidth(), "center")
    end
end

return SnakeGame
