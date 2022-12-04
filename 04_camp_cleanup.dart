class Tuple<T> {
  final T first;
  final T second;

  Tuple(this.first, this.second);
}

class AssignmentPair {
  final int from;
  final int to;

  AssignmentPair(this.from, this.to);

  bool contains(AssignmentPair other) {
    return (from <= other.from && to >= other.to);
  }

  bool overlaps(AssignmentPair other) {
    return (to >= other.from && to <= other.to) || (other.to >= from && other.to <= to);    
  }
}

void main() {
  final int part1Result = part1();
  assert(part1Result == 599);
  final int part2Result = part2();
  assert(part2Result == 928);

  print('part1: $part1Result');
  print('part2: $part2Result');
}

int part1() {
  int count = 0;
  final List<Tuple<AssignmentPair>> tuples = parseInput(input());
  for (var tuple in tuples) {
    if (tuple.first.contains(tuple.second) || tuple.second.contains(tuple.first)) {
      count++;
    }
  }

  return count;
}

int part2() {
  int count = 0;
  final List<Tuple<AssignmentPair>> tuples = parseInput(input());
  for (var tuple in tuples) {
    if (tuple.first.overlaps(tuple.second)) {
      count++;
    }
  }

  return count;
}

List<Tuple<AssignmentPair>> parseInput(String input) {
  return input.split('\n')
    .map((line) {
      final List<String> pairs = line.split(',');
      final List<String> pair1 = pairs[0].split('-');
      final List<String> pair2 = pairs[1].split('-');
      final ap1 = AssignmentPair(int.parse(pair1[0]), int.parse(pair1[1]));
      final ap2 = AssignmentPair(int.parse(pair2[0]), int.parse(pair2[1]));
      return Tuple(ap1, ap2);
    }).toList();
}


String exampleInput() {
  return '''
2-4,6-8
2-3,4-5
5-7,7-9
2-8,3-7
6-6,4-6
2-6,4-8''';
}

