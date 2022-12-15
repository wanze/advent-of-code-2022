import 'package:collection/collection.dart';

class Node {
  final int x;
  final int y;
  final int height;
  int fScore = 0;

  Node(this.x, this.y, this.height);

  @override
  bool operator ==(Object other) =>
    identical(this, other) ||
    other is Node &&
    runtimeType == other.runtimeType &&
    x == other.x &&
    y == other.y;

  @override
  int get hashCode => Object.hashAll([x, y]);

  @override
  String toString() {
    return '[x=$x, y=$y, h=$height, fScore=$fScore]';
  }
}

class Input {
  final Node start;
  final Node end;
  final List<List<Node>> nodes;

  Input(this.start, this.end, this.nodes);
}

void main() {
  final int part1Result = part1();
  final int part2Result = part2();
  
  assert(part1Result == 484);
  assert(part2Result == 478);

  print('part1: $part1Result');
  print('part2: $part2Result');
}

int part1() {
  final Input input = parseInput(puzzleInput());

  return aStar(input.start, input.end, input.nodes) ?? -1;
}

int part2() {
  final Input input = parseInput(puzzleInput());

  final List<int> paths = [];
  for (int y = 0; y < input.nodes.length; y++) {
    for (int x = 0; x < input.nodes[0].length; x++) {
      final Node node = input.nodes[y][x];
      if (node.height == 0) {
        int? pathLength = aStar(node, input.end, input.nodes);
        if (pathLength != null) {
          paths.add(pathLength);
        }
      }
    }
  }

  paths.sort((a, b) => a.compareTo(b));

  return paths.first;
}

int? aStar(Node start, Node goal, List<List<Node>> nodes) {
  PriorityQueue<Node> open = PriorityQueue((a, b) => a.fScore.compareTo(b.fScore));
  open.add(start);
  Map<Node, Node> cameFrom = {};
  Map<Node, int> gScore = {};
  Map<Node, int> fScore = {};

  for (int y = 0; y < nodes.length; y++) {
    for (int x = 0; x < nodes[0].length; x++) {
      fScore[nodes[y][x]] = 100000000;
      gScore[nodes[y][x]] = 100000000;
    }
  }
  gScore[start] = 0;
  fScore[start] = 0;

  List<Node> neighbours(Node n) {
    List<Node> neighbours = [];
    if (n.y >= 1 && (nodes[n.y - 1][n.x].height <= n.height + 1)) {
      neighbours.add(nodes[n.y - 1][n.x]);
    }
    if (n.y < nodes.length - 1 && (nodes[n.y + 1][n.x].height <= n.height + 1)) {
      neighbours.add(nodes[n.y + 1][n.x]);
    }
    if (n.x >= 1 && (nodes[n.y][n.x - 1].height <= n.height + 1)) {
      neighbours.add(nodes[n.y][n.x - 1]);
    }
    if (n.x < nodes[0].length - 1 && (nodes[n.y][n.x + 1].height <= n.height + 1)) {
      neighbours.add(nodes[n.y][n.x + 1]);
    }

    return neighbours;
  }

  List<Node> buildPath(Node current) {
    final List<Node> p = [];
    while (cameFrom.containsKey(current)) {
      current = cameFrom[current]!;
      p.add(current);
    }

    return p.reversed.toList();
  }

  while (open.isNotEmpty) {
    Node current = open.removeFirst();
    if (current == goal) {
      return buildPath(current).length;
    }

    for (Node neighbour in neighbours(current)) {
      int tentativeGscore = gScore[current]! + 1;
      if (tentativeGscore < gScore[neighbour]!) {
        cameFrom[neighbour] = current;
        gScore[neighbour] = tentativeGscore;
        fScore[neighbour] = tentativeGscore + 1;
        neighbour.fScore = tentativeGscore + 1;
        open.add(neighbour);
      }
    }
  }

  return null;
}

