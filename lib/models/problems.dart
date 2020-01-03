import 'complex_problems.dart';

class Problem {
  String name;
  String index;
  String contestID;
  List<Tag> tags;
  double points;

  Problem({this.name, this.index, this.contestID, this.tags, this.points});
  factory Problem.fromJson(Map<String, dynamic> json) => Problem(
      name: json["name"],
      contestID: json["contestID"],
      index: json["index"],
      tags: List<Tag>.from(json["tags"].map((x) => tagValues.map[x])),
      points: json["points"]);
  Map<String, dynamic> toJson() => {
        "name": name,
        "contestID": contestID,
        "index": index,
        "tags": List<dynamic>.from(tags.map((x) => tagValues.reverse[x])),
        "points": points
      };
}
