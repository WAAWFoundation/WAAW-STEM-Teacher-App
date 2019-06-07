import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:kurriki/components/message.dart';
import 'package:kurriki/components/conversation.dart';
import 'package:kurriki/module/chat/new_conversation.dart';
import 'package:kurriki/shared/theme_data.dart';

import 'package:kurriki/shared/env.dart';
import 'package:kurriki/shared/shared_store.dart';
import 'dart:async';
import 'dart:math';
import 'dart:io' show HttpClient, HttpClientBasicCredentials, HttpClientCredentials;
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:kurriki/components/drawer.dart';

import 'package:intl/intl.dart';

class Conversations extends StatefulWidget {
  @override
  State createState() => new ConversationsState();
}

class ConversationsState extends State<Conversations> {
  final TextEditingController _textController = new TextEditingController();
  bool _isComposing = false;
  List conversations = [];


  Future<String> getConversations() async {      
      
    String url = Env().apiUrl;
    var token =  await SharedStore().getToken() ;    
    await Env().getAuthHeader().then((Map header){

       var response = http.get(
        Uri.encodeFull("$url/conversations"),
        headers: header).then((response){ 
              // print("Response status: ${response.statusCode}");
             print("Response body: ${response.body}");
              this.setState((){ 
              var  results = json.decode(response.body);
              conversations = results["data"];
              });
        });


        
    });
    return "";
  }



  @override
  void initState(){     
    super.initState();
    print("curriculum");
    this.getConversations(); //
  }
 



  @override
  Widget build(BuildContext context) {
     Size screenSize = MediaQuery.of(context).size;

    return (new WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: new Scaffold(
          appBar: new AppBar(
          backgroundColor: WaawColors.green[800],
          title: new Text(
            "Conservations", 
            style: new TextStyle(
              fontSize: Theme.of(context).platform == TargetPlatform.iOS ? 17.0 : 20.0,
            ),
          ),
          elevation: Theme.of(context).platform == TargetPlatform.iOS ? 0.0 : 4.0,
        ),
        body: new Container(
          width: screenSize.width,
          height: screenSize.height,
          child: new Stack(
            //alignment: buttonSwingAnimation.value,
            alignment: Alignment.bottomRight,
            children: <Widget>[
              new ListView.builder(
              padding: new EdgeInsets.all(8.0),
              // reverse: true,
              itemBuilder: (BuildContext context, int index) {
                return new ConversationCard(conversations[index]);
              },
              //itemCount: 100, 
              itemCount: conversations == null ? 0 : conversations.length,
             ),
             new Column(
               mainAxisAlignment: MainAxisAlignment.end,
               children: <Widget>[
                  Container(
                    padding: new EdgeInsets.all(7.0),
                    child: FloatingActionButton(
                      onPressed: (){
                          Navigator.of(context).push(
                             new MaterialPageRoute(
                                builder: (context) => new NewConversationPage()
                              )
                            );
                      },
                      notchMargin: 3.0,
                      tooltip: 'New Conversation',
                      child: Icon(
                          Icons.add,
                      ),
                    ),
                  )
               ],
             )
           
            ],
          ),
        ),
        drawer: new MenuDrawer(),
      )
    )
    );
      
      
  }
}