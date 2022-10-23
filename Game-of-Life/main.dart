import 'dart:io' as io;

import 'game_of_life.dart';

///Holds the cycle to run the game of life.
///Arguments are:
///args[0]: [gameWidth]
///args[1]: [gameHeight]
///args[2]: [amountAliveCells]
void main(List<String> args) {

  Duration waitingTime = Duration(milliseconds: 100);

  //creating new game
  GameOfLife _game = GameOfLife(
    amountAliveCells: int.parse(args[2]),
    deadCell: '⬛'.codeUnitAt(0),
    aliveCell: '⬜'.codeUnitAt(0),
    gameWidth: int.parse(args[0]),
    gameHeight: int.parse(args[1]),
    );

  //game-loop
  while (_game.amountAliveCells > 0) {
    _game.printGrid(true);
    _game.applyRules();
    io.sleep(waitingTime);
    _clearScreen();
  }
}

///Clears the current terminal-window.
void _clearScreen() {

  print(io.Process.runSync("clear", [], runInShell: true).stdout);
}
