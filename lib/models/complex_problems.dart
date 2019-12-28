import 'dart:convert';

ComplexProblemSet problemSetFromJson(String str) =>
    ComplexProblemSet.fromJson(json.decode(str));

String problemSetToJson(ComplexProblemSet data) => json.encode(data.toJson());

class ComplexProblemSet {
  String status;
  Result result;

  ComplexProblemSet({
    this.status,
    this.result,
  });

  factory ComplexProblemSet.fromJson(Map<String, dynamic> json) =>
      ComplexProblemSet(
        status: json["status"],
        result: Result.fromJson(json["result"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "result": result.toJson(),
      };
}

class Result {
  List<ComplexProblem> problems;
  List<ProblemStatistic> problemStatistics;

  Result({
    this.problems,
    this.problemStatistics,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        problems: List<ComplexProblem>.from(
            json["problems"].map((x) => ComplexProblem.fromJson(x))),
        problemStatistics: List<ProblemStatistic>.from(
            json["problemStatistics"].map((x) => ProblemStatistic.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "problems": List<dynamic>.from(problems.map((x) => x.toJson())),
        "problemStatistics":
            List<dynamic>.from(problemStatistics.map((x) => x.toJson())),
      };
}

class ProblemStatistic {
  int contestId;
  String index;
  int solvedCount;

  ProblemStatistic({
    this.contestId,
    this.index,
    this.solvedCount,
  });

  factory ProblemStatistic.fromJson(Map<String, dynamic> json) =>
      ProblemStatistic(
        contestId: json["contestId"],
        index: json["index"],
        solvedCount: json["solvedCount"],
      );

  Map<String, dynamic> toJson() => {
        "contestId": contestId,
        "index": index,
        "solvedCount": solvedCount,
      };
}

class ComplexProblem {
  int contestId;
  String index;
  String name;
  Type type;
  List<Tag> tags;
  double points;
  int rating;

  ComplexProblem({
    this.contestId,
    this.index,
    this.name,
    this.type,
    this.tags,
    this.points,
    this.rating,
  });

  factory ComplexProblem.fromJson(Map<String, dynamic> json) => ComplexProblem(
        contestId: json["contestId"],
        index: json["index"],
        name: json["name"],
        type: typeValues.map[json["type"]],
        tags: List<Tag>.from(json["tags"].map((x) => tagValues.map[x])),
        points: json["points"] == null ? null : json["points"],
        rating: json["rating"] == null ? null : json["rating"],
      );

  Map<String, dynamic> toJson() => {
        "contestId": contestId,
        "index": index,
        "name": name,
        "type": typeValues.reverse[type],
        "tags": List<dynamic>.from(tags.map((x) => tagValues.reverse[x])),
        "points": points == null ? null : points,
        "rating": rating == null ? null : rating,
      };
}

enum Tag {
  CONSTRUCTIVE_ALGORITHMS,
  STRINGS,
  COMBINATORICS,
  MATH,
  GREEDY,
  IMPLEMENTATION,
  BRUTE_FORCE,
  INTERACTIVE,
  SORTINGS,
  PROBABILITIES,
  GRAPHS,
  DATA_STRUCTURES,
  TWO_POINTERS,
  NUMBER_THEORY,
  FLOWS,
  GRAPH_MATCHINGS,
  DFS_AND_SIMILAR,
  DP,
  TREES,
  DSU,
  BINARY_SEARCH,
  MEET_IN_THE_MIDDLE,
  BITMASKS,
  DIVIDE_AND_CONQUER,
  FFT,
  HASHING,
  GEOMETRY,
  TERNARY_SEARCH,
  SHORTEST_PATHS,
  MATRICES,
  THE_2_SAT,
  GAMES,
  SPECIAL,
  STRING_SUFFIX_STRUCTURES,
  EXPRESSION_PARSING,
  CHINESE_REMAINDER_THEOREM,
  SCHEDULES
}

final tagValues = EnumValues({
  "binary search": Tag.BINARY_SEARCH,
  "bitmasks": Tag.BITMASKS,
  "brute force": Tag.BRUTE_FORCE,
  "chinese remainder theorem": Tag.CHINESE_REMAINDER_THEOREM,
  "combinatorics": Tag.COMBINATORICS,
  "constructive algorithms": Tag.CONSTRUCTIVE_ALGORITHMS,
  "data structures": Tag.DATA_STRUCTURES,
  "dfs and similar": Tag.DFS_AND_SIMILAR,
  "divide and conquer": Tag.DIVIDE_AND_CONQUER,
  "dp": Tag.DP,
  "dsu": Tag.DSU,
  "expression parsing": Tag.EXPRESSION_PARSING,
  "fft": Tag.FFT,
  "flows": Tag.FLOWS,
  "games": Tag.GAMES,
  "geometry": Tag.GEOMETRY,
  "graphs": Tag.GRAPHS,
  "graph matchings": Tag.GRAPH_MATCHINGS,
  "greedy": Tag.GREEDY,
  "hashing": Tag.HASHING,
  "implementation": Tag.IMPLEMENTATION,
  "interactive": Tag.INTERACTIVE,
  "math": Tag.MATH,
  "matrices": Tag.MATRICES,
  "meet-in-the-middle": Tag.MEET_IN_THE_MIDDLE,
  "number theory": Tag.NUMBER_THEORY,
  "probabilities": Tag.PROBABILITIES,
  "schedules": Tag.SCHEDULES,
  "shortest paths": Tag.SHORTEST_PATHS,
  "sortings": Tag.SORTINGS,
  "*special": Tag.SPECIAL,
  "strings": Tag.STRINGS,
  "string suffix structures": Tag.STRING_SUFFIX_STRUCTURES,
  "ternary search": Tag.TERNARY_SEARCH,
  "2-sat": Tag.THE_2_SAT,
  "trees": Tag.TREES,
  "two pointers": Tag.TWO_POINTERS
});

enum Type { PROGRAMMING }

final typeValues = EnumValues({"PROGRAMMING": Type.PROGRAMMING});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
