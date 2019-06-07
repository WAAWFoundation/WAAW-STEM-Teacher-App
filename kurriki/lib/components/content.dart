import 'package:flutter/material.dart';
import 'package:kurriki/module/chat/conversation.dart';
import 'package:flutter/material.dart';
import 'package:kurriki/module/chat/conversation.dart';
import 'package:kurriki/module/curriculum/topics.dart';
import 'package:kurriki/module/curriculum/content.dart';
import 'dart:async';
import 'package:kurriki/shared/theme_data.dart';

import 'dart:io';
import 'dart:math';
import 'dart:convert';
import 'package:kurriki/shared/controls.dart';
import 'package:flutter_html_view/flutter_html_view.dart';

class ContentTile extends StatefulWidget {
  ContentTile(this.content);
  final  content;

  @override
  ContentTileState createState() => ContentTileState();
}

class ContentTileState extends State<ContentTile> {
  var content;
  var contentState;
  var rng = new Random();

  @override
  void initState() {
    super.initState();
    contentState = widget.content;
    
  }

  @override
  Widget build(BuildContext context) {

    return ExpansionTile(
        // initiallyExpanded: contentState.isExpanded ?? false,
        // onExpansionChanged: (b) => contentState.isExpanded = b,
        children: <Widget>[
          
          Container(
            decoration: new BoxDecoration(
              // border: new Border.all(color: Colors.lightBlue[50]),
              // color: Colors.lightBlue[50]
            ),
            padding: EdgeInsets.all(10.0),
            child: Column(
            children: <Widget>[
            Container(
              height: 300.0,
              padding: EdgeInsets.all(10.0),
              child:  new ListView.builder(
                itemCount: contentState["body"] == null ? 0 : contentState["body"].length,
                itemBuilder: (BuildContext context, int index) {
                 
                 return (contentState["body"][index]["type"] == "image") ?  
                  Container(
                    padding: EdgeInsets.all(2.0),
                    child: Image.network(contentState["body"][index]["value"]),
                  )
                  : 
                  Container(
                    padding: EdgeInsets.all(2.0),
                    child: new Text('Item ${contentState["body"][index]["value"]}'),
                  );
                  
                },
              ),
          )

            ],
          ),
          ),
         
        ],
        leading: Container(
            // width: 80.0,
            child:  ClipOval(
            clipper: new CircleClipper(),
            child: new Container(
                  decoration: BoxDecoration(color: WaawColors.ranColors[rng.nextInt(5)]),
                  width: 20.0,
                  height: 20.0,
                  child: Center(
                    child:
                      Text(
                        // '${topicState["title"].substring(0,1).toUpperCase()}', 
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
        title: Container(
            // height: .0,
            padding: EdgeInsets.all(10.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    contentState["title"],
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w700
                    ),
                    // "Testing",
                    textAlign: TextAlign.left,
                    maxLines: 10,
                ))
              ],
            )
          )
        );
  }
}


class Content {
  Content(this.type, this.value);

  final String type;
  final String value;
}

// Displays one Entry. If the entry has children then it's displayed
// with an ExpansionTile.
class ContentItem extends StatelessWidget {
  const ContentItem(this.entry);

  final Content entry;

  Widget _buildTiles(Content root) {
    if (root.type == 'image') return ListTile(title: Text(root.value));
    return ListTile(title: Text(root.type));
  }

  @override
  Widget build(BuildContext context) {
    return _buildTiles(entry);
  }
}