Input parseInput(String input) {
  final List<String> chars = ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z'];
  late Node start;
  late Node end;
  final List<List<Node>> nodes = [];

  int x = 0;
  int y = 0;
  List<Node> xNodes = [];
  for (String line in input.split('\n')) {
    for (String letter in line.split('')) {
      late Node n;
      if (letter == 'S') {
        n = Node(x, y, chars.indexOf('a'));
        start = n;
      } else if (letter == 'E') {
        n = Node(x, y, chars.indexOf('z'));
        end = n;
      } else {
        n = Node(x, y, chars.indexOf(letter));
      }
      xNodes.add(n);
      x++;
    }
    nodes.add(xNodes);
    xNodes = [];
    x = 0;
    y++;
  }

  return Input(start, end, nodes);
}

String exampleInput() {
  return '''
Sabqponm
abcryxxl
accszExk
acctuvwj
abdefghi''';
}

String puzzleInput() {
  return '''
abcccccccccccccccccaaccccccccccccaaaaaaaacccccccccccaaaaaccccaaaaaaccaaaaaaaaaaaaaaaaaccccccccccccccccaaacccccaaaaaaaacccaaaccccccccccccccccccccccccccccccccccccccccccccccccccaaaaa
abccccccccccccccccaaacaacccccccccccaaaacccccccccccccaaaaaacccaaaaaaccaaaaaaaaaaaaaaaaaaaacccccccccaaacaaacccccaaaaaaaaaccaaaaccccccccccccccccccccccccccccccccccccccccccccccccaaaaaa
abcccccccccccccccccaaaaacccccccccccaaaaaccccccccccccaaaaaaccccaaaacccaaaacccaaaaaaaaaaaaacccccccccaaaaaaaaaacccaaaaaaaaccaaaaccccccccccccccccccccccccccccccccccaaacccccccccccaaaaaa
abcccccccccccccccaaaaaacccccccccccaaacaaccaaccccccccaaaaaaccccaaaacccaaaccccaaaaaaaaaaaaaccccccccccaaaaaaaaaccaaaaaacccccaaacccccccccccccccccccccccccccccccccccaaaccccccccccccccaaa
abcccccccccccccccaaaaaaaacccccccccaacccacaaacaacccccccaaccccccaccaccccccccaaaaaaaaaaaaccccccccccccccaaaaaaacccaaaaaaacccccccccccccaacccccccccccccccccccccccccccaaaccccccccccccccaaa
abcccccccccccccccaacaaaaacccccccccccccccccaaaaacccccccccccccccccccccccccccaaaaaaaaaaaaccccccccccccccaaaaaaccccaaccaaacccccccccccaaaaaaccccccccccccccccccccccccccdccccccccccccccccaa
abccaacccccccaaacccaaacaccccccccccaaacccaaaaaaccccccccccccccccccccccccccccaaacccaaaaaacaaaaccccccccaaaaaaaccccccccaaacccccccccccaaaaaacccccccccccccccccllllllcccdddddcccccccccccccc
abaaaacccacccaaccccaacccccccccccccaaacccaaaaaaaacccccccccccccccccaaccccccccacccaaaaccccaaaaccccccccaaacaaaccccccccccccccccccccccaaaaaaccccccccccccccccllllllllldddddddddddccaaccccc
abaaaaccaaaaaaaacccccccccccccccaaaaaaaacaacaaaaacccccccccccccccccaaacccccccaaacaaccccccaaaacccccccccccccaaccccccccccccccccccccccaaaaaccccccccccccccccclllllllllldddddddddeeaaaccccc
abaaaccccaaaaaaaaccccccccaaacccaaaaaaaacccaaacccccccccccccccccaaaaaaaaccccccaaaaacccccccaacccccccccccccccccccccccccccccccccccccccaaaaccccaaaccccccccckllppppplllmmmmmmmdeeeeaaccccc
abaaaacccaaaaaaaaacccccaaaaaaccccaaaaaccccaaccccccccccccccccccaaaaaaaaccccccaaaaaaacccccccccccccccccccccccccccccccccccccccccccccccccccccaaaacccccccckklpppppppplmmmmmmmmmeeeeaccccc
abaaaacccaaaaaaaaacccccaaaaaacccaaaaaaccccccccaacccccccccccccccaaaaaaccccccaaaaaaaacccccccccccccccccccccccccccccccccccccccccccccccccccccaaaacccccccckkkppppppppqmmmmmmmmmmeeeaacccc
abaaaaaccaaaaaaaaccccccaaaaaacccaaaaaaccccccacaaaacccccccccccccaaaaaaccccccaaaaaaaaccccccccaaaaccccccccaaacccccccccccccccccccccccccccccccaaacccccccckkkpppuuuppqqqqqqqqmmmeeeeacccc
abacccccaaaaaaaccccccccaaaaaccccaccaaaccccccaaaaaacccccacccccccaaaaaaccccccaaaaaacaaaccccccaaaaccccccccaaaacccccccccccccccccccccccccccccccccccccccckkkpppuuuuuuqqqqqqqqqnnneeeccccc
abcccccccaccaaaccccccccaaaaacccccccccccccccccaaaacccaaaacccccccaacaaacccccccccaaacaaaaaccccaaaaccccccccaaaaccccccccccccccccccccccccccccccccccccccckkkkpppuuuuuuuqvvvvqqqnnneeeccccc
abcccccccccccaaacaaccccccccccccccccccccccccccaaaacccaaaaaacccccccccccccccccccccccaaaaaaccccaaacccccccccaaaccccccccccccccccccccccccccccccccccccccckkkkrrpuuuxxxuvvvvvvvqqnnneeeccccc
abcccccccccccccccaacaaaccccccccccccccccccccccaacaacccaaaaacccccccccccccccccccccccaaaaaaccccccccccccccccccccccccccccccccccccccccccccccccccccccccckkkkrrrruuxxxxuvvvvvvvqqnnneeeccccc
abcccccccccccccccaaaaacccccccccccccccccccccccccccaccaaaaacccccaaccccccccccccccccccaaaaaccccccccccccccccaaaccccccccccccccaaacccccccccccccccccccckkkkrrrruuuxxxxyyyyyvvvqqnnneecccccc
abcccccccccccccaaaaaacccccccccccaacaacccccccccccaaaaaaaaacccacaaaacaaccaaccccccccaaacaaccccccccccaaccccaaaaaacccaacaacccaaacacccccccccccccccccjjkkrrrruuuuuxxxyyyyyvvqrqnneffcccccc
abcccccccccccccaaaaaaaacccaaacccaaaaaccccccaacccaaaaaaaaacccaaaaaacaaaaaaccccccccaaacaaacccccccaaaaaacaaaaaaacccaaaaacaaaaaaaaccccccccccccccccjjjrrrtttuuxxxxxyyyyyvvrrnnnfffcccccc
SbccccccccccccccccaaaaacccaaaaccaaaaaaccccaaaaaacaaaaaaaaacccaaaacccaaaaaccccccccaaaaaaacccccccaaaaaaaaaaaaaaccaaaaaccaaaaaaaaccccccccccccccccjjjrrrtttxxxEzzzzyyyvvrrrnnnfffcccccc
abccccccccccaaaccaaccaacccaaaaccaaaaaacccccaaaaacaaaaaaaaacccaaaaccaaaaaacccccccccaaaaaaccccccccaaaacaaaaaaacccaaaaaaccaaaaaacccccccccccccccccjjjrrrtttxxxxxyyyyyyvvrrrnnnfffcccccc
abcccccccccaaaaccaacccccccaaacccaaaaaacccaaaaaaaaaaaaaaaaacccaacacaaaaaaaacccccaaaaaaaacccccccccaaaacccaaaaaaccccaaaacccaaaaacccccccccccccccccjjjrrrtttxxxxxyyyyyyywvrrnnnfffcccccc
abcccccccccaaaacccccccccccccccccccaaaccccaaaaaaaaaaaaaaaaaacccccccaaaaaaaacccccaaaaaaaaaccccccccaccacccaaaaaaccccacccccaaaaaacccccccccccccccccjjjrrrrttttxxxyyyyyyywwrrroooffcccccc
abccccccccccaaaccccccccccccccccccccccccccaaaaaaaaaccaaaaaaaccccccccccaaccccccccaaaaaaaaaaccccccccccccccaacccccccccccccccaaccccccccccccccccccccjjjjqqqqttttxxyywwwwwwwwrrooofffccccc
abcccccccccccccccccccccccccccccccccccccccccaaacacccccaaaaccccccccccccaacccccccccccaaacaaacccccccccccccccccccccccccccccaaacccccccccccccccccccaacjjjjqqqqqttwwwwwwwwwwwrrrooofffccccc
abcccccccccccccccccccccccccccccccccccccccccaaccccccccccaacccccccccccccccccccccccccaaacccccccccccccccccccccccccccccccccaaacccccccccccccccccaaaaaajjjjqqqqttwwwwwwsswwrrrrooofffccccc
abcccccaaaaccccccccccccccaacaaccccccccccccccccccccccccccccccccccccccccccccccccccccaacccccccccccccccccccccccccccccccaaaaaaaaccaaaacccccccccaaaaaacjjjiqqqtttwwwwsssssrrrrooofffccccc
abccccaaaaaccccccccccccccaaaaacccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccaaaaaaaaccaaaaacccccccccaaaaacciiiiqqttswwwssssssrrroooogffccccc
abccccaaaaaacccccccccccccaaaaaacccaaaccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccaaaaaccaaaaaaccccccccaaaaacccciiiqqqssssssspppooooooogggaccccc
abccccaaaaaaccccccccaacccaaaaaaccccaacccccccccccccccccccccccccccccccccaaaaccccccccccccccccccccccccccccccccccccccccccaaaaaaccaaaaaaccccccccaaaaaccccciiiqqsssssspppppoooooggggaacccc
abccccaaaaaccccccaaaaacccaaaaaacaacaaaaaccccccccccccccccccccaacccccccaaaaacccccccccccaaaccccccccccccccccccccccccccccaaaaaacccaaaaacccccccccacccccccciiiqqqpssspppppgggggggggaaacccc
abccccccaaacccccccaaaaaccccaaaccaaaaaaaacccccccaacccccccaaccaacccccccaaaaaacccccccccaaaacccccccccccaaaaccccccccccccaaccaaacccaaacccccaaacaaaccccccccciiqqppppppphhhggggggggaaaacccc
abccccccccccccccccaaaaaccccccccccaaaaaccccccccaaacaaccccaaaaaacccccccaaaaaaaccccccccaaaacccccccccccaaaacccccccccaaaaaacccccccccccccccaaaaaaaccccccccciiippppppphhhhggggggcaaacccccc
abaacccccccccccccaaaaaccccccccccccaaaaaccccccccaaaaacccccaaaaaaacccccaaaaacaaacccccccaaacccccccccccaaaacccccccccaaaaacccccccccccccccccaaaaaacccccccccciiiippphhhhhhcccccccaaacccccc
abaacccccccccccccccaaacccccccccccaaacaaccccccaaaaaaccccccaaaaaaacccaaccaaacaaaaccaaaccccccccccccccccaaacccccccccaaaaaaacccccccccccccccaaaaaaaacccccccciiihhhhhhhhaaaccccccccccccccc
abaaccccccccccccccccccccccccccccccaacccccccccaaaaaaaacccaaaaaaccaaaaaacccccaaaacaaaaaccccccccccccccccccccccccccaaaaaaaaccccccccccccccaaaaaaaaaccccccccciihhhhhhcaaaacccccccccccccca
abaaccccccccccccccccccccccccccccccccaacccccccaacaaaaacccaaaaaaccaaaaacccccccaaaaaaaacccccccccccccccccccccccccccaaaaaaaacccccccccaaacaaaaaaaaaacccccccccccchhhaccccaacccccccccccccca
abaaccccccccccccccccccccccccccccccccaaaaaaccccccaaccccccccccaaccaaaaaaacccccaaaaaaaccccccccccccccccccccccccaaaccacaaacccccccccccaaaaaaacaaacaaaaaacccccccccaaacccccccccccccccaaaaaa
abccccccccccccccccccccccccccccccccccaaaaaccccccaaccccccccccccccaaaaaaaacaaaaaaaaaaccccccccccccccccccccccccaaaaaaccaaaccccccccccccaaaaaacaaacaaaaaacccccccccaaaccccccccccccccccaaaaa
abccccccccccccccccccccccccccccccccaaaaaaaacccccccccccccccccccccaaaaaaaacaaaaaaaaaaaaacccccccccccccccccccccaaaaaacccccccccccccccaaaaaaaaaaaaaaaaaacccccccccccccccccccccccccccccaaaaa''';
}