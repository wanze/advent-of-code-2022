class Stack<T> {
  List<T> _items = [];

  Stack(List<T> initialItems) {
    _items = [...initialItems];
  }

  T pop() {
    return _items.removeLast();
  }

  void push(T item) {
    _items.add(item);
  }

  T get top => _items.last;
}

class MovementInstruction {
  final int n;
  final int from;
  final int to;

  MovementInstruction({required this.n, required this.from, required this.to});
}

class Input {
  final List<Stack<String>> stacks;
  final List<MovementInstruction> instructions;

  Input({required this.stacks, required this.instructions});
}

void main() {
  String part1Result = part1();
  assert(part1Result == 'VPCDMSLWJ');
  String part2Result = part2();
  assert(part2Result == 'TPWCGNCCG');

  print('part1: $part1Result');
  print('part2: $part2Result');
}

String part1() {
  final Input i = parseInput(input());
  final craneStacks = i.stacks;
  for (var instruction in i.instructions) {
    final source = craneStacks[instruction.from - 1];
    final target = craneStacks[instruction.to - 1];
    for (int i = 1; i <= instruction.n; i++) {
      target.push(source.pop());
    }
  }

  return craneStacks.map((stack) => stack.top).join('');
}

String part2() {
  final Input i = parseInput(input());
  final craneStacks = i.stacks;
  for (var instruction in i.instructions) {
    final source = craneStacks[instruction.from - 1];
    final target = craneStacks[instruction.to - 1];
    final List<String> poppedCranes = [];
    for (int i = 1; i <= instruction.n; i++) {
      poppedCranes.add(source.pop());
    }
    for (var crane in poppedCranes.reversed) {
      target.push(crane);
    }
  }

  return craneStacks.map((stack) => stack.top).join('');
}

Input parseInput(String input) {
  final List<String> lines = input.split('\n');
  final int separator = lines.indexOf('');
  final List<String> stackLines = lines.sublist(0, separator - 1);
  final List<String> instructionLines = lines.sublist(separator + 1);
  
  final List<String> crateStacks = ['', '', '', '', '', '', '', '', ''];
  for (var stackLine in stackLines) {
    for (int i = 0; i < 9; i++) {
      final String crate = stackLine[(i * 4) + 1];
      if (crate != ' ') {
        crateStacks[i] = crate + crateStacks[i];
      }
    }
  }
  List<Stack<String>> stacks = crateStacks.map((s) => Stack(s.split(''))).toList();

  List<MovementInstruction> instructions = instructionLines.map((instruction) {
    List<String> parts = instruction.split(' ');
    return MovementInstruction(n: int.parse(parts[1]), from: int.parse(parts[3]), to: int.parse(parts[5]));
  }).toList();

  return Input(stacks: stacks, instructions: instructions);
}

String exampleInput() {
  return '''
    [D]    
[N] [C]    
[Z] [M] [P]
 1   2   3 

move 1 from 2 to 1
move 3 from 1 to 3
move 2 from 2 to 1
move 1 from 1 to 2
''';
}

