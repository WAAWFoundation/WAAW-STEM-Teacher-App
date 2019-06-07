
import 'package:meta/meta.dart';

import 'package:flutter/material.dart';
import 'package:kurriki/shared/theme_data.dart';
import 'package:kurriki/shared/env.dart';
import 'package:kurriki/shared/shared_store.dart';
import 'package:kurriki/shared/controls.dart';
import 'dart:async';
import 'dart:math';
import 'dart:io' show HttpClient, HttpClientBasicCredentials, HttpClientCredentials;
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:kurriki/module/home/home.dart';
import 'package:kurriki/module/curriculum/curriculum.dart';
import 'package:kurriki/components/topic.dart';
import 'package:kurriki/components/top.dart';


import 'package:kurriki/module/auth/auth_service.dart';
import 'package:kurriki/module/auth/login.dart';
import 'package:kurriki/module/curriculum/curriculum.dart';





class Topics extends StatefulWidget{
final curriculum;
Topics(this.curriculum);


  @override
    State<StatefulWidget> createState() => new TopicsState(this.curriculum);
}

class TopicsState extends State<Topics> {

 final curriculum;
 Map curriculumDetail;
 List topics = [];
 bool resultState = false;

 TopicsState(this.curriculum);

  Future<String> getCurriculumDetails(id) async {
    String url = Env().apiUrl;
    var token =  await SharedStore().getToken() ;    
    await Env().getAuthHeader().then((Map header){
       var response = http.get(
        Uri.encodeFull("$url/curriculums/$id"),
        headers: header).then((response){ 
              var results = json.decode(response.body);
                this.setState((){
                  this.curriculumDetail = results["data"];
                  this.topics = results["data"]["topics"];
                  // print(results["data"]["topics"]);
                });
                
        });


        
    });
    return "";
  }



 
  @override
  void initState(){     
    super.initState();
    print("curriculum");
    // print(curriculum);
    this.getCurriculumDetails(curriculum["id"]); //
  }
 
  @override
  Widget build (BuildContext context) {
     Size screenSize = MediaQuery.of(context).size;
    return new Scaffold(
    // AppBar
    
    appBar: new AppBar(
      backgroundColor: WaawColors.green[800],
      title: new Text(
        // "dsdsdsd",
        curriculum["subject"]["name"], 
        style: new TextStyle(
          fontSize: Theme.of(context).platform == TargetPlatform.iOS ? 17.0 : 20.0,
        ),
      ),
      elevation:  0.0,
      actions: <Widget>[
               
                new Icon(Icons.sync),
              ],
      // elevation: Theme.of(context).platform == TargetPlatform.iOS ? 0.0 : 4.0,
      leading: new IconButton(
        icon: new Icon(
          Icons.arrow_back_ios,
          // IconTheme
        ),
        onPressed: (){
            Navigator.of(context).push(
              new MaterialPageRoute(
                builder: (context) => new Curriculum()
              )
            );
        },
      ),
      // bottom: new column{}
    ),
    //Content of tabs
    body: new Column(
       children: <Widget>[
         new Container(
              color: WaawColors.green[800],
              child: new Center(
                  child:  new Container(
                      width: 60.0,
                      height: 60.0,
                        child:  ClipOval(
                          clipper: new CircleClipper(),
                          child: new Icon(
                                  Icons.timer,
                                  size: 50.0,
                                  color: Colors.white70,
                                ),
                          ),
                  ),
                ),
            ),
            new Container(
              color: WaawColors.green[800],
              // color: WevoteColors.blue[900],
              padding: new EdgeInsets.only(bottom: 20.0),
              child: new Center(
                  child:  new RichText(
                    textAlign: TextAlign.center,
                    text: new TextSpan(
                      text: "",
                      children: [
                        new TextSpan(
                          text: 
                          // topics.length.toString() +
                           " Topics",
                          style: new TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w700,
                          )
                        ),
                      ]
                    ),
                  ),
                ),
            ),
         new Expanded(
            child: 
            topics.length > 0 ?
            ListView.builder(
              padding: EdgeInsets.all(5.0),
              itemCount: topics == null ? 0 : topics.length,
              itemBuilder: (BuildContext context, int index) {
                return new TopicTile(topics[index], curriculum);
              },
            )
             :
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.library_books, 
                    size: 50.0, 
                    color: Colors.grey
                    ),
                  Text("No topics added!")
                ],
              )
            )
          )
        // new Container(
        //   child: Text("sdsd"),
        // )
       ],
     )
      // 
      // drawer: new MenuDrawer()
    );
  }

  
}




