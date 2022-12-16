import 'dart:math';

void main() {
  final int part1Result = part1();
  final int part2Result = part2();
  
  assert(part1Result == 719);
  assert(part2Result == 23390);

  print('part1: $part1Result');
  print('part2: $part2Result');
}

class Tile {}
class Air extends Tile {}
class Rock extends Tile {}
class Sand extends Tile {}

int part1() {
  final List<List<Tile>> tiles = parseInput(puzzleInput());

  int sandRested = 0;
  bool runSimulation = true;
  while (runSimulation) {
    bool isResting = false;
    int currentY = 0;
    int currentX = 499;
    while (!isResting) {
      if (currentY == tiles.length - 1) {
        runSimulation = false;
        break;
      }
      Tile nextTile = tiles[currentY + 1][currentX];
      if (nextTile is Air) {
        currentY++;
        continue;
      } 
      Tile nextTileLeft = tiles[currentY + 1][currentX - 1];
      if (nextTileLeft is Air) {
        currentY++;
        currentX--;
        continue;
      } 
      Tile nextTileRight = tiles[currentY + 1][currentX + 1];
      if (nextTileRight is Air) {
        currentY++;
        currentX++;
        continue;
      }
      tiles[currentY][currentX] = Sand();
      isResting = true;
      sandRested++;
    }
  }

  return sandRested;
}

int part2() {
  final List<List<Tile>> tiles = parseInput(puzzleInput());
  tiles.add(List.generate(1000, (index) => Air()));
  tiles.add(List.generate(1000, (index) => Rock()));

  int sandRested = 0;
  bool runSimulation = true;
  while (runSimulation) {
    bool isResting = false;
    int currentY = 0;
    int currentX = 499;
    while (!isResting) {
      Tile nextTile = tiles[currentY + 1][currentX];
      if (nextTile is Air) {
        currentY++;
        continue;
      } 
      Tile nextTileLeft = tiles[currentY + 1][currentX - 1];
      if (nextTileLeft is Air) {
        currentY++;
        currentX--;
        continue;
      } 
      Tile nextTileRight = tiles[currentY + 1][currentX + 1];
      if (nextTileRight is Air) {
        currentY++;
        currentX++;
        continue;
      }
      tiles[currentY][currentX] = Sand();
      isResting = true;
      sandRested++;
      if (currentY == 0) {
        runSimulation = false;
        break;
      }
    }
  }

  return sandRested;
}

List<List<Tile>> parseInput(String input) {
  List<int> findMaxCoords() {
    int maxX = 0;
    int maxY = 0;
    for (var line in input.split('\n')) {
      for (var point in line.split(' -> ')) {
        List<String> coords = point.split(',');
        int x = int.parse(coords[0]);
        int y = int.parse(coords[1]);
        if (x > maxX) maxX = x;
        if (y > maxY) maxY = y;
      }
    }

    return [maxX, maxY];
  }

  final List<List<Tile>> tiles = [];
  List<int> maxCoords = findMaxCoords();
  for (int y = 0; y <= maxCoords[1]; y++) {
    tiles.add([]);
    for (int x = 0; x < 1000; x++) {
      tiles[y].add(Air());
    }
  }

  for (var line in input.split('\n')) {
    List<String> points = line.split(' -> ');
    for (int p = 0; p < points.length - 1; p++) {
      String point = points[p];
      String nextPoint = points[p + 1];
      List<String> coords = point.split(',');
      List<String> nextCoords = nextPoint.split(',');
      int currentX = int.parse(coords[0]) - 1;
      int currentY = int.parse(coords[1]);
      int nextX = int.parse(nextCoords[0]) - 1;
      int nextY = int.parse(nextCoords[1]);
      int startX = min(currentX, nextX);
      int startY = min(currentY, nextY);
      int endX = max(currentX, nextX);
      int endY = max(currentY, nextY);

      for (int y = startY; y <= startY + (endY - startY).abs(); y++) {
        for (int x = startX; x <= startX + (endX - startX).abs(); x++) {
          tiles[y][x] = Rock();
        }
      }
    }
  }

  return tiles;
}

String exampleInput() {
  return '''
498,4 -> 498,6 -> 496,6
503,4 -> 502,4 -> 502,9 -> 494,9''';
}