String input() {
  return '''
    [C]         [Q]         [V]    
    [D]         [D] [S]     [M] [Z]
    [G]     [P] [W] [M]     [C] [G]
    [F]     [Z] [C] [D] [P] [S] [W]
[P] [L]     [C] [V] [W] [W] [H] [L]
[G] [B] [V] [R] [L] [N] [G] [P] [F]
[R] [T] [S] [S] [S] [T] [D] [L] [P]
[N] [J] [M] [L] [P] [C] [H] [Z] [R]
 1   2   3   4   5   6   7   8   9 

move 2 from 4 to 6
move 4 from 5 to 3
move 6 from 6 to 1
move 4 from 1 to 4
move 4 from 9 to 4
move 7 from 2 to 4
move 1 from 9 to 3
move 1 from 2 to 6
move 2 from 9 to 5
move 2 from 6 to 8
move 5 from 8 to 1
move 2 from 6 to 9
move 5 from 8 to 3
move 1 from 5 to 4
move 3 from 7 to 2
move 10 from 4 to 7
move 7 from 4 to 3
move 1 from 4 to 7
move 1 from 7 to 9
move 1 from 2 to 3
move 11 from 1 to 7
move 12 from 3 to 7
move 8 from 3 to 8
move 29 from 7 to 2
move 3 from 7 to 3
move 3 from 9 to 2
move 4 from 5 to 3
move 7 from 3 to 5
move 28 from 2 to 3
move 1 from 7 to 5
move 2 from 8 to 5
move 2 from 4 to 1
move 2 from 1 to 4
move 1 from 7 to 6
move 1 from 7 to 1
move 3 from 2 to 8
move 1 from 1 to 7
move 9 from 5 to 3
move 12 from 3 to 1
move 1 from 4 to 3
move 1 from 6 to 4
move 3 from 2 to 9
move 16 from 3 to 7
move 2 from 9 to 6
move 5 from 7 to 2
move 1 from 9 to 7
move 1 from 4 to 2
move 13 from 7 to 2
move 13 from 2 to 7
move 12 from 7 to 8
move 2 from 6 to 4
move 16 from 8 to 1
move 4 from 3 to 1
move 3 from 3 to 2
move 1 from 5 to 7
move 1 from 5 to 3
move 3 from 4 to 6
move 19 from 1 to 3
move 5 from 8 to 4
move 6 from 3 to 2
move 5 from 4 to 2
move 1 from 7 to 4
move 1 from 4 to 9
move 3 from 6 to 7
move 1 from 9 to 2
move 16 from 2 to 4
move 9 from 1 to 8
move 10 from 4 to 2
move 2 from 7 to 5
move 5 from 8 to 4
move 12 from 2 to 9
move 2 from 7 to 4
move 12 from 9 to 5
move 11 from 5 to 6
move 3 from 1 to 9
move 1 from 5 to 7
move 2 from 9 to 2
move 10 from 3 to 2
move 1 from 9 to 2
move 2 from 8 to 9
move 1 from 7 to 8
move 1 from 8 to 4
move 7 from 2 to 6
move 1 from 1 to 5
move 5 from 3 to 1
move 1 from 5 to 1
move 2 from 3 to 9
move 2 from 1 to 6
move 3 from 9 to 8
move 14 from 6 to 1
move 1 from 3 to 5
move 5 from 4 to 6
move 1 from 9 to 6
move 7 from 6 to 9
move 1 from 6 to 2
move 8 from 1 to 4
move 7 from 1 to 7
move 10 from 2 to 1
move 4 from 7 to 6
move 10 from 4 to 6
move 5 from 8 to 2
move 1 from 5 to 9
move 2 from 2 to 6
move 2 from 4 to 7
move 1 from 2 to 7
move 5 from 9 to 2
move 1 from 2 to 9
move 14 from 6 to 8
move 2 from 8 to 4
move 1 from 2 to 6
move 4 from 9 to 3
move 2 from 6 to 8
move 5 from 4 to 5
move 5 from 8 to 3
move 1 from 2 to 4
move 3 from 7 to 1
move 2 from 2 to 7
move 1 from 4 to 7
move 1 from 4 to 5
move 1 from 2 to 8
move 1 from 4 to 9
move 8 from 8 to 2
move 3 from 1 to 5
move 7 from 2 to 9
move 8 from 1 to 6
move 6 from 7 to 2
move 2 from 2 to 8
move 5 from 1 to 8
move 3 from 6 to 8
move 4 from 3 to 6
move 3 from 6 to 2
move 8 from 9 to 2
move 11 from 5 to 7
move 12 from 2 to 6
move 2 from 3 to 7
move 12 from 7 to 2
move 10 from 6 to 9
move 1 from 7 to 1
move 12 from 8 to 7
move 2 from 3 to 2
move 8 from 9 to 7
move 6 from 2 to 5
move 1 from 1 to 6
move 3 from 2 to 6
move 1 from 3 to 7
move 5 from 5 to 3
move 10 from 7 to 2
move 2 from 3 to 7
move 8 from 7 to 6
move 20 from 2 to 8
move 5 from 8 to 1
move 5 from 8 to 6
move 1 from 5 to 7
move 1 from 1 to 4
move 4 from 1 to 2
move 1 from 9 to 6
move 3 from 3 to 1
move 4 from 7 to 5
move 1 from 9 to 8
move 11 from 8 to 7
move 1 from 4 to 9
move 2 from 7 to 5
move 31 from 6 to 9
move 4 from 2 to 3
move 6 from 5 to 1
move 4 from 1 to 2
move 7 from 7 to 8
move 1 from 7 to 6
move 1 from 1 to 7
move 24 from 9 to 4
move 2 from 7 to 8
move 2 from 9 to 2
move 2 from 7 to 5
move 2 from 5 to 9
move 3 from 4 to 1
move 20 from 4 to 2
move 1 from 6 to 1
move 16 from 2 to 1
move 4 from 3 to 1
move 1 from 4 to 8
move 5 from 8 to 5
move 5 from 8 to 1
move 1 from 5 to 2
move 3 from 5 to 6
move 33 from 1 to 6
move 6 from 9 to 4
move 15 from 6 to 7
move 6 from 4 to 3
move 1 from 5 to 3
move 7 from 3 to 9
move 11 from 7 to 5
move 10 from 5 to 8
move 2 from 7 to 3
move 5 from 8 to 9
move 1 from 7 to 5
move 1 from 5 to 8
move 1 from 5 to 7
move 2 from 3 to 8
move 2 from 7 to 5
move 2 from 8 to 7
move 1 from 5 to 9
move 1 from 7 to 6
move 3 from 8 to 6
move 22 from 6 to 9
move 1 from 7 to 6
move 27 from 9 to 4
move 18 from 4 to 8
move 5 from 4 to 1
move 1 from 5 to 1
move 3 from 6 to 3
move 2 from 3 to 5
move 2 from 5 to 2
move 1 from 2 to 6
move 1 from 6 to 3
move 9 from 8 to 6
move 3 from 9 to 8
move 9 from 6 to 5
move 1 from 6 to 9
move 15 from 8 to 5
move 1 from 3 to 4
move 6 from 1 to 8
move 1 from 3 to 7
move 8 from 5 to 8
move 2 from 5 to 6
move 3 from 4 to 6
move 1 from 7 to 6
move 2 from 5 to 3
move 5 from 5 to 1
move 2 from 3 to 7
move 1 from 8 to 1
move 10 from 2 to 9
move 5 from 6 to 3
move 7 from 8 to 5
move 4 from 3 to 5
move 1 from 2 to 1
move 2 from 7 to 6
move 5 from 1 to 5
move 1 from 3 to 7
move 1 from 7 to 6
move 3 from 8 to 5
move 4 from 6 to 4
move 1 from 2 to 9
move 5 from 4 to 6
move 21 from 5 to 3
move 2 from 8 to 4
move 3 from 4 to 1
move 1 from 8 to 4
move 18 from 3 to 5
move 2 from 3 to 6
move 2 from 6 to 9
move 2 from 6 to 2
move 1 from 2 to 9
move 19 from 9 to 4
move 3 from 6 to 3
move 2 from 9 to 4
move 1 from 1 to 2
move 1 from 3 to 7
move 16 from 5 to 2
move 4 from 1 to 9
move 3 from 3 to 4
move 4 from 9 to 8
move 3 from 5 to 1
move 22 from 4 to 5
move 1 from 7 to 2
move 22 from 5 to 9
move 2 from 5 to 2
move 2 from 4 to 6
move 10 from 9 to 5
move 1 from 8 to 3
move 13 from 9 to 2
move 1 from 6 to 3
move 19 from 2 to 7
move 2 from 7 to 4
move 1 from 8 to 4
move 1 from 8 to 2
move 11 from 5 to 7
move 3 from 1 to 7
move 8 from 7 to 8
move 1 from 3 to 5
move 1 from 8 to 3
move 1 from 5 to 3
move 6 from 2 to 3
move 1 from 8 to 7
move 1 from 6 to 1
move 1 from 1 to 8
move 4 from 8 to 1
move 1 from 4 to 6
move 8 from 3 to 9
move 2 from 2 to 3
move 3 from 8 to 5
move 1 from 8 to 2
move 4 from 2 to 7
move 5 from 9 to 7
move 1 from 6 to 3
move 4 from 2 to 4
move 23 from 7 to 5
move 4 from 1 to 2
move 3 from 9 to 6
move 2 from 4 to 8
move 2 from 8 to 3
move 2 from 6 to 1
move 1 from 6 to 8
move 8 from 5 to 3
move 5 from 2 to 6
move 5 from 6 to 3
move 1 from 8 to 3
move 4 from 4 to 7
move 15 from 5 to 2
move 1 from 1 to 9
move 2 from 5 to 1
move 4 from 3 to 7
move 1 from 4 to 9
move 4 from 7 to 1
move 2 from 5 to 6
move 7 from 1 to 2
move 6 from 2 to 3
move 16 from 2 to 5
move 1 from 6 to 3
move 1 from 6 to 3
move 9 from 7 to 4
move 6 from 4 to 6
move 1 from 9 to 8
move 23 from 3 to 9
move 1 from 3 to 4
move 3 from 4 to 5
move 9 from 5 to 2
move 6 from 9 to 7
move 7 from 7 to 5
move 5 from 5 to 3
move 1 from 4 to 6
move 3 from 3 to 8
move 6 from 2 to 1
move 3 from 5 to 6
move 4 from 7 to 1
move 2 from 3 to 9
move 5 from 6 to 8
move 19 from 9 to 6
move 1 from 9 to 2
move 9 from 5 to 9
move 4 from 8 to 3
move 5 from 6 to 1
move 4 from 6 to 1
move 2 from 3 to 8
move 17 from 1 to 7
move 2 from 1 to 2
move 6 from 6 to 9
move 4 from 8 to 5
move 3 from 8 to 2
move 3 from 5 to 6
move 4 from 6 to 8
move 2 from 6 to 9
move 4 from 8 to 7
move 9 from 9 to 5
move 5 from 9 to 4
move 7 from 2 to 8
move 1 from 2 to 1
move 3 from 6 to 5
move 6 from 8 to 5
move 1 from 3 to 4
move 1 from 3 to 1
move 12 from 7 to 2
move 5 from 2 to 7
move 8 from 7 to 5
move 1 from 9 to 3
move 5 from 2 to 8
move 3 from 6 to 3
move 2 from 2 to 3
move 1 from 2 to 4
move 2 from 3 to 4
move 1 from 1 to 6
move 14 from 5 to 6
move 1 from 8 to 6
move 3 from 3 to 7
move 4 from 7 to 1
move 9 from 4 to 3
move 3 from 1 to 4
move 1 from 1 to 2
move 1 from 8 to 4
move 8 from 3 to 1
move 1 from 3 to 2
move 5 from 7 to 6
move 3 from 1 to 6
move 2 from 2 to 8
move 13 from 5 to 3
move 5 from 1 to 3
move 3 from 4 to 5
move 1 from 9 to 2
move 4 from 3 to 9
move 1 from 1 to 7
move 2 from 5 to 8
move 1 from 7 to 5
move 2 from 5 to 4
move 1 from 2 to 6
move 1 from 4 to 5
move 7 from 3 to 6
move 31 from 6 to 1
move 25 from 1 to 7
move 2 from 3 to 2
move 13 from 7 to 9
move 1 from 1 to 6
move 1 from 4 to 1
move 2 from 2 to 9
move 1 from 4 to 6
move 3 from 7 to 1
move 7 from 8 to 3
move 1 from 8 to 2
move 1 from 2 to 8
move 4 from 3 to 4
move 1 from 8 to 7
move 3 from 6 to 9
move 5 from 7 to 6
move 1 from 4 to 7
move 5 from 7 to 9
move 5 from 3 to 6
move 3 from 4 to 7
move 1 from 5 to 4
move 4 from 7 to 9
move 32 from 9 to 1
move 1 from 6 to 5
move 1 from 5 to 9
move 4 from 3 to 8
move 5 from 1 to 4
move 4 from 4 to 9
move 6 from 1 to 7
move 4 from 9 to 8
move 4 from 7 to 8
move 1 from 7 to 1
move 1 from 7 to 6
move 7 from 6 to 3
move 1 from 9 to 5
move 2 from 4 to 7
move 25 from 1 to 6
move 1 from 7 to 1
move 1 from 3 to 4
move 18 from 6 to 8
move 1 from 5 to 1
move 3 from 1 to 6
move 21 from 8 to 3
move 1 from 8 to 4
move 2 from 4 to 2
move 1 from 8 to 1
move 1 from 7 to 6
move 5 from 6 to 3
move 30 from 3 to 1
move 4 from 8 to 6
move 1 from 2 to 9
move 1 from 8 to 5
move 9 from 6 to 5
move 2 from 8 to 7
move 3 from 5 to 9
move 2 from 3 to 4
move 1 from 2 to 1
move 1 from 5 to 8
move 1 from 8 to 3
move 2 from 4 to 6
move 1 from 3 to 1
move 1 from 5 to 6
move 5 from 5 to 7
move 4 from 6 to 8
move 3 from 8 to 2
move 1 from 1 to 5
move 1 from 8 to 7
move 4 from 9 to 6
move 1 from 5 to 1
move 4 from 6 to 8
move 6 from 7 to 3
move 4 from 3 to 9
move 2 from 2 to 7
move 1 from 3 to 5
move 3 from 7 to 6
move 2 from 9 to 8
move 1 from 2 to 4
move 1 from 3 to 4
move 5 from 8 to 4
move 1 from 9 to 2
move 1 from 7 to 5
move 3 from 4 to 5
move 1 from 9 to 1
move 1 from 2 to 7
move 1 from 7 to 1
move 5 from 5 to 4
move 4 from 1 to 4
move 19 from 1 to 9
move 6 from 6 to 2
move 12 from 9 to 1
move 1 from 8 to 6
move 1 from 9 to 4
move 4 from 4 to 8
move 1 from 6 to 5
move 1 from 5 to 3
move 2 from 8 to 9
move 5 from 4 to 6
move 5 from 9 to 4
move 1 from 4 to 3
move 2 from 2 to 9
move 1 from 6 to 5
move 1 from 6 to 9
move 7 from 1 to 5
move 1 from 3 to 1
move 2 from 8 to 3
move 1 from 5 to 7
move 2 from 9 to 8''';
}