// build result


// class ElectionResult extends StatelessWidget {
//   // Builder methods rely on a set of data, such as a list.
//   final List topics;
//   final curriculum;
//   final screenSize;
//   ElectionResult(this.topics, this.curriculum, this.screenSize);

//   // First, make your build method like normal.
//   // instead of returning Widgets, return a method which
//   // returns widgets.
//   // Don't forget to pass in the context!
//   @override
//   Widget build(BuildContext context) {
//     return  new Column(
//       children: <Widget>[ 

//         new Container(
//            color: WaawColors.blue[900],
//            padding: new EdgeInsets.only(bottom: 20.0, top: 10.0),
//            child: new Center(
//               child: new Container(
//                 height: 50.0,
//                 color: WaawColors.blue[900],
//                 //  padding: new EdgeInsets.all(10.0),
//                 child:   new Row(
//                   children: <Widget>[
//                     new Expanded(child: new Container(),),
//                     new FlatButton(
//                           child: new Row(
//                             children: <Widget>[
//                               // new  Icon(
//                               //   Icons.check_circle_outline,
//                               //   color: Colors.white,
//                               //   // textDirection: ,
//                               // ),
//                               new Text(
//                                  "Total Votes: " + curriculum["total_ballots"].toString(),
//                                 style: new TextStyle(
//                                   color: Colors.white,
//                                   fontWeight: FontWeight.w600,
//                                   fontSize: 16.0,
//                                 ),
//                               ),
//                             ],
//                           ),
//                           onPressed: (){
                            
//                           },
//                           color: WaawColors.green[700],
//                           // padding: EdgeInsets.all(10.0),
//                       ),
//                       new Expanded(child: new Container(),),
                    
                    
//                   ],
                    
//                 ), 
//               ),
            
//            ),
//          ),
        
//         new Container(
//           width: screenSize.width,
//           height: screenSize.height,
//           child: ListView.builder( 
//               scrollDirection: Axis.vertical,
//               // key: new Key(randomString(20)),
//               primary: true,
//               // itemCount: 1,
//               itemCount:  topics == null ? 0 :  topics.length,
//               itemBuilder: (BuildContext context, int index) {
//                   return new Card(
//                     margin: new EdgeInsets.all(5.0),
                  
//                     child:  new GestureDetector(
//                       onTap: (){
//                       },
//                       child: new Container(
//                         padding: new EdgeInsets.only(bottom: 20.0, top: 20.0, left: 5.0, right: 5.0),
//                         child: new Row(
//                             // mainAxisAlignment: MainAxisAlignment.center,
//                             crossAxisAlignment: CrossAxisAlignment.center,
                            
//                             children: <Widget>[
                             
//                               new Expanded(
//                                     child: new Column(
//                                       mainAxisAlignment: MainAxisAlignment.start,
//                                         mainAxisSize: MainAxisSize.min,
//                                         crossAxisAlignment: CrossAxisAlignment.start,
//                                       children: [
//                                         new Container(
//                                           padding: const EdgeInsets.all(.0),
//                                           child: new Text(
//                                            topics[index]["name"],
//                                             style: new TextStyle(
//                                               fontWeight: FontWeight.w800,
//                                               fontSize: 18.0
//                                             ),
//                                           ),
//                                         ),
                                        
                                    
//                                       ],
//                                     ),
//                                ),
                              
//                                 new Container(
//                                 //  
//                                 padding: new EdgeInsets.only(bottom: 5.0, top: 5.0),
//                                 child: new Center(
//                                     child:  new RichText(

//                                       textAlign: TextAlign.center,
//                                       text: new TextSpan(
//                                         text: "",
//                                         children: [
//                                           new TextSpan(
//                                             text: topics[index]["ballot"].toString(),
//                                             style: new TextStyle(
//                                               fontSize: 18.0,
//                                               fontWeight: FontWeight.w700,
//                                               color: WaawColors.blue[900]
//                                             )
//                                           ),
                                        
//                                         ]
//                                       ),
                                        
//                                     ),
//                                   ),
//                               ),
                              
                               
//                             ],
//                           )
//                       )
//                     )
//                   );

//               }
//             ),
//         )
//       ]
//     );
//   }  
// }

