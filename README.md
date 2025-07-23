# Snake Game (LOVE2D)

A simple Snake game implemented in Lua using the LOVE2D framework.

## Features

- Classic snake gameplay
- Score and high score tracking
- Simple menu and game over screens

## How to Run

1. [Download and install LOVE2D](https://love2d.org/).
2. Download or clone this repository.
3. Run the game by dragging the project folder onto the LOVE2D executable, or run from terminal:

   ```
   love .
   ```

## File Structure

- `main.lua` - Entry point, handles game state and input
- `gamestate.lua` - Manages game states (menu, playing)
- `snake_game.lua` - Main game logic (snake movement, collision, drawing)
- `entity.lua` - Simple entity/component system
- `vector2.lua` - 2D vector utility
- `input.lua` - Keyboard input handling
- `highscore.lua` - High score saving/loading
- `events.lua` - Simple event system
- `states/menu_state.lua` - Menu state logic

## Controls

- Arrow keys: Move the snake
- Enter: Start or restart the game
- Escape: Quit the game