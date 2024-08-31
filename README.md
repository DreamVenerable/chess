# CLI Chess Game

Welcome to the CLI Chess Game, a command-line interface chess game written in Ruby. This project offers a traditional chess experience along with some exciting twists.

Progress: Game is playable, everything is funcional, it's missing En Passant & ability to save game to reach the minimum TOP requirement for completion.

Game modes haven't been implemented yet!

## Features

- **2-Player Mode**
- **Five Game Modes**: Choose from various game modes to keep the game fresh and exciting:
  - **Normal**: Standard chess rules apply.
  - **3-Check**: Win by placing your opponent's king in check three times.
  - **Randomize**: Pieces are placed randomly on the board at the start of the game.
  - **King of the Hill**: First to reach one of the 4 center squares with thier king wins.
  - **Dark Chess (Fog of War)**: Only see the opponent's pieces when they are in your line of sight.

## What I've Learnt
This project helped me in OPP tremendously, it showed me where I was lacking (somethings that I thought I had down) and taught me new things!

It also made my brain gears turn trying to come up with ways to implement some of the rules/features!

## Installation

1.  **Clone the repository:**
    ```
    git clone https://github.com/DreamVenerable/chess.git
    cd chess
    ```

2.  **Install dependencies:**
    Ensure you have Ruby installed on your machine. Then, install any necessary gems:
    ```
    bundle install
    ```

3.  **Run the game:**
    Start the game by running the following command:
    ```
    ruby bin/main.rb
    ```

## How to Play

1. **Start the Game**: Upon running the game, you will be prompted to select a game mode.
2. **Game Modes**: Choose from the five available game modes
3. **Move Pieces**: Players take turns moving their pieces. Enter your moves in standard chess notation (e.g., `e2e4`).
4. **Winning**: The win condition varies depending on the selected game mode. In the Normal mode, the game ends with checkmate or stalemate.

## Project Structure

- **`bin/`**: Contains `main.rb` which is the entry point of the game.
- **`lib/`**: Contains the main game logic, including classes for the board, pieces, and game modes.

## Future Enhancements

- **AI Opponent**: Implement a computer-controlled opponent for solo play.

## Contributing

Contributions are welcome! If you have ideas for new features or improvements, feel free to open an issue or submit a pull request.

