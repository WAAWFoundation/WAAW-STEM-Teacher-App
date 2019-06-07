import 'package:flutter/material.dart';
import 'package:kurriki/shared/theme_data.dart';
import 'package:kurriki/shared/env.dart';
import 'package:kurriki/shared/shared_store.dart';
import 'package:kurriki/components/curriculum.dart';
import 'package:kurriki/database/database.dart';
import 'dart:async';
import 'dart:math';
import 'dart:io' show HttpClient, HttpClientBasicCredentials, HttpClientCredentials;
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:intl/intl.dart';

import 'package:kurriki/components/drawer.dart';


class Curriculum extends StatefulWidget{

  // var  _election = Elections();
  @override
  State<StatefulWidget> createState() => new CurriculumState();
}
class CurriculumState extends State<Curriculum> {
   List emptySubject = [{
                  "id": "",
                  "name":   "Select Subject"
                }];
   List subjects = [{
                  "id": "",
                  "name":   "Select Subject"
                }];

   List emptyLevel = [{
                  "id": "",
                  "name":   "Select Level"
                }];
   List levels = [{
                  "id": "",
                  "name":   "Select Level"
                }];
 

  List<DropdownMenuItem<String>> buildAndGetDropDownMenuItems(List fruits) {
    List<DropdownMenuItem<String>> items = new List();
    // for (String fruit in fruits) {
    //   items.add(new DropdownMenuItem(value: fruit, child: new Text(fruit)));
    // }
    // return items;
  }

  List curriculums =  [];
  var time = new DateFormat('Hm');
  var date = new DateFormat('yyyy-MM-dd');
 String _selectedSubject;

 
 String _selectedLevel;
 

  Future<String> getCurriculum() async {      
      
    String url = Env().apiUrl;
    var token =  await SharedStore().getToken() ;    
    await Env().getAuthHeader().then((Map header){
      
      print("_selectedLevel");
      print(_selectedLevel);
      print("_selectedSubject");
      print(_selectedSubject);
    if (_selectedLevel != "" && _selectedSubject != "" ){
        var response = http.get(
        Uri.encodeFull("$url/curriculums/$_selectedSubject/$_selectedLevel"),
        headers: header).then((response){ 
             print("Response body: ${response.body}");
              this.setState((){ 
              var  results = json.decode(response.body);
                this.curriculums = results["data"];
              });
        });
    }else{
       var response = http.get(
        Uri.encodeFull("$url/curriculums"),
        headers: header).then((response){ 
             print("Response body: ${response.body}");
              this.setState((){ 
              var  results = json.decode(response.body);
                this.curriculums = results["data"];
              });
        });
    }
       
        
    });
    return "";
  }

   Future<String> getSubjects() async {
    String url = Env().apiUrl;
    var token =  await SharedStore().getToken() ;    
    await Env().getAuthHeader().then((Map header){

       var response = http.get(
        Uri.encodeFull("$url/subjects"),
        headers: header).then((response){ 
             print("Response body: ${response.body}");
              this.setState((){ 
                var  results = json.decode(response.body);
                subjects = new List.from(emptySubject)..addAll(results["data"]);
               
              });
        });
        
    });
    return "";
  }

   Future<String> getLevels() async {      
      
    String url = Env().apiUrl;
    // var token =  await SharedStore().getToken() ;    
    await Env().getAuthHeader().then((Map header){

      http.get(
        Uri.encodeFull("$url/levels"),
        headers: header).then((response){ 
             print("Response body: ${response.body}");
              this.setState((){ 
              var  results = json.decode(response.body);
                levels = new List.from(emptyLevel)..addAll(results["data"]);
              });
        });
        
    });
    return "";
  }


 void changedSearch(String selected, item) {
   if (item == "subject"){
        setState(() {
          _selectedSubject = selected;
         
        });
   }else{
    setState(() {
          _selectedLevel = selected;
        });
   }
   
   
  }


  @override
  void initState(){   
    super.initState();
     _selectedSubject = "";
     _selectedSubject = "";
     getSubjects();
     getLevels();
     getCurriculum();
    // WaawDatabase db = WaawDatabase();
    print("db.getCurriculums()");
    // print(db.getCurriculums());
    // db.deleteDb();
  }
 
 
  @override
  Widget build (BuildContext context) {
     Size screenSize = MediaQuery.of(context).size;
      return new Scaffold(
      // AppBar
      
      appBar: new AppBar(
        backgroundColor: WaawColors.green[800],
        title: new Text(
          "Curriculum", 
          style: new TextStyle(
            fontSize: Theme.of(context).platform == TargetPlatform.iOS ? 17.0 : 20.0,
          ),
        ),
        elevation:  0.0,
        actions: <Widget>[
                  
                  new Icon(Icons.sync),
                ],
        // elevation: Theme.of(context).platform == TargetPlatform.iOS ? 0.0 : 4.0,
        
      ),
      //Content of tabs
      //Content of tabs
      body: new Column(
        children: <Widget>[
          new Container(
            decoration: new BoxDecoration(
              //  color: WaawColors.green[700]
            ),
            padding: const EdgeInsets.all(8.0),
            child: new Theme(
                data: Theme.of(context).copyWith(
                  // canvasColor: Colors.blue.shade200,
                  // canvasColor: WaawColors.green[800],
                ),
                child: new Row(
                  children: <Widget>[

                    new Expanded(
                      child: Container(
                        padding: EdgeInsets.only(left: 9.0),
                        margin: EdgeInsets.only( right: 5.0),
                        decoration: BoxDecoration(
                          border: new Border.all(color: WaawColors.green[800]),
                        ),
                        child: DropdownButtonHideUnderline(
                              child: new DropdownButton(
                              style: TextStyle(
                                color: Colors.black54,
                              ),
                              value: _selectedSubject,
                              items: subjects.map(( map) {
                                return new DropdownMenuItem<String>(
                                  value: map["id"].toString(),
                                  child: new Text(
                                    map["name"],
                                  ),
                                );
                              }).toList(),
                            onChanged: (String newValue) {
                              setState(() {
                                _selectedSubject = newValue;
                              });
                               getCurriculum();
                            },
                            ),
                        ),
                      ),
                    ),
                    new Expanded(
                      child: Container(
                        padding: EdgeInsets.only(left: 9.0),
                        margin: EdgeInsets.only(left: 5.0),
                         decoration: BoxDecoration(
                          border: new Border.all(color: WaawColors.green[800]),
                        ),
                        child: DropdownButtonHideUnderline(
                              child: new DropdownButton(
                               style: TextStyle(
                                color: Colors.black54,
                              ), 
                              value: _selectedLevel,
                              items: levels.map((map) {
                                return new DropdownMenuItem<String>(
                                  value: map["id"].toString(),
                                  child: new Text(
                                    map["name"],
                                  ),
                                );
                              }).toList(),
                            onChanged: (String newValue) {
                              setState(() {
                                _selectedLevel = newValue;
                              });
                              getCurriculum();
                            },
                            ),
                        ),
                      ),
                    ),
                  ],
                ),
            ),
          ),
          new Expanded(
              child:  ListView.builder(
                padding: EdgeInsets.all(5.0),
                itemCount: curriculums == null ? 0 : curriculums.length,
                itemBuilder: (BuildContext context, int index) {
                  return new CurriculumTile(curriculums[index]);
                },
              )
            
            )
        ],
      ),
      drawer: new MenuDrawer(),
    );
  }









  
}


