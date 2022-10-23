import 'dart:math' as math;

///Represents an intance of the game of life.
class GameOfLife {
  GameOfLife({
    required this.amountAliveCells,
    required this.deadCell,
    required this.aliveCell,
    required this.gameHeight,
    required this.gameWidth,
  }) {
    _cells = _makeGrid();
  }

  ///The amount of living cells at the current state of the game of life.
  late int amountAliveCells;
  ///Represents the grid on which the game of life takes place.
  late List<List<int>> _cells;
  ///A given integer whose value describes the respective UTF-16 character.
  final int deadCell;
  final int aliveCell;
  ///The amount of cells used in the height or in the width.
  final int gameHeight;
  final int gameWidth;


  List<List<int>> get cells => _cells;

  ///If [selectCells] is true, the UTF-16 symbol for [deadCell] and [aliveCell] are printed
  ///on the standard output. Otherwise, for each cell at the respective position its number
  ///of neighbours is printed.
  void printGrid(bool selectCells) {
    String line = '';

    for (int y = 0; y < _cells.length; y++) {
      for (int x = 0; x < _cells[0].length; x++) {
        line += selectCells ? '${String.fromCharCode(_cells[y][x])}'
                            : '${_countAliveNeighbours(x, y, _cells)}';
      }
      print('$line');
      line = '';
    }
  }

  ///Creates a randomly generated two dimensional list. This list has [gameHeight]
  ///and [gameWidth] places respectiely. The list is filled with [deadCell], but
  ///has [amountAliveCells] times [aliveCell] at random.
  List<List<int>> _makeGrid() {
    List<List<int>> initGrid = List.generate(gameHeight, growable: false, (_) {
      return List.filled(gameWidth,growable: false , deadCell);
    });
    _fillRandom(initGrid);

    return initGrid;
  }

  ///Applies the four rules of Conway's Game of Life to the set of cells.
  ///
  ///First rule: A dead cell with exactly three living neighbours is reborn in the following generation.
  ///Second rule: Living cells with fewer than two living neighbours die of loneliness in the subsequent generation.
  ///Third rule: A living cell with two or three living neighbours remains alive in the subsequent generation.
  ///Fourth rule: Living cells with more than three living neighbours die of overpopulation in the following generation.
  void applyRules() {
    //Reset the counter of living cells for the next state of the game of life.
    amountAliveCells = 0;
    //Get a copy of the current state of the cells.
    List<List<int>> tempCells = _getCopy(_cells);

    for (int y = 0; y < gameHeight; y++) {
      for (int x = 0; x < gameWidth; x++) {
        int neighbours = _countAliveNeighbours(x, y, tempCells);

        if (tempCells[y][x] == deadCell && neighbours == 3) {
          //1st rule
          _cells[y][x] = aliveCell;
        } else if (tempCells[y][x] != deadCell) {
          //update life-counter
          amountAliveCells++;

          if (neighbours < 2) {
            //2nd rule
            _cells[y][x] = deadCell;
          } else if (neighbours > 3) {
            //4th rule
            _cells[y][x] = deadCell;
          }
          //3rd rule is applied implicitly here
        }
      }
    }
  }

  ///Counts the living neighbouring cells of the cell at the given x and y coordinates.
  ///
  ///All cells in a 3x3 field around the given cell are counted as [neighbours] (the given cell excluded).
  ///The given integers [currentX] and [currentY] define the position of the current cell within [_cells].
  int _countAliveNeighbours(int currentX, int currentY, List<List<int>> cells) {

    int aliveNeighbours = 0;

    for (int i = -1; i < 2; i++) {
      for (int j = -1; j < 2; j++) {
        if (
          //Exclude the cell at the given position.
          (i != 0 || j != 0) &&
          //Checks whether the given cell is leftmost or rightmost in [_cells].
          currentX + j >= 0 && currentX + j < gameWidth &&
          //Checks whether the given cell is at the top or at the bottom in [_cells].
          currentY + i >= 0 && currentY + i < gameHeight &&
          //Verifies if the current cell is alive.
          cells[currentY + i][currentX + j] == aliveCell
          ) {
          aliveNeighbours++;
        }
      }
    }
    return aliveNeighbours;
  }

  ///Sets the integer in the given two-dimensional-list to [aliveCell] at a random
  ///position [amountAliveCells] times.
  void _fillRandom(List<List<int>> initCells) {
    //Desired amount of living cells exceeds the space in the game.
    if (amountAliveCells > (gameHeight * gameWidth)) {
      return;
    }
    int remainingCells = amountAliveCells;
    math.Random randomNumber = math.Random();

    //Fill at random position with living cells until desired amount is met.
    while (remainingCells > 0) {
      int randomX = randomNumber.nextInt(gameWidth);
      int randomY = randomNumber.nextInt(gameHeight);

      if (initCells[randomY][randomX] != aliveCell) {
        initCells[randomY][randomX] = aliveCell;
        remainingCells--;
      }
    }
  }

  ///Copies the content of the given two-dimensional list of integer and returns this copy.
  List<List<int>> _getCopy(List<List<int>> input) {
    List<List<int>> output = [];

    for (int y = 0; y < _cells.length; y++) {
      List<int> row = [];

      for (int x = 0; x < _cells[0].length; x++) {
        row.add(input[y][x]);
      }

      output.add(row);
      row = [];
    }
    return output;
  }
}

