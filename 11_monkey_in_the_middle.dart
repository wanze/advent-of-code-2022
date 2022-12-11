class Monkey {
  late List<int> items;
  late int Function(int worryLevel) operation;
  late int divideBy;
  late int monkeyIndexTrue;
  late int monkeyIndexFalse;
}

void main() {
  final int part1Result = part1();
  final int part2Result = part2();
  
  assert(part1Result == 62491);
  assert(part2Result == 17408399184);

  print('part1: $part1Result');
  print('part2: $part2Result');
}

int part1() {
  final List<Monkey> monkeys = parseInput(input());

  return monkeyBusinessLevel(20, monkeys, (worryLevel) => (worryLevel / 3).floor());
}

int part2() {
  final List<Monkey> monkeys = parseInput(input());
  
  int leastCommonMultiple = 1;
  for (var monkey in monkeys) {
    leastCommonMultiple *= monkey.divideBy;
  }

  return monkeyBusinessLevel(10000, monkeys, (worryLevel) => worryLevel % leastCommonMultiple);
}

int monkeyBusinessLevel(int rounds, List<Monkey> monkeys, int Function(int worryLevel) decreaseWorryLevel) {
  List<int> inspectedItems = List.generate(monkeys.length, (index) => 0);
  
  for (int round = 1; round <= rounds; round++) {
    for (int m = 0; m < monkeys.length; m++) {
      final Monkey monkey = monkeys[m];
      inspectedItems[m] += monkey.items.length;

      for (int item in monkey.items) {
        int worryLevel = monkey.operation(item);
        worryLevel = decreaseWorryLevel(worryLevel);
        int throwToIndex = worryLevel % monkey.divideBy == 0 ? monkey.monkeyIndexTrue : monkey.monkeyIndexFalse;
        monkeys[throwToIndex].items.add(worryLevel);
      }
      monkey.items = [];
    }
  }

  inspectedItems.sort((a, b) => b.compareTo(a));

  return inspectedItems[0] * inspectedItems[1];
}

List<Monkey> parseInput(String input) {
  List<Monkey> monkeys = [];

  late Monkey currentMonkey;
  for (String line in input.split('\n')) {
    if (line.startsWith('Monkey')) {
      currentMonkey = Monkey();
    } else if (line.contains('Starting items')) {
      String items = line.split(':')[1].trim();
      currentMonkey.items = items.split(', ').map((i) => int.parse(i)).toList();
    } else if (line.contains('Operation:')) {
      String operation = line.split('=')[1].trim();
      List<String> operands = operation.split(' ');
      currentMonkey.operation = (int worryLevel) {
        int value = operands[2] == 'old' ? worryLevel : int.parse(operands[2]);
        if (operands[1] == '*') {
          return worryLevel * value;
        }
        return worryLevel + value;
      };
    } else if (line.contains('Test:')) {
      List<String> parts = line.split(' ');
      currentMonkey.divideBy = int.parse(parts[parts.length - 1]);
    } else if (line.contains('If true:')) {
      List<String> parts = line.split(' ');
      currentMonkey.monkeyIndexTrue = int.parse(parts[parts.length - 1]);
    } else if (line.contains('If false:')) {
      List<String> parts = line.split(' ');
      currentMonkey.monkeyIndexFalse = int.parse(parts[parts.length - 1]);
    } else {
      monkeys.add(currentMonkey);
    }
  }
  monkeys.add(currentMonkey);

  return monkeys;
}

String exampleInput() {
  return '''
Monkey 0:
  Starting items: 79, 98
  Operation: new = old * 19
  Test: divisible by 23
    If true: throw to monkey 2
    If false: throw to monkey 3

Monkey 1:
  Starting items: 54, 65, 75, 74
  Operation: new = old + 6
  Test: divisible by 19
    If true: throw to monkey 2
    If false: throw to monkey 0

Monkey 2:
  Starting items: 79, 60, 97
  Operation: new = old * old
  Test: divisible by 13
    If true: throw to monkey 1
    If false: throw to monkey 3

Monkey 3:
  Starting items: 74
  Operation: new = old + 3
  Test: divisible by 17
    If true: throw to monkey 0
    If false: throw to monkey 1''';
}

String input() {
  return '''
Monkey 0:
  Starting items: 75, 63
  Operation: new = old * 3
  Test: divisible by 11
    If true: throw to monkey 7
    If false: throw to monkey 2

Monkey 1:
  Starting items: 65, 79, 98, 77, 56, 54, 83, 94
  Operation: new = old + 3
  Test: divisible by 2
    If true: throw to monkey 2
    If false: throw to monkey 0

Monkey 2:
  Starting items: 66
  Operation: new = old + 5
  Test: divisible by 5
    If true: throw to monkey 7
    If false: throw to monkey 5

Monkey 3:
  Starting items: 51, 89, 90
  Operation: new = old * 19
  Test: divisible by 7
    If true: throw to monkey 6
    If false: throw to monkey 4

Monkey 4:
  Starting items: 75, 94, 66, 90, 77, 82, 61
  Operation: new = old + 1
  Test: divisible by 17
    If true: throw to monkey 6
    If false: throw to monkey 1

Monkey 5:
  Starting items: 53, 76, 59, 92, 95
  Operation: new = old + 2
  Test: divisible by 19
    If true: throw to monkey 4
    If false: throw to monkey 3

Monkey 6:
  Starting items: 81, 61, 75, 89, 70, 92
  Operation: new = old * old
  Test: divisible by 3
    If true: throw to monkey 0
    If false: throw to monkey 1

Monkey 7:
  Starting items: 81, 86, 62, 87
  Operation: new = old + 8
  Test: divisible by 13
    If true: throw to monkey 3
    If false: throw to monkey 5''';
}