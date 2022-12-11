abstract class Instruction {
  int nCycles();
}
class Noop extends Instruction {
  @override
  int nCycles() {
    return 1;
  }
}
class AddX extends Instruction {
  final int value;

  AddX(this.value);
  
  @override
  int nCycles() {
    return 2;
  }
}

void main() {
  final int part1Result = part1();
  final String part2Result = part2();
  
  assert(part1Result == 14540);

  print('part1: $part1Result');
  print('part2:\n$part2Result');
}

int part1() {
  final List<Instruction> instructions = parseInput(input());
  int registerX = 1;
  int currentCycle = 0;
  int sumSignalStrengths = 0;

  for (var instruction in instructions) {
    if (instruction is Noop) {
      currentCycle += instruction.nCycles();
    } else if (instruction is AddX) {
      for (int c = 1; c <= instruction.nCycles(); c++) {
        currentCycle++;
        if (currentCycle == 20 || currentCycle == 60 || currentCycle == 100 || currentCycle == 140 || currentCycle == 180 || currentCycle == 220) {
          sumSignalStrengths += currentCycle * registerX;
        }
      }
      registerX += instruction.value;
    }
  }

  return sumSignalStrengths;
}

String part2() {
  final List<Instruction> instructions = parseInput(input());
  int registerX = 1;
  int cycle = 0;
  int pixelPos = 0;
  String pixels = '';

  void draw() {
    cycle++;
    pixelPos++;
    bool coversSprite = pixelPos - 1 >= registerX - 1 && pixelPos - 1 <= registerX + 1;
    pixels += coversSprite ? '#' : '.';    
    if (cycle % 40 == 0) {
      pixels += '\n';
      pixelPos = 0;
    }
  }

  for (var instruction in instructions) {
    draw();
    if (instruction is AddX) {
      draw();
      registerX += instruction.value;
    }
  }

  return pixels;
}

List<Instruction> parseInput(String input) {
  return input
    .split('\n')
    .map((line) {
      if (line == 'noop') {
        return Noop();
      }
      return AddX(int.parse(line.split(' ')[1]));
    }).toList();
}

String exampleInput() {
  return '''
addx 15
addx -11
addx 6
addx -3
addx 5
addx -1
addx -8
addx 13
addx 4
noop
addx -1
addx 5
addx -1
addx 5
addx -1
addx 5
addx -1
addx 5
addx -1
addx -35
addx 1
addx 24
addx -19
addx 1
addx 16
addx -11
noop
noop
addx 21
addx -15
noop
noop
addx -3
addx 9
addx 1
addx -3
addx 8
addx 1
addx 5
noop
noop
noop
noop
noop
addx -36
noop
addx 1
addx 7
noop
noop
noop
addx 2
addx 6
noop
noop
noop
noop
noop
addx 1
noop
noop
addx 7
addx 1
noop
addx -13
addx 13
addx 7
noop
addx 1
addx -33
noop
noop
noop
addx 2
noop
noop
noop
addx 8
noop
addx -1
addx 2
addx 1
noop
addx 17
addx -9
addx 1
addx 1
addx -3
addx 11
noop
noop
addx 1
noop
addx 1
noop
noop
addx -13
addx -19
addx 1
addx 3
addx 26
addx -30
addx 12
addx -1
addx 3
addx 1
noop
noop
noop
addx -9
addx 18
addx 1
addx 2
noop
noop
addx 9
noop
noop
noop
addx -1
addx 2
addx -37
addx 1
addx 3
noop
addx 15
addx -21
addx 22
addx -6
addx 1
noop
addx 2
addx 1
noop
addx -10
noop
noop
addx 20
addx 1
addx 2
addx 2
addx -6
addx -11
noop
noop
noop''';
}

String input() {
  return '''
addx 2
addx 3
addx 3
addx -2
addx 4
noop
addx 1
addx 4
addx 1
noop
addx 4
addx 1
noop
addx 2
addx 5
addx -28
addx 30
noop
addx 5
addx 1
noop
addx -38
noop
noop
noop
noop
addx 5
addx 5
addx 3
addx 2
addx -2
addx 2
noop
noop
addx -2
addx 12
noop
addx 2
addx 3
noop
addx 2
addx -31
addx 32
addx 7
noop
addx -2
addx -37
addx 1
addx 5
addx 1
noop
addx 31
addx -25
addx -10
addx 13
noop
noop
addx 18
addx -11
addx 3
noop
noop
addx 1
addx 4
addx -32
addx 15
addx 24
addx -2
noop
addx -37
noop
noop
noop
addx 5
addx 5
addx 21
addx -20
noop
addx 6
addx 19
addx -5
addx -8
addx -22
addx 26
addx -22
addx 23
addx 2
noop
noop
noop
addx 8
addx -10
addx -27
addx 33
addx -27
noop
addx 34
addx -33
addx 2
addx 19
addx -12
addx 11
addx -20
addx 12
addx 18
addx -11
addx -14
addx 15
addx 2
noop
addx 3
addx 2
noop
noop
noop
addx -33
noop
addx 1
addx 2
noop
addx 3
addx 4
noop
addx 1
addx 2
noop
noop
addx 7
addx 1
noop
addx 4
addx -17
addx 18
addx 5
addx -1
addx 5
addx 1
noop
noop
noop
noop''';
}