String puzzleInput() {
  return '''
514,127 -> 518,127
488,148 -> 488,144 -> 488,148 -> 490,148 -> 490,141 -> 490,148 -> 492,148 -> 492,144 -> 492,148 -> 494,148 -> 494,145 -> 494,148 -> 496,148 -> 496,139 -> 496,148 -> 498,148 -> 498,145 -> 498,148 -> 500,148 -> 500,141 -> 500,148 -> 502,148 -> 502,143 -> 502,148 -> 504,148 -> 504,145 -> 504,148
508,60 -> 508,58 -> 508,60 -> 510,60 -> 510,55 -> 510,60 -> 512,60 -> 512,51 -> 512,60 -> 514,60 -> 514,59 -> 514,60 -> 516,60 -> 516,58 -> 516,60 -> 518,60 -> 518,50 -> 518,60 -> 520,60 -> 520,58 -> 520,60 -> 522,60 -> 522,52 -> 522,60 -> 524,60 -> 524,54 -> 524,60
488,148 -> 488,144 -> 488,148 -> 490,148 -> 490,141 -> 490,148 -> 492,148 -> 492,144 -> 492,148 -> 494,148 -> 494,145 -> 494,148 -> 496,148 -> 496,139 -> 496,148 -> 498,148 -> 498,145 -> 498,148 -> 500,148 -> 500,141 -> 500,148 -> 502,148 -> 502,143 -> 502,148 -> 504,148 -> 504,145 -> 504,148
508,60 -> 508,58 -> 508,60 -> 510,60 -> 510,55 -> 510,60 -> 512,60 -> 512,51 -> 512,60 -> 514,60 -> 514,59 -> 514,60 -> 516,60 -> 516,58 -> 516,60 -> 518,60 -> 518,50 -> 518,60 -> 520,60 -> 520,58 -> 520,60 -> 522,60 -> 522,52 -> 522,60 -> 524,60 -> 524,54 -> 524,60
508,60 -> 508,58 -> 508,60 -> 510,60 -> 510,55 -> 510,60 -> 512,60 -> 512,51 -> 512,60 -> 514,60 -> 514,59 -> 514,60 -> 516,60 -> 516,58 -> 516,60 -> 518,60 -> 518,50 -> 518,60 -> 520,60 -> 520,58 -> 520,60 -> 522,60 -> 522,52 -> 522,60 -> 524,60 -> 524,54 -> 524,60
490,23 -> 490,17 -> 490,23 -> 492,23 -> 492,22 -> 492,23 -> 494,23 -> 494,16 -> 494,23 -> 496,23 -> 496,17 -> 496,23 -> 498,23 -> 498,18 -> 498,23 -> 500,23 -> 500,13 -> 500,23 -> 502,23 -> 502,13 -> 502,23 -> 504,23 -> 504,13 -> 504,23 -> 506,23 -> 506,15 -> 506,23 -> 508,23 -> 508,22 -> 508,23
520,114 -> 520,117 -> 514,117 -> 514,122 -> 533,122 -> 533,117 -> 525,117 -> 525,114
490,23 -> 490,17 -> 490,23 -> 492,23 -> 492,22 -> 492,23 -> 494,23 -> 494,16 -> 494,23 -> 496,23 -> 496,17 -> 496,23 -> 498,23 -> 498,18 -> 498,23 -> 500,23 -> 500,13 -> 500,23 -> 502,23 -> 502,13 -> 502,23 -> 504,23 -> 504,13 -> 504,23 -> 506,23 -> 506,15 -> 506,23 -> 508,23 -> 508,22 -> 508,23
518,47 -> 525,47 -> 525,46
523,73 -> 523,68 -> 523,73 -> 525,73 -> 525,72 -> 525,73 -> 527,73 -> 527,69 -> 527,73
503,157 -> 507,157
523,73 -> 523,68 -> 523,73 -> 525,73 -> 525,72 -> 525,73 -> 527,73 -> 527,69 -> 527,73
517,129 -> 521,129
525,86 -> 529,86
522,84 -> 526,84
523,73 -> 523,68 -> 523,73 -> 525,73 -> 525,72 -> 525,73 -> 527,73 -> 527,69 -> 527,73
520,114 -> 520,117 -> 514,117 -> 514,122 -> 533,122 -> 533,117 -> 525,117 -> 525,114
490,23 -> 490,17 -> 490,23 -> 492,23 -> 492,22 -> 492,23 -> 494,23 -> 494,16 -> 494,23 -> 496,23 -> 496,17 -> 496,23 -> 498,23 -> 498,18 -> 498,23 -> 500,23 -> 500,13 -> 500,23 -> 502,23 -> 502,13 -> 502,23 -> 504,23 -> 504,13 -> 504,23 -> 506,23 -> 506,15 -> 506,23 -> 508,23 -> 508,22 -> 508,23
511,36 -> 511,40 -> 503,40 -> 503,43 -> 519,43 -> 519,40 -> 515,40 -> 515,36
523,73 -> 523,68 -> 523,73 -> 525,73 -> 525,72 -> 525,73 -> 527,73 -> 527,69 -> 527,73
508,60 -> 508,58 -> 508,60 -> 510,60 -> 510,55 -> 510,60 -> 512,60 -> 512,51 -> 512,60 -> 514,60 -> 514,59 -> 514,60 -> 516,60 -> 516,58 -> 516,60 -> 518,60 -> 518,50 -> 518,60 -> 520,60 -> 520,58 -> 520,60 -> 522,60 -> 522,52 -> 522,60 -> 524,60 -> 524,54 -> 524,60
530,111 -> 535,111
537,94 -> 537,98 -> 536,98 -> 536,102 -> 542,102 -> 542,98 -> 539,98 -> 539,94
520,131 -> 524,131
508,60 -> 508,58 -> 508,60 -> 510,60 -> 510,55 -> 510,60 -> 512,60 -> 512,51 -> 512,60 -> 514,60 -> 514,59 -> 514,60 -> 516,60 -> 516,58 -> 516,60 -> 518,60 -> 518,50 -> 518,60 -> 520,60 -> 520,58 -> 520,60 -> 522,60 -> 522,52 -> 522,60 -> 524,60 -> 524,54 -> 524,60
490,23 -> 490,17 -> 490,23 -> 492,23 -> 492,22 -> 492,23 -> 494,23 -> 494,16 -> 494,23 -> 496,23 -> 496,17 -> 496,23 -> 498,23 -> 498,18 -> 498,23 -> 500,23 -> 500,13 -> 500,23 -> 502,23 -> 502,13 -> 502,23 -> 504,23 -> 504,13 -> 504,23 -> 506,23 -> 506,15 -> 506,23 -> 508,23 -> 508,22 -> 508,23
528,84 -> 532,84
511,129 -> 515,129
520,114 -> 520,117 -> 514,117 -> 514,122 -> 533,122 -> 533,117 -> 525,117 -> 525,114
488,148 -> 488,144 -> 488,148 -> 490,148 -> 490,141 -> 490,148 -> 492,148 -> 492,144 -> 492,148 -> 494,148 -> 494,145 -> 494,148 -> 496,148 -> 496,139 -> 496,148 -> 498,148 -> 498,145 -> 498,148 -> 500,148 -> 500,141 -> 500,148 -> 502,148 -> 502,143 -> 502,148 -> 504,148 -> 504,145 -> 504,148
490,23 -> 490,17 -> 490,23 -> 492,23 -> 492,22 -> 492,23 -> 494,23 -> 494,16 -> 494,23 -> 496,23 -> 496,17 -> 496,23 -> 498,23 -> 498,18 -> 498,23 -> 500,23 -> 500,13 -> 500,23 -> 502,23 -> 502,13 -> 502,23 -> 504,23 -> 504,13 -> 504,23 -> 506,23 -> 506,15 -> 506,23 -> 508,23 -> 508,22 -> 508,23
490,23 -> 490,17 -> 490,23 -> 492,23 -> 492,22 -> 492,23 -> 494,23 -> 494,16 -> 494,23 -> 496,23 -> 496,17 -> 496,23 -> 498,23 -> 498,18 -> 498,23 -> 500,23 -> 500,13 -> 500,23 -> 502,23 -> 502,13 -> 502,23 -> 504,23 -> 504,13 -> 504,23 -> 506,23 -> 506,15 -> 506,23 -> 508,23 -> 508,22 -> 508,23
488,148 -> 488,144 -> 488,148 -> 490,148 -> 490,141 -> 490,148 -> 492,148 -> 492,144 -> 492,148 -> 494,148 -> 494,145 -> 494,148 -> 496,148 -> 496,139 -> 496,148 -> 498,148 -> 498,145 -> 498,148 -> 500,148 -> 500,141 -> 500,148 -> 502,148 -> 502,143 -> 502,148 -> 504,148 -> 504,145 -> 504,148
539,90 -> 539,91 -> 552,91 -> 552,90
520,114 -> 520,117 -> 514,117 -> 514,122 -> 533,122 -> 533,117 -> 525,117 -> 525,114
508,60 -> 508,58 -> 508,60 -> 510,60 -> 510,55 -> 510,60 -> 512,60 -> 512,51 -> 512,60 -> 514,60 -> 514,59 -> 514,60 -> 516,60 -> 516,58 -> 516,60 -> 518,60 -> 518,50 -> 518,60 -> 520,60 -> 520,58 -> 520,60 -> 522,60 -> 522,52 -> 522,60 -> 524,60 -> 524,54 -> 524,60
490,23 -> 490,17 -> 490,23 -> 492,23 -> 492,22 -> 492,23 -> 494,23 -> 494,16 -> 494,23 -> 496,23 -> 496,17 -> 496,23 -> 498,23 -> 498,18 -> 498,23 -> 500,23 -> 500,13 -> 500,23 -> 502,23 -> 502,13 -> 502,23 -> 504,23 -> 504,13 -> 504,23 -> 506,23 -> 506,15 -> 506,23 -> 508,23 -> 508,22 -> 508,23
508,127 -> 512,127
507,26 -> 507,28 -> 504,28 -> 504,33 -> 511,33 -> 511,28 -> 510,28 -> 510,26
537,94 -> 537,98 -> 536,98 -> 536,102 -> 542,102 -> 542,98 -> 539,98 -> 539,94
508,60 -> 508,58 -> 508,60 -> 510,60 -> 510,55 -> 510,60 -> 512,60 -> 512,51 -> 512,60 -> 514,60 -> 514,59 -> 514,60 -> 516,60 -> 516,58 -> 516,60 -> 518,60 -> 518,50 -> 518,60 -> 520,60 -> 520,58 -> 520,60 -> 522,60 -> 522,52 -> 522,60 -> 524,60 -> 524,54 -> 524,60
520,114 -> 520,117 -> 514,117 -> 514,122 -> 533,122 -> 533,117 -> 525,117 -> 525,114
490,23 -> 490,17 -> 490,23 -> 492,23 -> 492,22 -> 492,23 -> 494,23 -> 494,16 -> 494,23 -> 496,23 -> 496,17 -> 496,23 -> 498,23 -> 498,18 -> 498,23 -> 500,23 -> 500,13 -> 500,23 -> 502,23 -> 502,13 -> 502,23 -> 504,23 -> 504,13 -> 504,23 -> 506,23 -> 506,15 -> 506,23 -> 508,23 -> 508,22 -> 508,23
490,23 -> 490,17 -> 490,23 -> 492,23 -> 492,22 -> 492,23 -> 494,23 -> 494,16 -> 494,23 -> 496,23 -> 496,17 -> 496,23 -> 498,23 -> 498,18 -> 498,23 -> 500,23 -> 500,13 -> 500,23 -> 502,23 -> 502,13 -> 502,23 -> 504,23 -> 504,13 -> 504,23 -> 506,23 -> 506,15 -> 506,23 -> 508,23 -> 508,22 -> 508,23
490,23 -> 490,17 -> 490,23 -> 492,23 -> 492,22 -> 492,23 -> 494,23 -> 494,16 -> 494,23 -> 496,23 -> 496,17 -> 496,23 -> 498,23 -> 498,18 -> 498,23 -> 500,23 -> 500,13 -> 500,23 -> 502,23 -> 502,13 -> 502,23 -> 504,23 -> 504,13 -> 504,23 -> 506,23 -> 506,15 -> 506,23 -> 508,23 -> 508,22 -> 508,23
508,60 -> 508,58 -> 508,60 -> 510,60 -> 510,55 -> 510,60 -> 512,60 -> 512,51 -> 512,60 -> 514,60 -> 514,59 -> 514,60 -> 516,60 -> 516,58 -> 516,60 -> 518,60 -> 518,50 -> 518,60 -> 520,60 -> 520,58 -> 520,60 -> 522,60 -> 522,52 -> 522,60 -> 524,60 -> 524,54 -> 524,60
490,23 -> 490,17 -> 490,23 -> 492,23 -> 492,22 -> 492,23 -> 494,23 -> 494,16 -> 494,23 -> 496,23 -> 496,17 -> 496,23 -> 498,23 -> 498,18 -> 498,23 -> 500,23 -> 500,13 -> 500,23 -> 502,23 -> 502,13 -> 502,23 -> 504,23 -> 504,13 -> 504,23 -> 506,23 -> 506,15 -> 506,23 -> 508,23 -> 508,22 -> 508,23
490,23 -> 490,17 -> 490,23 -> 492,23 -> 492,22 -> 492,23 -> 494,23 -> 494,16 -> 494,23 -> 496,23 -> 496,17 -> 496,23 -> 498,23 -> 498,18 -> 498,23 -> 500,23 -> 500,13 -> 500,23 -> 502,23 -> 502,13 -> 502,23 -> 504,23 -> 504,13 -> 504,23 -> 506,23 -> 506,15 -> 506,23 -> 508,23 -> 508,22 -> 508,23
539,90 -> 539,91 -> 552,91 -> 552,90
511,125 -> 515,125
514,131 -> 518,131
490,23 -> 490,17 -> 490,23 -> 492,23 -> 492,22 -> 492,23 -> 494,23 -> 494,16 -> 494,23 -> 496,23 -> 496,17 -> 496,23 -> 498,23 -> 498,18 -> 498,23 -> 500,23 -> 500,13 -> 500,23 -> 502,23 -> 502,13 -> 502,23 -> 504,23 -> 504,13 -> 504,23 -> 506,23 -> 506,15 -> 506,23 -> 508,23 -> 508,22 -> 508,23
507,26 -> 507,28 -> 504,28 -> 504,33 -> 511,33 -> 511,28 -> 510,28 -> 510,26
511,36 -> 511,40 -> 503,40 -> 503,43 -> 519,43 -> 519,40 -> 515,40 -> 515,36
526,109 -> 531,109
490,23 -> 490,17 -> 490,23 -> 492,23 -> 492,22 -> 492,23 -> 494,23 -> 494,16 -> 494,23 -> 496,23 -> 496,17 -> 496,23 -> 498,23 -> 498,18 -> 498,23 -> 500,23 -> 500,13 -> 500,23 -> 502,23 -> 502,13 -> 502,23 -> 504,23 -> 504,13 -> 504,23 -> 506,23 -> 506,15 -> 506,23 -> 508,23 -> 508,22 -> 508,23
497,157 -> 501,157
539,90 -> 539,91 -> 552,91 -> 552,90
523,73 -> 523,68 -> 523,73 -> 525,73 -> 525,72 -> 525,73 -> 527,73 -> 527,69 -> 527,73
488,148 -> 488,144 -> 488,148 -> 490,148 -> 490,141 -> 490,148 -> 492,148 -> 492,144 -> 492,148 -> 494,148 -> 494,145 -> 494,148 -> 496,148 -> 496,139 -> 496,148 -> 498,148 -> 498,145 -> 498,148 -> 500,148 -> 500,141 -> 500,148 -> 502,148 -> 502,143 -> 502,148 -> 504,148 -> 504,145 -> 504,148
498,134 -> 498,135 -> 509,135 -> 509,134
503,151 -> 507,151
531,86 -> 535,86
488,148 -> 488,144 -> 488,148 -> 490,148 -> 490,141 -> 490,148 -> 492,148 -> 492,144 -> 492,148 -> 494,148 -> 494,145 -> 494,148 -> 496,148 -> 496,139 -> 496,148 -> 498,148 -> 498,145 -> 498,148 -> 500,148 -> 500,141 -> 500,148 -> 502,148 -> 502,143 -> 502,148 -> 504,148 -> 504,145 -> 504,148
498,134 -> 498,135 -> 509,135 -> 509,134
488,148 -> 488,144 -> 488,148 -> 490,148 -> 490,141 -> 490,148 -> 492,148 -> 492,144 -> 492,148 -> 494,148 -> 494,145 -> 494,148 -> 496,148 -> 496,139 -> 496,148 -> 498,148 -> 498,145 -> 498,148 -> 500,148 -> 500,141 -> 500,148 -> 502,148 -> 502,143 -> 502,148 -> 504,148 -> 504,145 -> 504,148
507,26 -> 507,28 -> 504,28 -> 504,33 -> 511,33 -> 511,28 -> 510,28 -> 510,26
528,80 -> 532,80
508,60 -> 508,58 -> 508,60 -> 510,60 -> 510,55 -> 510,60 -> 512,60 -> 512,51 -> 512,60 -> 514,60 -> 514,59 -> 514,60 -> 516,60 -> 516,58 -> 516,60 -> 518,60 -> 518,50 -> 518,60 -> 520,60 -> 520,58 -> 520,60 -> 522,60 -> 522,52 -> 522,60 -> 524,60 -> 524,54 -> 524,60
540,109 -> 545,109
523,73 -> 523,68 -> 523,73 -> 525,73 -> 525,72 -> 525,73 -> 527,73 -> 527,69 -> 527,73
508,60 -> 508,58 -> 508,60 -> 510,60 -> 510,55 -> 510,60 -> 512,60 -> 512,51 -> 512,60 -> 514,60 -> 514,59 -> 514,60 -> 516,60 -> 516,58 -> 516,60 -> 518,60 -> 518,50 -> 518,60 -> 520,60 -> 520,58 -> 520,60 -> 522,60 -> 522,52 -> 522,60 -> 524,60 -> 524,54 -> 524,60
508,60 -> 508,58 -> 508,60 -> 510,60 -> 510,55 -> 510,60 -> 512,60 -> 512,51 -> 512,60 -> 514,60 -> 514,59 -> 514,60 -> 516,60 -> 516,58 -> 516,60 -> 518,60 -> 518,50 -> 518,60 -> 520,60 -> 520,58 -> 520,60 -> 522,60 -> 522,52 -> 522,60 -> 524,60 -> 524,54 -> 524,60
520,114 -> 520,117 -> 514,117 -> 514,122 -> 533,122 -> 533,117 -> 525,117 -> 525,114
488,148 -> 488,144 -> 488,148 -> 490,148 -> 490,141 -> 490,148 -> 492,148 -> 492,144 -> 492,148 -> 494,148 -> 494,145 -> 494,148 -> 496,148 -> 496,139 -> 496,148 -> 498,148 -> 498,145 -> 498,148 -> 500,148 -> 500,141 -> 500,148 -> 502,148 -> 502,143 -> 502,148 -> 504,148 -> 504,145 -> 504,148
488,148 -> 488,144 -> 488,148 -> 490,148 -> 490,141 -> 490,148 -> 492,148 -> 492,144 -> 492,148 -> 494,148 -> 494,145 -> 494,148 -> 496,148 -> 496,139 -> 496,148 -> 498,148 -> 498,145 -> 498,148 -> 500,148 -> 500,141 -> 500,148 -> 502,148 -> 502,143 -> 502,148 -> 504,148 -> 504,145 -> 504,148
523,73 -> 523,68 -> 523,73 -> 525,73 -> 525,72 -> 525,73 -> 527,73 -> 527,69 -> 527,73
536,107 -> 541,107
488,148 -> 488,144 -> 488,148 -> 490,148 -> 490,141 -> 490,148 -> 492,148 -> 492,144 -> 492,148 -> 494,148 -> 494,145 -> 494,148 -> 496,148 -> 496,139 -> 496,148 -> 498,148 -> 498,145 -> 498,148 -> 500,148 -> 500,141 -> 500,148 -> 502,148 -> 502,143 -> 502,148 -> 504,148 -> 504,145 -> 504,148
537,94 -> 537,98 -> 536,98 -> 536,102 -> 542,102 -> 542,98 -> 539,98 -> 539,94
534,84 -> 538,84
508,60 -> 508,58 -> 508,60 -> 510,60 -> 510,55 -> 510,60 -> 512,60 -> 512,51 -> 512,60 -> 514,60 -> 514,59 -> 514,60 -> 516,60 -> 516,58 -> 516,60 -> 518,60 -> 518,50 -> 518,60 -> 520,60 -> 520,58 -> 520,60 -> 522,60 -> 522,52 -> 522,60 -> 524,60 -> 524,54 -> 524,60
508,60 -> 508,58 -> 508,60 -> 510,60 -> 510,55 -> 510,60 -> 512,60 -> 512,51 -> 512,60 -> 514,60 -> 514,59 -> 514,60 -> 516,60 -> 516,58 -> 516,60 -> 518,60 -> 518,50 -> 518,60 -> 520,60 -> 520,58 -> 520,60 -> 522,60 -> 522,52 -> 522,60 -> 524,60 -> 524,54 -> 524,60
525,82 -> 529,82
488,148 -> 488,144 -> 488,148 -> 490,148 -> 490,141 -> 490,148 -> 492,148 -> 492,144 -> 492,148 -> 494,148 -> 494,145 -> 494,148 -> 496,148 -> 496,139 -> 496,148 -> 498,148 -> 498,145 -> 498,148 -> 500,148 -> 500,141 -> 500,148 -> 502,148 -> 502,143 -> 502,148 -> 504,148 -> 504,145 -> 504,148
488,148 -> 488,144 -> 488,148 -> 490,148 -> 490,141 -> 490,148 -> 492,148 -> 492,144 -> 492,148 -> 494,148 -> 494,145 -> 494,148 -> 496,148 -> 496,139 -> 496,148 -> 498,148 -> 498,145 -> 498,148 -> 500,148 -> 500,141 -> 500,148 -> 502,148 -> 502,143 -> 502,148 -> 504,148 -> 504,145 -> 504,148
508,60 -> 508,58 -> 508,60 -> 510,60 -> 510,55 -> 510,60 -> 512,60 -> 512,51 -> 512,60 -> 514,60 -> 514,59 -> 514,60 -> 516,60 -> 516,58 -> 516,60 -> 518,60 -> 518,50 -> 518,60 -> 520,60 -> 520,58 -> 520,60 -> 522,60 -> 522,52 -> 522,60 -> 524,60 -> 524,54 -> 524,60
508,60 -> 508,58 -> 508,60 -> 510,60 -> 510,55 -> 510,60 -> 512,60 -> 512,51 -> 512,60 -> 514,60 -> 514,59 -> 514,60 -> 516,60 -> 516,58 -> 516,60 -> 518,60 -> 518,50 -> 518,60 -> 520,60 -> 520,58 -> 520,60 -> 522,60 -> 522,52 -> 522,60 -> 524,60 -> 524,54 -> 524,60
520,114 -> 520,117 -> 514,117 -> 514,122 -> 533,122 -> 533,117 -> 525,117 -> 525,114
508,60 -> 508,58 -> 508,60 -> 510,60 -> 510,55 -> 510,60 -> 512,60 -> 512,51 -> 512,60 -> 514,60 -> 514,59 -> 514,60 -> 516,60 -> 516,58 -> 516,60 -> 518,60 -> 518,50 -> 518,60 -> 520,60 -> 520,58 -> 520,60 -> 522,60 -> 522,52 -> 522,60 -> 524,60 -> 524,54 -> 524,60
488,148 -> 488,144 -> 488,148 -> 490,148 -> 490,141 -> 490,148 -> 492,148 -> 492,144 -> 492,148 -> 494,148 -> 494,145 -> 494,148 -> 496,148 -> 496,139 -> 496,148 -> 498,148 -> 498,145 -> 498,148 -> 500,148 -> 500,141 -> 500,148 -> 502,148 -> 502,143 -> 502,148 -> 504,148 -> 504,145 -> 504,148
490,23 -> 490,17 -> 490,23 -> 492,23 -> 492,22 -> 492,23 -> 494,23 -> 494,16 -> 494,23 -> 496,23 -> 496,17 -> 496,23 -> 498,23 -> 498,18 -> 498,23 -> 500,23 -> 500,13 -> 500,23 -> 502,23 -> 502,13 -> 502,23 -> 504,23 -> 504,13 -> 504,23 -> 506,23 -> 506,15 -> 506,23 -> 508,23 -> 508,22 -> 508,23
506,154 -> 510,154
508,60 -> 508,58 -> 508,60 -> 510,60 -> 510,55 -> 510,60 -> 512,60 -> 512,51 -> 512,60 -> 514,60 -> 514,59 -> 514,60 -> 516,60 -> 516,58 -> 516,60 -> 518,60 -> 518,50 -> 518,60 -> 520,60 -> 520,58 -> 520,60 -> 522,60 -> 522,52 -> 522,60 -> 524,60 -> 524,54 -> 524,60
519,86 -> 523,86
537,94 -> 537,98 -> 536,98 -> 536,102 -> 542,102 -> 542,98 -> 539,98 -> 539,94
488,148 -> 488,144 -> 488,148 -> 490,148 -> 490,141 -> 490,148 -> 492,148 -> 492,144 -> 492,148 -> 494,148 -> 494,145 -> 494,148 -> 496,148 -> 496,139 -> 496,148 -> 498,148 -> 498,145 -> 498,148 -> 500,148 -> 500,141 -> 500,148 -> 502,148 -> 502,143 -> 502,148 -> 504,148 -> 504,145 -> 504,148
488,148 -> 488,144 -> 488,148 -> 490,148 -> 490,141 -> 490,148 -> 492,148 -> 492,144 -> 492,148 -> 494,148 -> 494,145 -> 494,148 -> 496,148 -> 496,139 -> 496,148 -> 498,148 -> 498,145 -> 498,148 -> 500,148 -> 500,141 -> 500,148 -> 502,148 -> 502,143 -> 502,148 -> 504,148 -> 504,145 -> 504,148
488,148 -> 488,144 -> 488,148 -> 490,148 -> 490,141 -> 490,148 -> 492,148 -> 492,144 -> 492,148 -> 494,148 -> 494,145 -> 494,148 -> 496,148 -> 496,139 -> 496,148 -> 498,148 -> 498,145 -> 498,148 -> 500,148 -> 500,141 -> 500,148 -> 502,148 -> 502,143 -> 502,148 -> 504,148 -> 504,145 -> 504,148
537,86 -> 541,86
511,36 -> 511,40 -> 503,40 -> 503,43 -> 519,43 -> 519,40 -> 515,40 -> 515,36
508,131 -> 512,131
507,26 -> 507,28 -> 504,28 -> 504,33 -> 511,33 -> 511,28 -> 510,28 -> 510,26
508,60 -> 508,58 -> 508,60 -> 510,60 -> 510,55 -> 510,60 -> 512,60 -> 512,51 -> 512,60 -> 514,60 -> 514,59 -> 514,60 -> 516,60 -> 516,58 -> 516,60 -> 518,60 -> 518,50 -> 518,60 -> 520,60 -> 520,58 -> 520,60 -> 522,60 -> 522,52 -> 522,60 -> 524,60 -> 524,54 -> 524,60
518,47 -> 525,47 -> 525,46
508,60 -> 508,58 -> 508,60 -> 510,60 -> 510,55 -> 510,60 -> 512,60 -> 512,51 -> 512,60 -> 514,60 -> 514,59 -> 514,60 -> 516,60 -> 516,58 -> 516,60 -> 518,60 -> 518,50 -> 518,60 -> 520,60 -> 520,58 -> 520,60 -> 522,60 -> 522,52 -> 522,60 -> 524,60 -> 524,54 -> 524,60
488,148 -> 488,144 -> 488,148 -> 490,148 -> 490,141 -> 490,148 -> 492,148 -> 492,144 -> 492,148 -> 494,148 -> 494,145 -> 494,148 -> 496,148 -> 496,139 -> 496,148 -> 498,148 -> 498,145 -> 498,148 -> 500,148 -> 500,141 -> 500,148 -> 502,148 -> 502,143 -> 502,148 -> 504,148 -> 504,145 -> 504,148
509,157 -> 513,157
490,23 -> 490,17 -> 490,23 -> 492,23 -> 492,22 -> 492,23 -> 494,23 -> 494,16 -> 494,23 -> 496,23 -> 496,17 -> 496,23 -> 498,23 -> 498,18 -> 498,23 -> 500,23 -> 500,13 -> 500,23 -> 502,23 -> 502,13 -> 502,23 -> 504,23 -> 504,13 -> 504,23 -> 506,23 -> 506,15 -> 506,23 -> 508,23 -> 508,22 -> 508,23
511,36 -> 511,40 -> 503,40 -> 503,43 -> 519,43 -> 519,40 -> 515,40 -> 515,36
537,94 -> 537,98 -> 536,98 -> 536,102 -> 542,102 -> 542,98 -> 539,98 -> 539,94
533,109 -> 538,109
505,129 -> 509,129
518,76 -> 518,77 -> 529,77 -> 529,76
488,148 -> 488,144 -> 488,148 -> 490,148 -> 490,141 -> 490,148 -> 492,148 -> 492,144 -> 492,148 -> 494,148 -> 494,145 -> 494,148 -> 496,148 -> 496,139 -> 496,148 -> 498,148 -> 498,145 -> 498,148 -> 500,148 -> 500,141 -> 500,148 -> 502,148 -> 502,143 -> 502,148 -> 504,148 -> 504,145 -> 504,148
498,134 -> 498,135 -> 509,135 -> 509,134
537,94 -> 537,98 -> 536,98 -> 536,102 -> 542,102 -> 542,98 -> 539,98 -> 539,94
537,94 -> 537,98 -> 536,98 -> 536,102 -> 542,102 -> 542,98 -> 539,98 -> 539,94
490,23 -> 490,17 -> 490,23 -> 492,23 -> 492,22 -> 492,23 -> 494,23 -> 494,16 -> 494,23 -> 496,23 -> 496,17 -> 496,23 -> 498,23 -> 498,18 -> 498,23 -> 500,23 -> 500,13 -> 500,23 -> 502,23 -> 502,13 -> 502,23 -> 504,23 -> 504,13 -> 504,23 -> 506,23 -> 506,15 -> 506,23 -> 508,23 -> 508,22 -> 508,23
490,23 -> 490,17 -> 490,23 -> 492,23 -> 492,22 -> 492,23 -> 494,23 -> 494,16 -> 494,23 -> 496,23 -> 496,17 -> 496,23 -> 498,23 -> 498,18 -> 498,23 -> 500,23 -> 500,13 -> 500,23 -> 502,23 -> 502,13 -> 502,23 -> 504,23 -> 504,13 -> 504,23 -> 506,23 -> 506,15 -> 506,23 -> 508,23 -> 508,22 -> 508,23
511,36 -> 511,40 -> 503,40 -> 503,43 -> 519,43 -> 519,40 -> 515,40 -> 515,36
529,107 -> 534,107
488,148 -> 488,144 -> 488,148 -> 490,148 -> 490,141 -> 490,148 -> 492,148 -> 492,144 -> 492,148 -> 494,148 -> 494,145 -> 494,148 -> 496,148 -> 496,139 -> 496,148 -> 498,148 -> 498,145 -> 498,148 -> 500,148 -> 500,141 -> 500,148 -> 502,148 -> 502,143 -> 502,148 -> 504,148 -> 504,145 -> 504,148
532,105 -> 537,105
488,148 -> 488,144 -> 488,148 -> 490,148 -> 490,141 -> 490,148 -> 492,148 -> 492,144 -> 492,148 -> 494,148 -> 494,145 -> 494,148 -> 496,148 -> 496,139 -> 496,148 -> 498,148 -> 498,145 -> 498,148 -> 500,148 -> 500,141 -> 500,148 -> 502,148 -> 502,143 -> 502,148 -> 504,148 -> 504,145 -> 504,148
490,23 -> 490,17 -> 490,23 -> 492,23 -> 492,22 -> 492,23 -> 494,23 -> 494,16 -> 494,23 -> 496,23 -> 496,17 -> 496,23 -> 498,23 -> 498,18 -> 498,23 -> 500,23 -> 500,13 -> 500,23 -> 502,23 -> 502,13 -> 502,23 -> 504,23 -> 504,13 -> 504,23 -> 506,23 -> 506,15 -> 506,23 -> 508,23 -> 508,22 -> 508,23
490,23 -> 490,17 -> 490,23 -> 492,23 -> 492,22 -> 492,23 -> 494,23 -> 494,16 -> 494,23 -> 496,23 -> 496,17 -> 496,23 -> 498,23 -> 498,18 -> 498,23 -> 500,23 -> 500,13 -> 500,23 -> 502,23 -> 502,13 -> 502,23 -> 504,23 -> 504,13 -> 504,23 -> 506,23 -> 506,15 -> 506,23 -> 508,23 -> 508,22 -> 508,23
508,60 -> 508,58 -> 508,60 -> 510,60 -> 510,55 -> 510,60 -> 512,60 -> 512,51 -> 512,60 -> 514,60 -> 514,59 -> 514,60 -> 516,60 -> 516,58 -> 516,60 -> 518,60 -> 518,50 -> 518,60 -> 520,60 -> 520,58 -> 520,60 -> 522,60 -> 522,52 -> 522,60 -> 524,60 -> 524,54 -> 524,60
500,154 -> 504,154
490,23 -> 490,17 -> 490,23 -> 492,23 -> 492,22 -> 492,23 -> 494,23 -> 494,16 -> 494,23 -> 496,23 -> 496,17 -> 496,23 -> 498,23 -> 498,18 -> 498,23 -> 500,23 -> 500,13 -> 500,23 -> 502,23 -> 502,13 -> 502,23 -> 504,23 -> 504,13 -> 504,23 -> 506,23 -> 506,15 -> 506,23 -> 508,23 -> 508,22 -> 508,23
488,148 -> 488,144 -> 488,148 -> 490,148 -> 490,141 -> 490,148 -> 492,148 -> 492,144 -> 492,148 -> 494,148 -> 494,145 -> 494,148 -> 496,148 -> 496,139 -> 496,148 -> 498,148 -> 498,145 -> 498,148 -> 500,148 -> 500,141 -> 500,148 -> 502,148 -> 502,143 -> 502,148 -> 504,148 -> 504,145 -> 504,148
490,23 -> 490,17 -> 490,23 -> 492,23 -> 492,22 -> 492,23 -> 494,23 -> 494,16 -> 494,23 -> 496,23 -> 496,17 -> 496,23 -> 498,23 -> 498,18 -> 498,23 -> 500,23 -> 500,13 -> 500,23 -> 502,23 -> 502,13 -> 502,23 -> 504,23 -> 504,13 -> 504,23 -> 506,23 -> 506,15 -> 506,23 -> 508,23 -> 508,22 -> 508,23
508,60 -> 508,58 -> 508,60 -> 510,60 -> 510,55 -> 510,60 -> 512,60 -> 512,51 -> 512,60 -> 514,60 -> 514,59 -> 514,60 -> 516,60 -> 516,58 -> 516,60 -> 518,60 -> 518,50 -> 518,60 -> 520,60 -> 520,58 -> 520,60 -> 522,60 -> 522,52 -> 522,60 -> 524,60 -> 524,54 -> 524,60
523,111 -> 528,111
488,148 -> 488,144 -> 488,148 -> 490,148 -> 490,141 -> 490,148 -> 492,148 -> 492,144 -> 492,148 -> 494,148 -> 494,145 -> 494,148 -> 496,148 -> 496,139 -> 496,148 -> 498,148 -> 498,145 -> 498,148 -> 500,148 -> 500,141 -> 500,148 -> 502,148 -> 502,143 -> 502,148 -> 504,148 -> 504,145 -> 504,148
488,148 -> 488,144 -> 488,148 -> 490,148 -> 490,141 -> 490,148 -> 492,148 -> 492,144 -> 492,148 -> 494,148 -> 494,145 -> 494,148 -> 496,148 -> 496,139 -> 496,148 -> 498,148 -> 498,145 -> 498,148 -> 500,148 -> 500,141 -> 500,148 -> 502,148 -> 502,143 -> 502,148 -> 504,148 -> 504,145 -> 504,148
511,36 -> 511,40 -> 503,40 -> 503,43 -> 519,43 -> 519,40 -> 515,40 -> 515,36
544,111 -> 549,111
488,148 -> 488,144 -> 488,148 -> 490,148 -> 490,141 -> 490,148 -> 492,148 -> 492,144 -> 492,148 -> 494,148 -> 494,145 -> 494,148 -> 496,148 -> 496,139 -> 496,148 -> 498,148 -> 498,145 -> 498,148 -> 500,148 -> 500,141 -> 500,148 -> 502,148 -> 502,143 -> 502,148 -> 504,148 -> 504,145 -> 504,148
518,76 -> 518,77 -> 529,77 -> 529,76
508,60 -> 508,58 -> 508,60 -> 510,60 -> 510,55 -> 510,60 -> 512,60 -> 512,51 -> 512,60 -> 514,60 -> 514,59 -> 514,60 -> 516,60 -> 516,58 -> 516,60 -> 518,60 -> 518,50 -> 518,60 -> 520,60 -> 520,58 -> 520,60 -> 522,60 -> 522,52 -> 522,60 -> 524,60 -> 524,54 -> 524,60
537,111 -> 542,111
490,23 -> 490,17 -> 490,23 -> 492,23 -> 492,22 -> 492,23 -> 494,23 -> 494,16 -> 494,23 -> 496,23 -> 496,17 -> 496,23 -> 498,23 -> 498,18 -> 498,23 -> 500,23 -> 500,13 -> 500,23 -> 502,23 -> 502,13 -> 502,23 -> 504,23 -> 504,13 -> 504,23 -> 506,23 -> 506,15 -> 506,23 -> 508,23 -> 508,22 -> 508,23
488,148 -> 488,144 -> 488,148 -> 490,148 -> 490,141 -> 490,148 -> 492,148 -> 492,144 -> 492,148 -> 494,148 -> 494,145 -> 494,148 -> 496,148 -> 496,139 -> 496,148 -> 498,148 -> 498,145 -> 498,148 -> 500,148 -> 500,141 -> 500,148 -> 502,148 -> 502,143 -> 502,148 -> 504,148 -> 504,145 -> 504,148
507,26 -> 507,28 -> 504,28 -> 504,33 -> 511,33 -> 511,28 -> 510,28 -> 510,26
523,73 -> 523,68 -> 523,73 -> 525,73 -> 525,72 -> 525,73 -> 527,73 -> 527,69 -> 527,73
508,60 -> 508,58 -> 508,60 -> 510,60 -> 510,55 -> 510,60 -> 512,60 -> 512,51 -> 512,60 -> 514,60 -> 514,59 -> 514,60 -> 516,60 -> 516,58 -> 516,60 -> 518,60 -> 518,50 -> 518,60 -> 520,60 -> 520,58 -> 520,60 -> 522,60 -> 522,52 -> 522,60 -> 524,60 -> 524,54 -> 524,60
490,23 -> 490,17 -> 490,23 -> 492,23 -> 492,22 -> 492,23 -> 494,23 -> 494,16 -> 494,23 -> 496,23 -> 496,17 -> 496,23 -> 498,23 -> 498,18 -> 498,23 -> 500,23 -> 500,13 -> 500,23 -> 502,23 -> 502,13 -> 502,23 -> 504,23 -> 504,13 -> 504,23 -> 506,23 -> 506,15 -> 506,23 -> 508,23 -> 508,22 -> 508,23
507,26 -> 507,28 -> 504,28 -> 504,33 -> 511,33 -> 511,28 -> 510,28 -> 510,26
490,23 -> 490,17 -> 490,23 -> 492,23 -> 492,22 -> 492,23 -> 494,23 -> 494,16 -> 494,23 -> 496,23 -> 496,17 -> 496,23 -> 498,23 -> 498,18 -> 498,23 -> 500,23 -> 500,13 -> 500,23 -> 502,23 -> 502,13 -> 502,23 -> 504,23 -> 504,13 -> 504,23 -> 506,23 -> 506,15 -> 506,23 -> 508,23 -> 508,22 -> 508,23
490,23 -> 490,17 -> 490,23 -> 492,23 -> 492,22 -> 492,23 -> 494,23 -> 494,16 -> 494,23 -> 496,23 -> 496,17 -> 496,23 -> 498,23 -> 498,18 -> 498,23 -> 500,23 -> 500,13 -> 500,23 -> 502,23 -> 502,13 -> 502,23 -> 504,23 -> 504,13 -> 504,23 -> 506,23 -> 506,15 -> 506,23 -> 508,23 -> 508,22 -> 508,23
490,23 -> 490,17 -> 490,23 -> 492,23 -> 492,22 -> 492,23 -> 494,23 -> 494,16 -> 494,23 -> 496,23 -> 496,17 -> 496,23 -> 498,23 -> 498,18 -> 498,23 -> 500,23 -> 500,13 -> 500,23 -> 502,23 -> 502,13 -> 502,23 -> 504,23 -> 504,13 -> 504,23 -> 506,23 -> 506,15 -> 506,23 -> 508,23 -> 508,22 -> 508,23
508,60 -> 508,58 -> 508,60 -> 510,60 -> 510,55 -> 510,60 -> 512,60 -> 512,51 -> 512,60 -> 514,60 -> 514,59 -> 514,60 -> 516,60 -> 516,58 -> 516,60 -> 518,60 -> 518,50 -> 518,60 -> 520,60 -> 520,58 -> 520,60 -> 522,60 -> 522,52 -> 522,60 -> 524,60 -> 524,54 -> 524,60
518,76 -> 518,77 -> 529,77 -> 529,76
531,82 -> 535,82
508,60 -> 508,58 -> 508,60 -> 510,60 -> 510,55 -> 510,60 -> 512,60 -> 512,51 -> 512,60 -> 514,60 -> 514,59 -> 514,60 -> 516,60 -> 516,58 -> 516,60 -> 518,60 -> 518,50 -> 518,60 -> 520,60 -> 520,58 -> 520,60 -> 522,60 -> 522,52 -> 522,60 -> 524,60 -> 524,54 -> 524,60
490,23 -> 490,17 -> 490,23 -> 492,23 -> 492,22 -> 492,23 -> 494,23 -> 494,16 -> 494,23 -> 496,23 -> 496,17 -> 496,23 -> 498,23 -> 498,18 -> 498,23 -> 500,23 -> 500,13 -> 500,23 -> 502,23 -> 502,13 -> 502,23 -> 504,23 -> 504,13 -> 504,23 -> 506,23 -> 506,15 -> 506,23 -> 508,23 -> 508,22 -> 508,23
507,26 -> 507,28 -> 504,28 -> 504,33 -> 511,33 -> 511,28 -> 510,28 -> 510,26
511,36 -> 511,40 -> 503,40 -> 503,43 -> 519,43 -> 519,40 -> 515,40 -> 515,36
502,131 -> 506,131
508,60 -> 508,58 -> 508,60 -> 510,60 -> 510,55 -> 510,60 -> 512,60 -> 512,51 -> 512,60 -> 514,60 -> 514,59 -> 514,60 -> 516,60 -> 516,58 -> 516,60 -> 518,60 -> 518,50 -> 518,60 -> 520,60 -> 520,58 -> 520,60 -> 522,60 -> 522,52 -> 522,60 -> 524,60 -> 524,54 -> 524,60
488,148 -> 488,144 -> 488,148 -> 490,148 -> 490,141 -> 490,148 -> 492,148 -> 492,144 -> 492,148 -> 494,148 -> 494,145 -> 494,148 -> 496,148 -> 496,139 -> 496,148 -> 498,148 -> 498,145 -> 498,148 -> 500,148 -> 500,141 -> 500,148 -> 502,148 -> 502,143 -> 502,148 -> 504,148 -> 504,145 -> 504,148
490,23 -> 490,17 -> 490,23 -> 492,23 -> 492,22 -> 492,23 -> 494,23 -> 494,16 -> 494,23 -> 496,23 -> 496,17 -> 496,23 -> 498,23 -> 498,18 -> 498,23 -> 500,23 -> 500,13 -> 500,23 -> 502,23 -> 502,13 -> 502,23 -> 504,23 -> 504,13 -> 504,23 -> 506,23 -> 506,15 -> 506,23 -> 508,23 -> 508,22 -> 508,23''';
}