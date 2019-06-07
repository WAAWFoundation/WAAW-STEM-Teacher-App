import 'package:meta/meta.dart';

class Subject {
  Subject({
    @required this.name,
    @required this.code
  });

  String name;
  String code;

  Subject.fromJson(Map json)
      : name = json["name"],
      code = json["code"];

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['name'] = name;
    map['code'] = code;
    return map;
  }

  // Subject.fromDb(Map map)
  //     : name = map["name"],
  //     code = map["code"];
   
}
