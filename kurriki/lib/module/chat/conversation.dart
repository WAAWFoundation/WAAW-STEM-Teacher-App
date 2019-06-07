import 'package:flutter/material.dart';
import 'package:validate/validate.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;


import 'dart:math';
import 'dart:io';
import 'package:kurriki/shared/controls.dart';
import 'package:kurriki/shared/timeago.dart';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:kurriki/components/message.dart';
import 'package:kurriki/shared/theme_data.dart';
import 'package:kurriki/module/chat/conversations.dart';
import 'package:intl/intl.dart';

import 'package:kurriki/utils/network.dart';
import 'package:kurriki/shared/shared_store.dart';

import 'package:kurriki/shared/env.dart';
import 'package:kurriki/shared/loader.dart';


class Conversation extends StatefulWidget {
  final  conversation;
  Conversation(this.conversation);
 
  @override
  State createState() => new ConversationState(this.conversation);
}

class ConversationState extends State<Conversation> {
  final conversation;
  ConversationState(this.conversation);

  final TextEditingController _textController = new TextEditingController();
  bool _isComposing = false;
  var loading = false;
  List messages; 


  Future<String> getMessages() async {      
      
    String url = Env().apiUrl;
    var token =  await SharedStore().getToken() ;    
    await Env().getAuthHeader().then((Map header){
      //  var response = http.get(
      //   Uri.encodeFull("$url/messages/"),
      //   headers: header).then((response){ 
      //         // print("Response status: ${response.statusCode}");
      //        print("Response body: ${response.body}");
      //         this.setState((){ 
      //         var  results = json.decode(response.body);
      //         conversation = results["data"];
      //         });
      //   });

    });
    return "";
  }



  @override
  void initState(){     
    super.initState();
    messages = conversation["messages"];
    // print(conversation["messages"]);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          backgroundColor: WaawColors.green[800],
          title: new Text(
            conversation["name"], 
            style: new TextStyle(
              fontSize: Theme.of(context).platform == TargetPlatform.iOS ? 17.0 : 20.0,
            ),
          ),
          elevation:  0.0,
          //elevation: Theme.of(context).platform == TargetPlatform.iOS ? 0.0 : 4.0,
          leading: new IconButton(
            icon: new Icon(
              Icons.arrow_back_ios,
              // IconTheme
            ),
            onPressed: (){
              // print(curriculum);
                Navigator.of(context).push(
                  new MaterialPageRoute(
                    builder: (context) => new Conversations()
                  )
                );
            },
          ),
          // bottom: new column{}
        ),
        // appBar: new AppBar(
        //   title: new Text("Conversation"),
        //   elevation: Theme.of(context).platform == TargetPlatform.iOS ? 0.0 : 4.0,
        // ),
        body:  new Column(

        children: <Widget>[
          new Container(
              padding: EdgeInsets.only(bottom: 30.0),
              color: WaawColors.green[800],
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                    new Icon(
                      Icons.timer,
                      size: 20.0,
                      color: Colors.white70,
                    ),
                    Text(
                      timeAgo(conversation["inserted_at"]) ,
                    //  diff.toString(),
                      style: TextStyle(
                        color: Colors.white
                      ),
                    ),
                  
                  ],
                )
          ),

          new Flexible(
            child: 
            messages != null ?
            new ListView.builder(
              padding: new EdgeInsets.all(8.0),
              reverse: true,
              itemBuilder: (BuildContext context, int index) {
                return new ChatMessage(messages[index]);
                // return new ChatMessage("Message from the one, this this is working but this guys really believe we can do it in two weeks");
                },
              // itemCount: 5, 
              itemCount: messages == null ? 0 : messages.length,

            ) :
            Container(
              child: Icon(Icons.add),
            )
          ),
          new Divider(height: 1.0,),
          new Container(
            decoration: new BoxDecoration(
              color: Theme.of(context).cardColor,
            ),
            child: _buildTextComposer(),
          )
        ],
      )
    );
  }

  Widget _buildTextComposer() {
    return new IconTheme(
      data: new IconThemeData(color: Theme.of(context).accentColor),
      child: new Container(
        
        height: 100.0,
          margin: const EdgeInsets.symmetric(horizontal: 8.0),
          child: new Row(children: <Widget>[
            // new Container(
            //   margin: new EdgeInsets.symmetric(horizontal: 4.0),
            //   child: new IconButton(
            //       icon: new Icon(Icons.photo),
            //       onPressed: () async {
            //       }
            //   ),
            // ),
            new Flexible(
              child: new TextField(
                maxLines: 4,
                controller: _textController,
                onChanged: (String text) {
                  setState(() {
                    _isComposing = text.length > 0;
                  });
                },
                style: new TextStyle(
                  color: Colors.grey,
                  
                ),
                onSubmitted: _handleSubmitted,
                decoration:
                    new InputDecoration.collapsed(
                      hintText: "Reply"),
              ),
            ),
            new Container(
                margin: new EdgeInsets.symmetric(horizontal: 4.0),
                child: Theme.of(context).platform == TargetPlatform.iOS
                    ? new CupertinoButton(
                        child: new Text("Send"),
                        onPressed: _isComposing
                            ? () => _handleSubmitted(_textController.text)
                            : null,
                      )
                    : new IconButton(
                        icon: new Icon(Icons.send),
                        onPressed: _isComposing
                            ? () => _handleSubmitted(_textController.text)
                            : null,
                      )),
          ]),
          decoration: Theme.of(context).platform == TargetPlatform.iOS
              ? new BoxDecoration(
                  border:
                      new Border(top: new BorderSide(color: Colors.grey[200])))
              :  new BoxDecoration(
                  border:
                      new Border(top: new BorderSide(color: Colors.grey[200])))),
    );
  }

  Future<Null> _handleSubmitted(String text) async {
    _textController.clear();
    setState(() {
      _isComposing = false;
    });
    // await _ensureLoggedIn();
    _sendMessage(text: text);
  }

  void _sendMessage({ String text, String imageUrl }) {
   
    _send(text);
    
  }

  void _send(text) async{
    String url = Env().apiUrl;
          var token =  await SharedStore().getToken() ;    
          await Env().getAuthHeader().then((Map header){
          
          Map<String, String> body ={
            'body': text,
            'conversation_id': this.conversation["id"].toString()
          };
          var response = http.post(
              Uri.encodeFull("$url/messages"),
              headers: header,
              body: body
            ).then((response){ 
                     Map responseJson = json.decode(response.body);
                    //  print(messages);
                    //  print("responseJson");

                     
                     print(messages);

                    if(response.statusCode != 201){
                        this.setState((){
                          this.loading = false;
                        });

                      }else{
                        this.setState((){
                          messages.add(responseJson["data"]);
                          messages.reversed;
                        });
                      
                    }
              });


              
          });
  }

}
