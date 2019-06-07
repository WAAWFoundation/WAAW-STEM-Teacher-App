import 'package:meta/meta.dart';

class Curriculum {
  Curriculum({
    @required this.subject,
    @required this.subjectId,
    @required this.id,
    @required this.level,
    @required this.levelId,
    @required this.curriculumType,

  });

  String subject, subjectId, id, level, levelId, curriculumType;
  bool favored, isExpanded;

  Curriculum.fromJson(Map json)
      : subjectId = json["subject_id"],
        subject = json["subject"],
        level = json["level"].toString(),
        levelId = json["level_id"].toString(),
        id = json["id"],
        curriculumType = json["curriculum_type"];


  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['id'] = id;
    map['subject_id'] = subjectId;
    map['subject'] = subject;
    map['level'] = level;
    map['level_id'] = levelId;
    map['curriculum_type'] = curriculumType;
    return map;
  }

  // Curriculum.fromDb(Map map)
  //     : title = map["title"],
  //       posterPath = map["poster_path"],
  //       id = map["id"].toString(),
  //       overview = map["overview"],
  //       favored = map['favored'] == 1 ? true : false;
}
