import 'package:flutter/material.dart';
import 'package:validate/validate.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;



import 'package:kurriki/shared/style.dart';
import 'package:kurriki/shared/theme_data.dart';
import 'package:kurriki/module/auth/signup.dart';
import 'package:kurriki/module/chat/conversation.dart';


import 'package:kurriki/module/auth/auth_service.dart';


import 'package:kurriki/utils/network.dart';
import 'package:kurriki/shared/shared_store.dart';

import 'package:kurriki/shared/env.dart';
import 'package:kurriki/shared/loader.dart';


 class NewConversation {
  //Constructor
  String name;
  Map description;

    NewConversation.fromJson(Map json) {
    this.name = json['name'];
    this.description = json['description'];
  }

}



class NewConversationPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _NewConversationState();
}


class _NewConversationData {
  String name = '';
  String description = '';
}

class _NewConversationState extends State<NewConversationPage> {
final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  _NewConversationData _data = new _NewConversationData();
  var loading = false;

  String url = Env().apiUrl;

 

  String _validateRequired(String value) {
    if (value.length < 1) {
      return 'Required!';
    }

    return null;
  }

    Future<String> submit(context) async {
      _formKey.currentState.save(); // Save our form now.
       var auth = AuthService;
        if(this._formKey.currentState.validate()) {

           String url = Env().apiUrl;
          var token =  await SharedStore().getToken() ;    
          await Env().getAuthHeader().then((Map header){
          
          Map<String, String> body ={
            'name': _data.name,
            'description': _data.description,
            "topic_id": ""
          };
          var response = http.post(
              Uri.encodeFull("$url/conversations"),
              headers: header,
              body: body
            ).then((response){ 
                     Map responseJson = json.decode(response.body);
                        if(response.statusCode != 201){
                          this.setState((){
                            this.loading = false;
                          });
                          final snackBar = SnackBar(
                                content: Text("Error!"),
                                backgroundColor: Colors.red,
                              );
                              Scaffold.of(context).showSnackBar(snackBar); 

                          }else{
                            
                              final snackBar = SnackBar(
                                content: Text(" Converation Started!"),
                                backgroundColor: Colors.green,
                              );
                              Scaffold.of(context).showSnackBar(snackBar); 

                              new Future<bool>.delayed(
                                new Duration(
                                  seconds: 3
                                ), (){
                                   Navigator.of(context).push(
                                      new MaterialPageRoute(
                                        builder: (context) => new Conversation(responseJson["data"])
                                      )
                                    );
                                }
                              );
                                          


                        }
              });


              
          });
         
      }

    }


  @override
  Widget build(BuildContext context) {
    // this.context = context;
    final Size screenSize = MediaQuery.of(context).size;
    //print(context.widget.toString());
    // Validations validations = new Validations();
    return new Scaffold(
        appBar: new AppBar(
          backgroundColor: WaawColors.green[800],
          title: new Text(
            "New Conversation", 
            style: new TextStyle(
              fontSize: Theme.of(context).platform == TargetPlatform.iOS ? 17.0 : 20.0,
            ),
          ),
          elevation: Theme.of(context).platform == TargetPlatform.iOS ? 0.0 : 4.0,
        ),
        // key: _scaffoldKey,
        body:  new Container(
                padding: new EdgeInsets.all(20.0),
                // decoration: new BoxDecoration( color: WaawColors.green[800]),
                child: new Column(
                  
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                   

                    new Container(
                      // height: screenSize.height / 2,
                      child: new Column(
                        // crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          
                          new Form(
                            key: this._formKey,
                            child: new Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                
                                new ListTile(
                                  // leading: const Icon(Icons.person),
                                  title: new TextFormField(
                                      keyboardType: TextInputType.emailAddress, 
                                      decoration: new InputDecoration(
                                        border: new OutlineInputBorder(
                                            borderRadius: BorderRadius
                                                .all(Radius.circular(5.0))),
                                        labelText: 'Conversation Topic',
                                        hintStyle: new TextStyle(
                                            color: Colors.black87,
                                            fontWeight: FontWeight.w700),
                                        filled: true,
                                        fillColor: Colors.white,
                                        contentPadding: new EdgeInsets.only(
                                            bottom: 12.0, top: 12.0, left: 20.0)
                                      ),
                                      validator: this._validateRequired,
                                      onSaved: (String value) {
                                        this._data.name = value;
                                      }
                                    ),
                                ),
                                new Padding(padding: new EdgeInsets.all(5.0),),
                                new ListTile(
                                  // leading: const Icon(Icons.phone),
                                  title:  new TextFormField( 
                                    keyboardType: TextInputType.multiline,
                                    maxLines: 10,
                                    decoration: new InputDecoration(
                                        border: new OutlineInputBorder(
                                            borderRadius: BorderRadius
                                                .all(Radius.circular(5.0))),
                                        labelText: 'Conversation Description',
                                        // prefixIcon: new Padding(
                                        //   padding: EdgeInsets.only(left: 1.0),
                                        //   child: Icon(Icons.message),
                                        // ),
                                        hintStyle: new TextStyle(
                                            color: Colors.black87,
                                            fontWeight: FontWeight.w700),
                                        filled: true,
                                        fillColor: Colors.white,
                                        contentPadding: new EdgeInsets.only(
                                            bottom: 12.0, top: 12.0, left: 20.0)
                                      ),
                                      onSaved: (String value) {
                                        this._data.description = value;
                                      }
                                    ),
                                ),
                               
                                 new Builder(
                                      builder: (BuildContext context) {
                                        return new ListTile(
                                          title:   new  RaisedButton(
                                            child: new Row(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              mainAxisAlignment: MainAxisAlignment.center,
                                                  children: <Widget>[
                                                    new Center(
                                                      child: new Text(
                                                        'Start Conversation',
                                                        style: new TextStyle(
                                                          color: Colors.white,
                                                          fontWeight: FontWeight.w100,
                                                          fontSize: 20.0,
                                                        ),
                                                    ),
                                                    ),
                                                    new Loader(loading)
                                                  ],
                                                ),
                                              onPressed: () async {
                                                this.setState((){
                                                  this.loading = true;
                                                });
                                              

                                                await submit(context).then((response){
                                                  
                                                });
                                                
                                              },
                                              color: WaawColors.green[700],
                                              padding: EdgeInsets.all(10.0),
                                              
                                            )
                                        );
                      
                                      },
                                    ),
                              ],
                            ),
                          ),
                         
                        ],
                      ),
                    ),
                    new Expanded(
                      child: new Padding(
                        padding: new EdgeInsets.all(30.0),
                      ),
                    )
                  ],
                ),

              ),
        
    );
  }
}