import 'dart:convert';

ComplexUserData complexUserDataFromJson(String str) =>
    ComplexUserData.fromJson(json.decode(str));

String complexUserDataToJson(ComplexUserData data) =>
    json.encode(data.toJson());

class ComplexUserData {
  Status status;
  String comment;
  List<Result> result;

  ComplexUserData({
    this.status,
    this.result,
    this.comment,
  });

  factory ComplexUserData.fromJson(Map<String, dynamic> json) =>
      ComplexUserData(
        status: statusValues.map[json["status"]],
        comment: json["comment"],
        result:
            List<Result>.from(json["result"].map((x) => Result.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": statusValues.reverse[status],
        "result": List<dynamic>.from(result.map((x) => x.toJson())),
      };
}

class Result {
  int id;
  int contestId;
  int creationTimeSeconds;
  int relativeTimeSeconds;
  UserProblem problem;
  Author author;
  ProgrammingLanguage programmingLanguage;
  Status verdict;
  Testset testset;
  int passedTestCount;
  int timeConsumedMillis;
  int memoryConsumedBytes;

  Result({
    this.id,
    this.contestId,
    this.creationTimeSeconds,
    this.relativeTimeSeconds,
    this.problem,
    this.author,
    this.programmingLanguage,
    this.verdict,
    this.testset,
    this.passedTestCount,
    this.timeConsumedMillis,
    this.memoryConsumedBytes,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        contestId: json["contestId"],
        creationTimeSeconds: json["creationTimeSeconds"],
        relativeTimeSeconds: json["relativeTimeSeconds"],
        problem: UserProblem.fromJson(json["problem"]),
        author: Author.fromJson(json["author"]),
        programmingLanguage:
            programmingLanguageValues.map[json["programmingLanguage"]],
        verdict: statusValues.map[json["verdict"]],
        testset: testsetValues.map[json["testset"]],
        passedTestCount: json["passedTestCount"],
        timeConsumedMillis: json["timeConsumedMillis"],
        memoryConsumedBytes: json["memoryConsumedBytes"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "contestId": contestId,
        "creationTimeSeconds": creationTimeSeconds,
        "relativeTimeSeconds": relativeTimeSeconds,
        "problem": problem.toJson(),
        "author": author.toJson(),
        "programmingLanguage":
            programmingLanguageValues.reverse[programmingLanguage],
        "verdict": statusValues.reverse[verdict],
        "testset": testsetValues.reverse[testset],
        "passedTestCount": passedTestCount,
        "timeConsumedMillis": timeConsumedMillis,
        "memoryConsumedBytes": memoryConsumedBytes,
      };
}

class Author {
  int contestId;
  List<Member> members;
  ParticipantType participantType;
  bool ghost;
  int room;
  int startTimeSeconds;

  Author({
    this.contestId,
    this.members,
    this.participantType,
    this.ghost,
    this.room,
    this.startTimeSeconds,
  });

  factory Author.fromJson(Map<String, dynamic> json) => Author(
        contestId: json["contestId"],
        members:
            List<Member>.from(json["members"].map((x) => Member.fromJson(x))),
        participantType: participantTypeValues.map[json["participantType"]],
        ghost: json["ghost"],
        room: json["room"] == null ? null : json["room"],
        startTimeSeconds: json["startTimeSeconds"],
      );

  Map<String, dynamic> toJson() => {
        "contestId": contestId,
        "members": List<dynamic>.from(members.map((x) => x.toJson())),
        "participantType": participantTypeValues.reverse[participantType],
        "ghost": ghost,
        "room": room == null ? null : room,
        "startTimeSeconds": startTimeSeconds,
      };
}

class Member {
  Handle handle;

  Member({
    this.handle,
  });

  factory Member.fromJson(Map<String, dynamic> json) => Member(
        handle: handleValues.map[json["handle"]],
      );

  Map<String, dynamic> toJson() => {
        "handle": handleValues.reverse[handle],
      };
}

enum Handle { FEFER_IVAN }

final handleValues = EnumValues({"Fefer_Ivan": Handle.FEFER_IVAN});

enum ParticipantType { CONTESTANT, PRACTICE }

final participantTypeValues = EnumValues({
  "CONTESTANT": ParticipantType.CONTESTANT,
  "PRACTICE": ParticipantType.PRACTICE
});

class UserProblem {
  int contestId;
  String index;
  String name;
  Type type;
  double points;
  int rating;
  List<String> tags;

  UserProblem({
    this.contestId,
    this.index,
    this.name,
    this.type,
    this.points,
    this.rating,
    this.tags,
  });

  factory UserProblem.fromJson(Map<String, dynamic> json) => UserProblem(
        contestId: json["contestId"],
        index: json["index"],
        name: json["name"],
        type: typeValues.map[json["type"]],
        points: json["points"],
        rating: json["rating"],
        tags: List<String>.from(json["tags"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "contestId": contestId,
        "index": index,
        "name": name,
        "type": typeValues.reverse[type],
        "points": points,
        "rating": rating,
        "tags": List<dynamic>.from(tags.map((x) => x)),
      };
}

enum Type { PROGRAMMING }

final typeValues = EnumValues({"PROGRAMMING": Type.PROGRAMMING});

enum ProgrammingLanguage { GNU_C_17, MS_C_2017 }

final programmingLanguageValues = EnumValues({
  "GNU C++17": ProgrammingLanguage.GNU_C_17,
  "MS C++ 2017": ProgrammingLanguage.MS_C_2017
});

enum Testset { TESTS, PRETESTS }

final testsetValues =
    EnumValues({"PRETESTS": Testset.PRETESTS, "TESTS": Testset.TESTS});

enum Status { OK, WRONG_ANSWER, RUNTIME_ERROR, FAILED }

final statusValues = EnumValues({
  "FAILED": Status.FAILED,
  "OK": Status.OK,
  "RUNTIME_ERROR": Status.RUNTIME_ERROR,
  "WRONG_ANSWER": Status.WRONG_ANSWER
});

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
