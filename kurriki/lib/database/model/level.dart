import 'package:meta/meta.dart';

class Level {
  Level({
    @required this.name
  });

  String name;

  Level.fromJson(Map json)
      : name = json["name"];

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['name'] = name;
    return map;
  }

  Level.fromDb(Map map)
      : name = map["name"];

      
}
