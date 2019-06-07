import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import 'dart:async';
import 'dart:io';

import 'package:kurriki/database/database.dart';

class WaawRpo {
  WaawRpo(); 
  WaawDatabase db = WaawDatabase();

  // Future<List> getCurriculums() async {
  //   List<Map> res = await dbClient.query("Movies");
  //   return res.map((m) => Curriculum.fromJson(m)).toList();
  // }



}
