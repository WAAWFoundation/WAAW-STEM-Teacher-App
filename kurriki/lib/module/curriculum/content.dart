
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
// import 'package:kurriki/components/content.dart';
import 'package:kurriki/components/top.dart';
import 'package:kurriki/components/content.dart';
import 'package:kurriki/module/curriculum/topics.dart';
import 'package:kurriki/module/auth/login.dart';

import 'package:flutter_html_view/flutter_html_view.dart';
import 'package:kurriki/module/auth/auth_service.dart';





class Contents extends StatefulWidget{
  final content;
  final curriculum;
  Contents(this.content, this.curriculum);


  @override
    State<StatefulWidget> createState() => new ContentsState(this.content);
}

class ContentsState extends State<Contents> {

 var curriculum;
 final content;
 Map contentDetail;
 List contents = [];
 bool resultState = false;

 ContentsState(this.content);

  Future<String> getContentDetails(id) async {
    String url = Env().apiUrl;
    var token =  await SharedStore().getToken() ;    
    await Env().getAuthHeader().then((Map header){
       var response = http.get(
        Uri.encodeFull("$url/topics/$id"),
        headers: header).then((response){ 
              var results = json.decode(response.body);
                this.setState((){
                  // this.curriculum = results["data"]["curriculum"];
                  // print("this.curriculum");
                  // print(this.curriculum);
                  this.contentDetail = results["data"];
                  this.contents = results["data"]["contents"];
                  print(contents);
                });
                
        });
    });
    return "";
  }



 
  @override
  void initState(){     
    super.initState();
    curriculum = widget.curriculum;
    

    // print(content["id"]);
    // print("content[id]");
    //  print(content);
    this.getContentDetails(content["id"]); //
  }
 
  @override
  Widget build (BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return new Scaffold(
    // AppBar
    
    appBar: new AppBar(
      backgroundColor: WaawColors.green[800],
      title: new Text(
        content["title"], 
        style: new TextStyle(
          fontSize: Theme.of(context).platform == TargetPlatform.iOS ? 17.0 : 20.0,
        ),
      ),
      elevation:  0.0,
      actions: <Widget>[
                new Icon(Icons.sync),
              ],
      leading: new IconButton(
        icon: new Icon(
          Icons.arrow_back_ios,
          // IconTheme
        ),
        onPressed: (){
          print(curriculum);
            Navigator.of(context).push(
              new MaterialPageRoute(
                // builder: (context) => new Home()
                builder: (context) => new Topics(curriculum)
              )
            );
        },
      ),
      // bottom: new column{}
    ),
    //Content of tabs
    body: Column(
      // shrinkWrap: true,
      // padding: const EdgeInsets.all(20.0),
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
              padding: new EdgeInsets.only(bottom: 20.0),
              child: new Center(
                  child:  new RichText(
                    textAlign: TextAlign.center,
                    text: new TextSpan(
                      text: "",
                      children: [
                        new TextSpan(
                          text: content["durration"] + " Minutes",
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
            Container(
              margin: EdgeInsets.all(4.0),
              child: Card(
                elevation: 0.0,
                child: Container(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                    width: 440.0,
                    child:  new RichText(
                      textAlign: TextAlign.start,
                      text: new TextSpan(
                        text: "",
                        children: [
                          new TextSpan(
                            text: "Description",
                            style: new TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w700,
                              color: Colors.black
                            )
                          )
                        ]
                      ),
                    ),
                    ),
                    Container(
                    width: 440.0,
                    child:  new RichText(
                      textAlign: TextAlign.start,
                      text: new TextSpan(
                        text: "",
                        children: [
                          new TextSpan(
                            text: content["description"],
                            style: new TextStyle(
                              fontSize: 13.0,
                              height: 1.5,
                              fontWeight: FontWeight.w100,
                              color: Colors.black
                            )
                          )
                        ]
                      ),
                    ),
                    )
                  ],
                ),
                ),
                
              ),
          ),

           Container(
              margin: EdgeInsets.all(4.0),
              child: Card(
                elevation: 0.0,
                child: Container(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                    width: 440.0,
                    child:  new RichText(
                      textAlign: TextAlign.start,
                      text: new TextSpan(
                        text: "",
                        children: [
                          new TextSpan(
                            text: "Outcome",
                            style: new TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w700,
                              color: Colors.black
                            )
                          )
                        ]
                      ),
                    ),
                    ),
                    Container(
                    width: 440.0,
                    child:  new RichText(
                      textAlign: TextAlign.start,
                      text: new TextSpan(
                        text: "",
                        children: [
                          new TextSpan(
                            text: content["outcome"],
                            style: new TextStyle(
                              fontSize: 13.0,
                              height: 1.5,
                              fontWeight: FontWeight.w100,
                              color: Colors.black
                            )
                          )
                        ]
                      ),
                    ),
                    )
                  ],
                ),
                ),
                
              ),
          ),

        
         new Flexible(
            child: 
            contents.length > 0 ?
            ListView.builder(
              padding: EdgeInsets.all(5.0),
              itemCount: contents == null ? 0 : contents.length,
              itemBuilder: (BuildContext context, int index) {
                return new ContentTile(contents[index]);
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
                  Text("No contents added!")
                ],
              )
            )
          )
       ],
     )
    );
  }
}



