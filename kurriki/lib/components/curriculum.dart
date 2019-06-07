import 'package:flutter/material.dart';
import 'package:kurriki/module/chat/conversation.dart';
import 'package:kurriki/module/curriculum/topics.dart';
import 'dart:async';
import 'package:kurriki/shared/theme_data.dart';

// import 'dart:io';
import 'dart:math';
// import 'dart:convert';
import 'package:kurriki/shared/controls.dart';

class CurriculumTile extends StatefulWidget {
  CurriculumTile(this.curriculum);
  final  curriculum;

  @override
  CurriculumTileState createState() => CurriculumTileState();
}

class CurriculumTileState extends State<CurriculumTile> {
  var curriculum;
  var curriculumState;
  var rng = new Random();
  @override
  void initState() {
    super.initState();
    curriculumState = widget.curriculum;
    // print("curriculumState");
    // print(curriculumState["subject"]);
  }

  // void onPressed() {
  //   MovieDatabase db = MovieDatabase();
  //   setState(() => movieState.favored = !movieState.favored);
  //   movieState.favored == true
  //       ? db.addMovie(movieState)
  //       : db.deleteMovie(movieState.id);
  // }

  @override
  Widget build(BuildContext context) {

  return new Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
           ListTile(
            onTap: (){   
                  Navigator.of(context).push(
                    new MaterialPageRoute(
                      builder: (context) => new Topics(curriculumState)
                    )
                  );
            },
            leading:  ClipOval(
                clipper: new CircleClipper(),
                child: new Container(
                      decoration: BoxDecoration(color: WaawColors.ranColors[rng.nextInt(5)]),
                      width: 50.0,
                      height: 50.0,
                      child: Center(
                        child:
                          Text(
                            '${curriculumState["subject"]["name"].substring(0,1) }', 
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                            // fontFamily: 'RobotoMono'
                            ),),
                      )
                      ),
                  ),
            trailing: Icon(Icons.keyboard_arrow_right),
            title:  Text(
              '${curriculumState["subject"]["name"]}',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w700
                ), ),
            subtitle: new Text('${curriculumState["level"]["name"]} | ${curriculumState["type"]["name"]}',
            style: TextStyle(height: 1.6),),
          ),
        Divider(color: Colors.grey,)
        ],
      );
    // );
    // return ExpansionTile(
    //     // initiallyExpanded: curriculumState.isExpanded ?? false,
    //     // onExpansionChanged: (b) => curriculumState.isExpanded = b,
    //     children: <Widget>[
    //       Container(
    //         padding: EdgeInsets.all(10.0),
    //         child: RichText(
    //           text: TextSpan(
    //             text: curriculumState["subject"],
    //             // text: "dfdfdf",
    //             style: TextStyle(
    //               fontSize: 14.0,
    //               fontWeight: FontWeight.w300,
    //             ),
    //           ),
    //         ),
    //       )
    //     ],
    //     leading: IconButton(
    //       icon: Icon(Icons.add_circle_outline ),
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
    //                 curriculumState["subject"],
    //                 textAlign: TextAlign.center,
    //                 maxLines: 10,
    //             ))
    //           ],
    //         )
    //       )
    //     );
  }
}
