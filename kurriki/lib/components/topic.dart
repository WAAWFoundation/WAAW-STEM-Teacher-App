import 'package:flutter/material.dart';
import 'package:kurriki/module/chat/conversation.dart';
import 'package:flutter/material.dart';
import 'package:kurriki/module/chat/conversation.dart';
import 'package:kurriki/module/curriculum/topics.dart';
import 'package:kurriki/module/curriculum/content.dart';
import 'dart:async';
import 'package:kurriki/shared/theme_data.dart';

// import 'dart:io';
import 'dart:math';
// import 'dart:convert';
import 'package:kurriki/shared/controls.dart';

class TopicTile extends StatefulWidget {
  TopicTile(this.topic, this.curriculum);
  final  topic;
  final curriculum;

  @override
  TopicTileState createState() => TopicTileState();
}

class TopicTileState extends State<TopicTile> {
  var topic;
  var curriculum;
  var topicState;
  var rng = new Random();

  @override
  void initState() {
    super.initState();
    topicState = widget.topic;
    curriculum = widget.curriculum;
    
  }

  @override
  Widget build(BuildContext context) {
      return Card(
        
        margin: EdgeInsets.all(5.0),
        child:GestureDetector(
           onTap: (){   
            Navigator.of(context).push(
              new MaterialPageRoute(
                builder: (context) => new Contents(topicState, curriculum)
              )
            );
          },
          child: new Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                 new Row(
                   children: <Widget>[
                     Container(
                      width: 80.0,
                      child:  ClipOval(
                      clipper: new CircleClipper(),
                      child: new Container(
                            decoration: BoxDecoration(color: WaawColors.ranColors[rng.nextInt(5)]),
                            width: 20.0,
                            height: 20.0,
                            child: Center(
                              child:
                                Text(
                                  "",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.0,
                                  // fontFamily: 'RobotoMono'
                                  ),),
                            )
                            ),
                        ),
                     ),
                     Expanded(
                       child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              padding: new EdgeInsets.only(top: 13.0),
                              child:  RichText(
                                text: TextSpan(
                                  text: topicState["title"],
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                            padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
                            child: new Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                              Icon(Icons.timer, color: Colors.black, size: 14.0,),
                              RichText(
                                text: TextSpan(
                                  text: topicState["durration"] + " Minutes",
                                  // text: "dfdfdf",
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w300,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ],  
                          ),
                            ),
                          // Container(
                          //   padding: EdgeInsets.all(5.0),
                          //   child: new Row(
                          //     mainAxisAlignment: MainAxisAlignment.start,
                          //     children: <Widget>[
                          //     Icon(Icons.bubble_chart, color: Colors.black, size: 14.0,),
                          //     RichText(
                          //       text: TextSpan(
                          //         text: " " + topicState["outcome"],
                          //         // text: "dfdfdf",
                          //         style: TextStyle(
                          //           fontSize: 14.0,
                          //           fontWeight: FontWeight.w300,
                          //           color: Colors.black,
                          //         ),
                          //       ),
                          //     ),
                          //   ],  
                          // ),
                    
                          // ),
                        
                          ]
                      )
                   ),
                   Container(
                      width: 80.0,
                      child:  ClipOval(
                      clipper: new CircleClipper(),
                      child: new Container(
                            decoration: BoxDecoration(color: WaawColors.ranColors[rng.nextInt(5)]),
                            width: 40.0,
                            height: 40.0,
                            child: Center(
                              child: Icon(
                                Icons.keyboard_arrow_right,
                                color: Colors.white,)
                            )
                            ),
                        ),
                     ),
              ],
            )
              ]
            ),
        ),
      );
    // return ListTile(
    //    onTap: (){          
    //         Navigator.of(context).push(
    //           new MaterialPageRoute(
    //             builder: (context) => new Conversation()
    //           )
    //         );
    //   },
    //   leading: IconButton(
    //     icon: Icon(Icons.add_circle_outline ),
    //     color: Colors.grey,
    //     onPressed: () {
    //       // onPressed();
    //     },
    //   ),
    //   title: Text('${topicState["title"]}'),
    //   subtitle: Text('${topicState["durration"]} | ${topicState["outcome"]}'),
    //   trailing: IconButton(
    //     icon: Icon(Icons.keyboard_arrow_right ),
    //     color: Colors.grey,
    //     onPressed: () {
    //       // onPressed();
    //     },
    //   ),
    // );

    // return ExpansionTile(
    //     // initiallyExpanded: topicState.isExpanded ?? false,
    //     // onExpansionChanged: (b) => topicState.isExpanded = b,
    //     children: <Widget>[
          
    //       Container(
    //         decoration: new BoxDecoration(
    //           border: new Border.all(color: Colors.lightBlue[50]),
    //           color: Colors.lightBlue[50]
    //         ),
    //         padding: EdgeInsets.all(10.0),
    //         child: Column(
    //         children: <Widget>[
    //             new Row(
    //           mainAxisAlignment: MainAxisAlignment.center,
    //           children: <Widget>[
    //             Icon(Icons.timer, color: Colors.black, size: 14.0,),
    //             RichText(
    //               text: TextSpan(
    //                 text: " " + topicState["durration"] + " | ",
    //                 // text: "dfdfdf",
    //                 style: TextStyle(
    //                   fontSize: 14.0,
    //                   fontWeight: FontWeight.w300,
    //                   color: Colors.black,
    //                 ),
    //               ),
    //             ),
    //             Icon(Icons.bubble_chart, color: Colors.black, size: 14.0,),
    //             RichText(
    //               text: TextSpan(
    //                 text: " " + topicState["outcome"],
    //                 // text: "dfdfdf",
    //                 style: TextStyle(
    //                   fontSize: 14.0,
    //                   fontWeight: FontWeight.w300,
    //                   color: Colors.black,
    //                 ),
    //               ),
    //             ),
    //           ],  
    //         ),
    //          Container(
    //         padding: EdgeInsets.all(10.0),
    //         child:  RichText(
    //               text: TextSpan(
    //                 text: topicState["description"],
    //                 // text: "dfdfdf",
    //                 style: TextStyle(
    //                   fontSize: 14.0,
    //                   fontWeight: FontWeight.w300,
    //                   color: Colors.black,
    //                 ),
    //               ),
    //             ),
    //       )

    //         ],
    //       ),
    //       ),
         
    //     ],
    //     leading: IconButton(
    //       icon: Icon(Icons.view_agenda ),
    //       color: Colors.grey,
    //       onPressed: () {
    //         // onPressed();
    //       },
    //     ),
    //     title: Container(
    //         // height: .0,
    //         padding: EdgeInsets.all(10.0),
    //         child: Row(
    //           children: <Widget>[
    //             Expanded(
    //               child: Text(
    //                 topicState["title"],
    //                 // "Testing",
    //                 textAlign: TextAlign.left,
    //                 maxLines: 10,
    //             ))
    //           ],
    //         )
    //       )
    //     );
  }
}
