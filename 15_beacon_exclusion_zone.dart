class Position {
  final int x;
  final int y;

  Position(this.x, this.y);

  int manhattanDistance(Position other) {
    return (x - other.x).abs() + (y - other.y).abs();
  }

  @override
  bool operator ==(Object other) =>
    identical(this, other) ||
    other is Position &&
    runtimeType == other.runtimeType &&
    x == other.x &&
    y == other.y;

  @override
  int get hashCode => Object.hashAll([x, y]);

}

class Sensor {
  final Position sensorPos;
  final Position beaconPos;

  Sensor(this.sensorPos, this.beaconPos);
}

class Input {
  final List<Sensor> sensors;

  Input(this.sensors);
}

void main() {
  final int part1Result = part1();
  // final int part2Result = part2();
  
  assert(part1Result == 4582667);


  print('part1: $part1Result');
  // print('part2: $part2Result');
}

int part1() {
  final Input input = parseInput(puzzleInput());
  final Set<int> occupiedPositions = {};
  const int targetRow = 2000000;

  for (var sensor in input.sensors) {
    final int manhattanDistance = sensor.sensorPos.manhattanDistance(sensor.beaconPos);
    final int dY = (sensor.sensorPos.y - targetRow).abs();
    final int startX = sensor.sensorPos.x - manhattanDistance + dY;
    final int endX = sensor.sensorPos.x + manhattanDistance - dY;
    for (int i = startX; i <= endX; i++) {
      if (sensor.beaconPos.y == targetRow && sensor.beaconPos.x == i) {
        continue;
      }
      occupiedPositions.add(i);
    }
  }

  return occupiedPositions.length;
}

int part2() {
  // todo :)
  return 0;
}

Input parseInput(String input) {
  final List<Sensor> sensors = [];
  for (String line in input.split('\n')) {
    int sX = int.parse(line.split(':')[0].split(', ')[0].split('=')[1]);
    int sY = int.parse(line.split(':')[0].split(', ')[1].split('=')[1]);
    int bX = int.parse(line.split(':')[1].split(', ')[0].split('=')[1]);
    int bY = int.parse(line.split(':')[1].split(', ')[1].split('=')[1]);
    sensors.add(Sensor(Position(sX, sY), Position(bX, bY)));
  }

  return Input(sensors);
}

String puzzleInput() {
  return '''
Sensor at x=2692921, y=2988627: closest beacon is at x=2453611, y=3029623
Sensor at x=1557973, y=1620482: closest beacon is at x=1908435, y=2403457
Sensor at x=278431, y=3878878: closest beacon is at x=-1050422, y=3218536
Sensor at x=1432037, y=3317707: closest beacon is at x=2453611, y=3029623
Sensor at x=3191434, y=3564121: closest beacon is at x=3420256, y=2939344
Sensor at x=3080887, y=2781756: closest beacon is at x=3420256, y=2939344
Sensor at x=3543287, y=3060807: closest beacon is at x=3420256, y=2939344
Sensor at x=2476158, y=3949016: closest beacon is at x=2453611, y=3029623
Sensor at x=3999769, y=3985671: closest beacon is at x=3420256, y=2939344
Sensor at x=2435331, y=2200565: closest beacon is at x=1908435, y=2403457
Sensor at x=3970047, y=2036397: closest beacon is at x=3691788, y=1874066
Sensor at x=2232167, y=2750817: closest beacon is at x=2453611, y=3029623
Sensor at x=157988, y=333826: closest beacon is at x=-1236383, y=477990
Sensor at x=1035254, y=2261267: closest beacon is at x=1908435, y=2403457
Sensor at x=1154009, y=888885: closest beacon is at x=1070922, y=-543463
Sensor at x=2704724, y=257848: closest beacon is at x=3428489, y=-741777
Sensor at x=3672526, y=2651153: closest beacon is at x=3420256, y=2939344
Sensor at x=2030614, y=2603134: closest beacon is at x=1908435, y=2403457
Sensor at x=2550448, y=2781018: closest beacon is at x=2453611, y=3029623
Sensor at x=3162759, y=2196461: closest beacon is at x=3691788, y=1874066
Sensor at x=463834, y=1709480: closest beacon is at x=-208427, y=2000000
Sensor at x=217427, y=2725325: closest beacon is at x=-208427, y=2000000
Sensor at x=3903198, y=945190: closest beacon is at x=3691788, y=1874066''';
}

String exampleInput() {
  return '''
Sensor at x=2, y=18: closest beacon is at x=-2, y=15
Sensor at x=9, y=16: closest beacon is at x=10, y=16
Sensor at x=13, y=2: closest beacon is at x=15, y=3
Sensor at x=12, y=14: closest beacon is at x=10, y=16
Sensor at x=10, y=20: closest beacon is at x=10, y=16
Sensor at x=14, y=17: closest beacon is at x=10, y=16
Sensor at x=8, y=7: closest beacon is at x=2, y=10
Sensor at x=2, y=0: closest beacon is at x=2, y=10
Sensor at x=0, y=11: closest beacon is at x=2, y=10
Sensor at x=20, y=14: closest beacon is at x=25, y=17
Sensor at x=17, y=20: closest beacon is at x=21, y=22
Sensor at x=16, y=7: closest beacon is at x=15, y=3
Sensor at x=14, y=3: closest beacon is at x=15, y=3
Sensor at x=20, y=1: closest beacon is at x=15, y=3''';
}