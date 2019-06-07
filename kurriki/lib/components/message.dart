import 'package:flutter/material.dart';
import 'package:kurriki/shared/timeago.dart';

// const String _name = "Imo Inyang";

class ChatMessage extends StatelessWidget {
  final Map conversation ;
  //for opotional params we use curly braces
  ChatMessage(this.conversation);


  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return new Container(
      width: width * 0.45,
      decoration: BoxDecoration(
          color: Colors.white 
      ),
      padding: EdgeInsets.all(10.0),
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child:  new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
              new Row(
               crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  new Container(
                    margin: const EdgeInsets.only(right: 10.0),
                    child: new CircleAvatar(
                      radius: 10.0,
                      child: new Text(conversation["account"]["last_name"][0]),
                    ),
                  ),
                  new Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      new Text(conversation["account"]["first_name"] + " " +conversation["account"]["last_name"],
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w900
                      )
                      ),
                    
                    ],
                  )
              ],
            ),
            new Container(
                margin: const EdgeInsets.only(top: 5.0),
                child: new Text(
                  conversation["body"],
                  style: TextStyle(
                  
                  ),),
            ),
            new Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 5.0),
                  ),
                  new Text(timeAgoMessage(conversation["inserted_at"]),
                    style: TextStyle(
                      fontSize: 10.0,
                      fontWeight: FontWeight.w900,
                      color: Colors.black26
                    )
                    ),
              ],
            )
        ]
      )
    );
  }
}