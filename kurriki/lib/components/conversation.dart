import 'package:flutter/material.dart';
import 'package:kurriki/module/chat/conversation.dart';

// const String _name = "Imo Inyang";
 

class ConversationCard extends StatelessWidget {
  final Map conversation;
  //for opotional params we use curly braces
  ConversationCard(this.conversation);

  @override
  Widget build(BuildContext context) {
   

    return new GestureDetector(
      onTap: (){
        // print(conversation["id"]);
        Navigator.of(context).push(
                    new MaterialPageRoute(
                      builder: (context) => new Conversation(this.conversation)
                    )
                  );
      },
      child: new Container(
        margin: const EdgeInsets.only(top: 10.0),
          child: new Column(
            children: <Widget>[
            new Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Container(
                  margin: const EdgeInsets.only(right: 16.0),
                  child: new CircleAvatar(
                    child: new Text(conversation["description"][0].toUpperCase()),
                  ),
                ),
                new Expanded(
                  child: 
                  new Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      new Text(
                        conversation["name"],
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w800
                        )
                      ),
                      new Container(
                        margin: const EdgeInsets.only(top: 5.0),
                        child: new Text(
                        conversation["account"]["first_name"] + " " +conversation["account"]["last_name"],  style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w600
                        ),

                        )
                      )
                    ],
                  ),
                ),
                new Container(
                
                  margin:  EdgeInsets.only(top: 5.0),
                  child: new Icon(Icons.keyboard_arrow_right)
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: 7.0),
            ),
            Divider()
            ]
          )
      )
    );
  }
}