String input() {
  return '''
14-98,14-14
2-20,3-3
64-67,43-63
13-91,14-90
19-47,12-19
26-74,26-84
23-41,22-41
46-67,41-66
8-42,11-42
4-23,24-26
3-38,18-37
82-84,1-83
2-98,3-98
53-98,53-54
18-80,18-34
83-89,9-83
20-90,19-91
4-32,31-70
25-59,48-58
54-55,54-91
2-28,4-36
21-66,21-66
23-78,23-61
43-98,43-43
21-62,20-78
81-91,78-82
21-21,20-22
62-68,63-67
80-83,30-87
4-88,81-93
48-53,49-85
49-93,48-94
91-99,4-91
71-71,70-71
95-99,11-96
12-99,99-99
14-40,13-41
9-91,9-9
17-92,7-35
71-96,94-97
97-97,19-92
7-64,7-65
28-79,42-55
16-99,15-97
75-77,76-78
5-92,6-80
19-37,5-64
19-25,2-26
42-43,7-43
16-49,15-17
10-49,49-50
33-91,34-91
23-97,22-96
8-97,8-75
97-97,3-98
71-72,19-71
2-4,3-99
5-33,33-40
23-34,22-35
17-98,11-98
82-82,82-91
35-63,7-62
3-89,88-91
85-95,60-85
84-86,39-85
83-83,82-85
39-60,40-60
34-83,12-96
6-97,7-94
89-94,1-90
57-81,8-78
11-12,12-88
75-97,14-89
53-87,52-88
23-45,22-86
32-78,31-78
48-81,49-80
28-28,11-29
49-84,49-83
19-24,20-26
22-32,22-31
41-51,26-46
2-93,2-93
24-33,27-81
94-94,8-94
49-51,50-96
17-98,16-99
9-85,12-84
29-84,30-70
1-99,4-98
7-87,6-8
7-58,19-78
4-94,3-5
2-99,1-1
8-57,2-77
19-57,20-57
73-73,38-74
33-99,26-98
32-64,45-65
3-89,1-99
35-78,34-78
32-58,32-57
6-98,85-88
68-85,72-95
2-92,2-92
10-41,9-74
4-43,1-39
14-72,42-72
86-99,1-99
20-48,20-47
86-98,49-87
43-52,42-52
85-90,68-85
3-27,2-27
90-90,42-91
2-94,2-95
24-81,23-99
77-87,78-87
15-90,90-91
48-90,49-90
72-97,9-67
74-96,36-95
97-98,17-97
24-48,16-47
54-89,55-65
7-15,6-36
11-22,10-23
19-87,17-71
6-87,6-86
83-87,24-52
2-90,90-90
5-68,63-94
10-87,87-88
37-88,37-89
1-94,3-93
48-89,89-91
21-94,20-21
36-99,11-96
23-23,21-23
6-69,4-68
9-79,8-78
14-98,14-98
99-99,98-99
59-99,59-64
22-22,22-98
70-70,69-98
5-63,6-64
27-87,28-28
87-87,51-87
21-97,20-98
68-81,69-81
5-46,46-47
28-62,63-72
15-61,32-91
2-88,2-93
85-85,7-85
2-95,2-95
23-78,22-78
27-66,28-65
11-69,10-70
70-76,31-86
20-27,26-27
42-73,5-43
41-62,42-61
22-50,22-93
61-79,79-79
69-97,69-96
84-92,18-85
17-90,74-91
87-87,2-88
14-90,14-90
64-75,1-76
35-35,34-98
32-39,36-40
35-50,34-49
9-71,11-72
62-79,56-78
2-98,59-99
42-96,43-95
16-85,17-84
5-97,96-99
20-44,21-43
31-97,46-96
16-69,15-63
96-97,37-96
15-21,16-55
42-43,42-94
37-77,37-76
39-43,22-49
7-9,5-9
26-26,25-75
6-84,5-85
9-9,9-45
96-99,13-96
28-58,27-58
34-55,18-55
34-70,35-69
20-80,20-80
10-89,9-90
59-83,8-59
9-92,20-92
66-81,65-77
5-96,78-92
15-68,15-99
48-77,48-97
69-89,28-70
23-74,15-75
25-96,25-98
87-90,70-87
30-32,31-31
35-99,18-98
1-58,25-78
46-95,94-94
12-98,12-99
36-62,35-63
68-73,67-69
12-44,11-44
13-93,77-95
31-32,24-31
44-95,34-96
20-75,9-21
26-68,2-25
95-98,69-95
93-98,12-94
28-42,29-29
4-82,5-82
35-75,3-76
6-15,8-14
51-96,14-96
77-80,41-70
95-96,94-97
57-68,58-69
73-95,66-74
27-45,46-60
3-16,13-27
2-82,2-83
17-92,17-95
16-34,20-70
25-97,3-98
3-91,4-91
16-99,15-97
20-99,2-99
78-89,79-89
82-89,81-82
3-40,2-19
97-98,39-70
3-82,5-85
8-15,7-11
17-44,32-52
19-45,19-65
31-97,32-75
2-97,2-96
30-31,30-84
38-57,37-84
41-74,42-42
81-81,50-82
5-94,5-94
59-87,11-88
8-83,7-84
22-96,22-95
3-75,1-99
3-56,2-56
12-87,4-88
8-63,63-64
15-62,14-61
43-88,42-89
23-24,23-90
1-92,92-94
28-73,29-29
76-76,27-75
76-76,13-77
32-78,32-79
60-98,60-98
64-70,41-69
14-59,14-59
46-98,3-99
29-62,62-97
18-95,36-96
84-85,27-85
16-18,17-44
33-72,53-71
47-91,27-28
35-88,35-87
2-6,1-3
84-86,73-85
5-99,4-87
4-5,5-92
11-66,11-67
4-42,5-48
28-93,29-92
2-50,3-49
37-87,87-87
14-90,97-99
74-95,74-94
25-74,22-73
47-99,47-93
8-86,7-87
33-99,32-34
50-51,35-50
91-97,15-92
41-93,37-45
53-53,52-98
33-60,38-64
1-92,1-80
4-56,4-68
42-64,43-73
68-75,69-69
36-78,36-37
11-63,10-63
87-92,33-92
7-73,6-74
2-2,1-94
1-29,10-41
95-95,94-94
3-12,12-12
10-61,11-60
91-98,79-79
15-15,14-73
18-58,19-58
14-14,13-13
14-71,70-70
26-81,25-82
57-90,57-88
30-90,1-91
9-99,10-10
27-83,78-85
20-84,9-85
10-86,9-86
9-70,5-10
9-88,8-10
1-97,96-96
3-97,4-30
64-84,3-64
7-93,4-6
81-88,81-81
7-55,55-57
10-98,9-98
16-96,17-96
58-87,58-86
14-55,56-56
26-27,26-97
43-55,54-96
10-50,9-50
22-99,24-71
1-96,1-97
1-3,2-30
18-91,90-94
16-30,16-29
23-48,25-73
43-68,76-76
25-82,26-26
9-40,52-60
19-72,19-71
85-89,92-95
5-73,4-74
53-93,54-93
16-81,12-82
26-92,27-91
33-99,54-62
3-66,4-71
26-87,25-88
19-50,19-49
16-35,15-70
18-73,19-72
36-68,35-69
2-75,3-88
10-81,9-81
6-91,5-87
50-59,50-50
15-15,15-87
4-63,3-64
25-77,26-77
8-50,9-98
73-74,26-74
71-83,82-84
56-94,29-93
11-30,11-29
36-64,35-64
56-67,57-67
84-99,11-84
54-92,54-91
14-68,67-88
11-11,10-96
35-37,30-46
3-51,47-64
39-42,29-43
53-70,54-70
19-63,18-35
76-89,76-92
21-92,20-22
19-57,19-58
8-56,7-56
46-94,98-98
93-98,50-92
12-93,28-92
92-98,71-93
52-84,53-53
93-93,20-93
4-92,5-92
10-51,9-51
37-88,38-87
5-48,3-6
22-49,21-49
19-75,18-61
5-60,7-60
6-28,5-19
55-85,54-85
44-59,32-63
12-27,11-45
17-18,18-96
62-67,77-84
78-87,4-79
10-69,9-78
8-78,8-9
58-62,36-57
54-54,53-97
50-50,49-96
19-98,18-19
42-93,41-94
20-21,21-67
51-80,41-52
21-79,20-79
30-84,31-83
69-74,59-98
32-33,34-53
10-43,11-67
7-47,25-68
3-75,4-74
78-96,46-91
12-39,11-98
12-82,12-81
4-71,10-83
22-22,22-71
24-66,66-73
18-77,18-79
57-57,58-58
66-98,66-86
26-26,26-96
44-48,43-49
5-21,12-68
1-99,99-99
91-91,31-92
6-97,3-98
6-94,6-6
8-89,8-49
5-94,4-95
33-42,34-41
79-80,78-80
12-95,99-99
66-66,53-66
19-98,9-99
39-39,40-62
29-71,4-83
24-59,24-57
81-98,42-81
44-45,12-44
2-97,97-97
5-80,4-47
14-81,14-81
3-56,22-32
73-83,72-72
7-26,26-27
92-96,58-93
10-90,42-91
22-32,22-33
1-74,52-74
40-91,40-92
6-95,7-95
6-6,5-7
3-92,94-98
1-85,84-89
25-73,29-82
3-37,4-4
67-89,40-65
28-79,27-63
15-57,9-56
18-51,19-51
50-99,36-50
29-79,30-93
27-27,24-28
33-89,32-90
22-93,21-81
51-79,78-79
20-68,67-79
3-95,3-94
43-44,42-45
4-79,3-80
4-95,14-94
57-60,26-57
23-86,23-85
28-82,32-83
28-53,29-29
3-95,4-94
59-69,58-77
40-91,14-86
19-30,20-29
98-98,2-98
68-99,98-98
43-88,42-89
5-14,8-14
50-52,46-68
29-56,30-55
1-94,93-94
57-88,56-87
99-99,75-76
24-43,24-51
8-98,7-9
30-85,21-30
6-92,1-93
79-80,48-79
71-73,68-72
33-98,33-53
20-99,19-21
48-84,6-41
81-81,80-86
71-91,70-92
7-7,7-99
17-17,16-97
2-12,1-1
17-30,30-31
66-66,65-96
15-66,16-16
8-80,81-88
28-69,17-77
37-37,37-89
47-80,46-90
48-98,47-77
56-66,56-97
51-51,3-52
11-93,24-89
12-92,62-93
63-91,78-85
3-59,4-87
35-61,36-61
36-78,36-79
61-94,2-62
1-90,11-90
40-89,52-82
23-23,22-22
6-51,2-6
51-93,50-93
16-94,94-97
28-58,42-87
83-94,19-81
28-84,29-84
34-95,33-95
10-93,10-54
2-80,4-79
56-57,56-58
52-75,51-66
69-78,70-71
26-87,26-87
13-14,14-51
5-99,5-92
61-62,3-62
26-80,20-81
6-75,74-94
86-98,12-66
57-61,15-63
78-86,45-85
3-89,4-90
42-42,43-64
3-97,3-94
80-96,79-79
20-84,20-20
89-89,1-90
58-85,58-58
17-54,17-54
19-70,16-76
5-8,5-82
25-99,52-85
3-95,11-96
14-86,1-15
52-69,26-99
4-18,16-31
23-73,1-74
53-53,53-74
22-55,22-56
13-58,1-13
4-55,51-68
27-99,28-28
10-58,10-58
40-84,47-75
63-93,62-94
76-78,69-84
24-76,64-75
70-90,65-89
5-88,4-73
34-79,35-78
10-27,11-26
11-13,14-31
29-29,29-99
46-75,19-83
11-84,12-60
4-84,4-83
56-79,55-80
2-54,3-46
13-24,95-99
24-95,27-95
60-76,76-76
27-70,27-28
47-48,3-47
2-92,3-42
1-31,3-69
1-97,1-96
94-96,25-95
23-81,22-81
9-71,10-83
37-88,37-89
8-8,9-87
94-95,59-94
76-95,12-96
12-63,28-94
5-98,4-98
1-94,2-93
74-75,75-86
6-24,23-87
2-91,1-1
21-61,60-60
84-93,34-97
63-81,60-80
3-97,4-4
88-94,18-82
1-96,96-97
1-64,1-64
58-90,40-74
12-99,12-99
65-98,98-99
6-89,68-74
65-89,89-89
2-94,10-97
4-71,80-87
10-10,10-27
60-95,95-96
28-80,79-89
9-80,9-80
69-72,70-82
26-26,27-27
19-97,97-99
32-75,33-89
11-59,10-60
38-42,27-42
18-49,18-42
26-72,25-26
7-35,1-11
32-33,32-33
50-81,5-51
7-20,3-51
10-87,4-71
35-82,28-33
6-16,15-84
28-84,85-85
27-90,66-95
76-91,68-75
15-87,14-16
7-81,8-87
9-89,8-9
14-14,15-89
5-90,3-91
81-84,22-83
9-44,6-8
57-57,51-58
27-97,26-97
3-81,2-82
7-66,20-66
52-85,53-86
61-99,62-99
30-31,31-95
52-91,53-90
41-43,42-96
65-65,47-67
13-13,12-87
23-26,23-27
83-85,49-84
11-16,10-60
16-84,7-83
85-85,32-85
51-59,59-86
18-59,19-61
92-94,18-93
97-97,3-97
21-21,3-22
23-25,24-24
5-73,5-72
43-44,9-44
74-87,75-81
72-78,72-82
40-88,40-48
7-91,7-8
39-52,40-97
20-52,21-93
11-88,44-76
90-98,32-39
35-86,36-36
78-95,67-79
11-22,12-72
41-94,94-95
90-91,52-90
8-83,9-83
57-96,12-96
34-42,23-43
68-99,69-99
24-92,23-74
6-81,2-82
23-23,24-58
46-74,46-73
17-32,3-32
35-82,34-74
19-98,20-98
33-81,38-80
48-62,6-82
10-90,89-89
81-82,40-81
14-99,13-15
58-92,59-67
30-72,9-72
17-89,88-88
22-66,7-66
5-32,32-63
6-80,5-80
35-91,91-91
65-70,7-79
4-77,5-77
75-76,6-76
4-88,4-89
37-91,90-90
9-79,8-78
3-3,2-98
52-66,53-95
37-49,49-55
1-99,1-86
55-67,54-56
6-89,7-89
51-71,52-85
4-89,3-89
8-9,9-90
4-57,5-5
8-70,27-69
4-93,5-96
18-18,17-19
13-14,13-86
86-98,23-98
21-47,22-47
4-31,2-5
12-55,12-56
23-42,27-27
40-81,45-76
12-93,13-93
12-68,32-67
3-96,4-98
38-77,37-77
10-10,10-63
64-85,63-85
26-99,27-98
6-75,7-49
3-65,3-3
26-66,66-66
23-61,4-48
34-36,33-35
70-93,93-93
31-98,32-99
33-34,33-58
72-84,72-85
9-64,58-86
55-85,85-94
90-91,68-90
13-15,15-85
66-67,66-84
1-87,3-99
2-82,15-81
19-46,20-31
24-75,25-75
62-80,66-81
34-69,34-70
2-76,3-3
20-72,71-72
1-50,37-38
2-18,3-18
5-79,6-97
20-87,6-88
83-83,61-84
39-40,40-40
1-96,2-84
48-94,42-79
22-22,22-98
7-10,9-98
66-77,66-88
47-52,40-52
6-19,6-26
3-64,2-63
44-82,22-45
5-96,4-96
2-98,1-1
13-86,43-85
14-91,14-90
13-50,7-62
90-90,7-90
8-33,7-17
35-62,36-63
37-48,17-56
69-97,69-97
74-75,29-74
55-72,55-72
28-73,28-55
22-77,22-76
77-83,67-83
54-72,53-53
51-95,50-51
85-99,82-87
87-93,4-87
16-82,23-82
3-56,2-57
19-65,20-63
1-92,59-93
76-89,21-77
89-99,10-90
13-93,96-96
54-84,84-85
80-80,71-81
9-99,9-78
11-94,10-89
8-61,9-92
80-97,81-96
84-85,83-84
71-85,71-86
37-98,36-99
17-96,71-96
63-63,6-63
13-70,1-69
8-9,5-8
60-84,60-61
85-92,85-92
46-79,45-79
69-74,68-74
8-85,9-84
83-88,86-89
54-54,54-76
34-36,33-34
1-73,2-99
54-60,53-61
66-95,66-66
21-82,82-82
3-3,2-35
76-92,75-75
24-85,85-88
51-51,18-50
4-22,1-21
76-93,77-89
84-94,88-91
48-93,14-94
25-57,31-74
38-38,38-52
86-86,5-87
15-51,14-51
2-51,13-50
14-21,21-22
20-89,19-90
75-82,75-75
55-68,56-88
4-99,3-97
62-66,46-66
46-93,92-92
2-80,1-81
3-64,3-3
16-47,17-47
19-48,18-64
6-85,7-7
92-97,73-92
37-52,21-53
3-43,42-42
74-99,23-94
24-48,54-58
44-91,93-97
16-94,16-95
7-93,8-93
7-91,90-91
28-86,10-87
13-44,13-45
21-98,26-97
6-97,7-98
49-75,49-75
50-98,50-50
5-6,5-5
15-40,40-41
14-96,6-97
13-67,14-67
4-92,4-92
4-79,3-78
90-96,14-90
24-24,14-24
12-90,12-91
30-69,30-30
30-46,31-31
12-81,11-82
4-86,3-87
46-76,46-80
12-81,13-83
91-96,1-91
32-40,33-33
7-97,4-96
46-46,47-52
56-56,56-56
12-12,11-72
5-5,4-60
9-91,83-93
30-94,30-94
35-41,41-98
54-54,53-95
76-77,62-76
43-62,42-62
66-79,51-93
67-91,27-67
3-43,3-57
5-67,5-96
53-88,54-88
64-74,72-72
34-63,35-88
57-77,57-75
43-53,42-53
14-26,21-27
8-75,65-69
15-42,41-90
15-87,89-93
83-83,18-84
13-43,43-44
69-71,69-76
6-8,9-89
17-75,18-18
75-83,44-76
18-96,19-62
11-54,12-88
90-90,80-90
10-79,9-9
30-97,30-97
3-87,2-2
4-33,8-96
54-97,53-98
21-21,20-90
31-96,1-95
4-99,60-99
32-42,31-47
23-65,23-66
41-64,3-64
22-65,15-46
86-93,85-86
10-77,9-77
20-25,21-24
2-86,85-88
46-46,47-55
2-14,2-82
29-38,33-37
77-81,78-97
1-89,88-98
95-99,65-96
12-12,8-13
2-59,1-59
54-54,55-68
4-97,53-98
5-96,54-96
11-93,11-43
65-87,64-64
35-73,35-74
8-9,9-30
49-69,49-49
57-64,1-58
46-98,47-97
5-84,92-96
7-13,6-46
2-50,6-50
66-94,72-95
16-16,16-84
69-85,68-80
13-30,12-75
28-29,29-78
44-79,45-92
9-63,15-62
8-87,7-28
24-83,83-86
59-64,60-60
24-87,24-24
54-58,47-57
27-38,13-37
14-15,15-71
76-85,73-85
7-17,6-90
4-95,5-96
16-77,17-25
32-63,39-63
30-74,52-75
51-99,98-99
72-87,72-87
2-87,3-88
1-29,6-89
20-61,32-64
64-91,63-91
10-11,10-54
2-70,2-2
72-83,72-82
7-63,13-99
66-93,67-92''';
}