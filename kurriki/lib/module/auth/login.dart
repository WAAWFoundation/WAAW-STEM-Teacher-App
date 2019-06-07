import 'package:flutter/material.dart';
import 'package:validate/validate.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;



import 'package:kurriki/shared/style.dart';
import 'package:kurriki/shared/theme_data.dart';
import 'package:kurriki/module/auth/signup.dart';
import 'package:kurriki/module/auth/password_reset.dart';

import 'package:kurriki/module/curriculum/curriculum.dart';

import 'package:kurriki/module/auth/auth_service.dart';


import 'package:kurriki/utils/network.dart';
import 'package:kurriki/shared/shared_store.dart';

import 'package:kurriki/shared/env.dart';
import 'package:kurriki/shared/loader.dart';


 class LoginUser {
  //Constructor
  String token;
  Map data;

    LoginUser.fromJson(Map json) {
    this.token = json['token'];
    this.data = json['data'];
  }

}



class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _LoginPageState();
}

class _LoginData {
  String email = '';
  String password = '';
}

class _LoginPageState extends State<LoginPage> {
final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  _LoginData _data = new _LoginData();
  var loading = false;

  String url = Env().apiUrl;

  String _validateEmail(String value) {
    // If empty value, the isEmail function throw a error.
    // So I changed this function with try and catch.
    try {
      Validate.isEmail(value);
    } catch (e) {
      return 'The E-mail Address must be a valid email address.';
    }
    return null;
  }

  String _validatePassword(String value) {
    if (value.length < 1) {
      return 'The Password must be at least 8 characters.';
    }

    return null;
  }

    Future<String> submit(context) async {
      _formKey.currentState.save(); // Save our form now.
       var auth = AuthService;
       if (this._formKey.currentState.validate()) {
          //  && _data.email.length > 0 && _data.password.length > 0 
           
          Map<String, String> body ={
                  'email': _data.email,
                  'password': _data.password
  
              };

          await Env().getHeader().then((Map header){

           var response = http.post(
            Uri.encodeFull("$url/login"),
            headers: header,
            body: body
            ).then((response){
                    Map responseJson = json.decode(response.body);
                        if(response.statusCode != 200){
                          this.setState((){
                            this.loading = false;
                          });
                        }else{
                            // print("Response body: ${responseJson["token"]}");
                            if(responseJson.containsKey('token')){
                              Map storeToken = {"key": "token", "value": responseJson["token"]};
                              Map storeUser= {"key": "user", "value": json.encode(responseJson["user"])};
                              SharedStore().updateStore(storeToken);
                              SharedStore().updateStore(storeUser);
                              
                              final snackBar = SnackBar(
                                content: Text("Login Successful!"),
                                backgroundColor: Colors.green,
                              );
                              Scaffold.of(context).showSnackBar(snackBar); 

                              new Future<bool>.delayed(
                                new Duration(
                                  seconds: 3
                                ), (){
                                  Navigator.push(context, new MaterialPageRoute(builder: (__) => new Curriculum()));
                                }
                              );
                                          

                            }else{
                            }

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
      backgroundColor: WaawColors.green[800],

        // key: _scaffoldKey,
        body:  SingleChildScrollView(
        padding: new EdgeInsets.all(10.0),
        reverse: true,
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            new Container(
              height: screenSize.height / 3,
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Center(
                      child: new Image(
                    image: logo,
                    width: (screenSize.width < 500)
                        ? 200.0
                        : (screenSize.width / 4) + 12.0,
//                              height: screenSize.height / 4 + 80,
                  ))
                ],
              ),
            ),
            new Container(
                padding: new EdgeInsets.only(bottom: 10.0, top: 5.0),
                child: new Column(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      //Padding between these please
                      new Text(
                        'Login',
                        textAlign: TextAlign.center,
                        // overflow: TextOverflow.ellipsis,
                        style: new TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 20.0,
                          color: Colors.white,
                        ),
                      ),
                    ])),
            new Container(
              // height: screenSize.height / 2,
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.center,
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
                                      keyboardType: TextInputType.emailAddress, // Use email input type for emails.
                                      decoration: new InputDecoration(
                                        prefixIcon: new Padding(
                                          padding: new EdgeInsets.only(top: 0.0),
                                          child: new Icon(Icons.mail_outline, color: Colors.blueGrey,),
                                        ),
                                        // labelText: 'Email Address',
                                        hintText: ' | Email Address',
                                        hintStyle: new TextStyle(
                                          color: Colors.blueGrey, 
                                          fontWeight: FontWeight.w100
                                          ),                                      
                                        filled: true,
                                        fillColor: Colors.white,
                                        border: UnderlineInputBorder(
                                          borderSide: BorderSide.none,
                                        ),
                                        contentPadding: new EdgeInsets.all(10.0)
                                      ),
                                      validator: this._validateEmail,
                                      onSaved: (String value) {
                                        this._data.email = value;
                                      }
                                    ),
                                ),
                                new Padding(padding: new EdgeInsets.all(5.0),),
                         new ListTile(
                                  // leading: const Icon(Icons.phone),
                                  title:  new TextFormField(
                                      obscureText: true, // Use secure text for passwords.
                                      decoration: new InputDecoration(
                                          //labelText: 'Enter your password',
                                          hintText: ' | Password',
                                          prefixIcon: new Padding(
                                          padding: new EdgeInsets.only(top: 0.0),
                                          child: new Icon(Icons.lock_outline, color: Colors.blueGrey,),
                                        ),
                                        hintStyle: new TextStyle(
                                          color: Colors.blueGrey, 
                                          fontWeight: FontWeight.w100
                                        ),                                      
                                        filled: true,
                                        fillColor: Colors.white,
                                        border: UnderlineInputBorder(
                                          borderSide: BorderSide.none,
                                        ),
                                        contentPadding: new EdgeInsets.all(10.0
                                        )
                                      ),
                                      validator: this._validatePassword,
                                      onSaved: (String value) {
                                        this._data.password = value;
                                      }
                                    ),
                                ),
                        new Container(
                            child: new Row(children: [
                          new Expanded(
                              child: new Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    new GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          new MaterialPageRoute(
                                              builder: (context) =>
                                                  new PasswordReset()),
                                        );
                                      },
                                      child: new Container(
                                        padding: const EdgeInsets.only(
                                            bottom: 30.0, right: 18.0),
                                        child: new Text(
                                          'Forget your password?',
                                          textAlign: TextAlign.left,
                                          // overflow: TextOverflow.ellipsis,
                                          style: new TextStyle(
                                            fontWeight: FontWeight.w300,
                                            fontSize: 16.0,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    )
                              ]))
                        ])),
                        new Builder(
                                      // Create an inner BuildContext so that the onPressed methods
                                      // can refer to the Scaffold with Scaffold.of().
                                      builder: (BuildContext context) {
                                        return new ListTile(
                                          title:   new  RaisedButton(
                                            child: new Row(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              mainAxisAlignment: MainAxisAlignment.center,
                                                  children: <Widget>[
                                                    new Center(
                                                      child: new Text(
                                                        'Login',
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
                                              // color: WevoteColors.green[700],
                                              padding: EdgeInsets.all(10.0),
                                              
                                            )
                                        );
                      
                                      },
                                    ),
                        new Container(
                            child: new Row(children: [
                          new Expanded(
                              child: new Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                new GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      new MaterialPageRoute(
                                          builder: (context) =>
                                              new SignupPage()),
                                    );
                                  },
                                  child: new Container(
                                    padding: const EdgeInsets.only(
                                        bottom: 0.0, right: 18.0),
                                    child: new Text(
                                      'Don’t have an account?',
                                      textAlign: TextAlign.left,
                                      // overflow: TextOverflow.ellipsis,
                                      style: new TextStyle(
                                        fontWeight: FontWeight.w300,
                                        fontSize: 16.0,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ]))
                        ])),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
        // body:  SingleChildScrollView(
        //       padding: new EdgeInsets.all(10.0),
        //       reverse: true,
        //       child: new Column(
        //           crossAxisAlignment: CrossAxisAlignment.center, 
        //           mainAxisAlignment: MainAxisAlignment.end,
        //           children: <Widget>[
        //             new Expanded(
        //               child: new Padding(
        //                 padding: new EdgeInsets.all(30.0),
        //               ),
        //             ),
        //             new Expanded(
        //               child: new Padding(
        //                 padding: new EdgeInsets.all(30.0),
        //               ),
        //             ),
        //             new Container(
        //               // height: screenSize.height / 3,
        //               child: new Column(
        //                 crossAxisAlignment: CrossAxisAlignment.center,
        //                 mainAxisAlignment: MainAxisAlignment.center,
        //                 children: <Widget>[
        //                   new Center(
        //                       child: new Image(
        //                     image: logo,
        //                     width: (screenSize.width < 500)
        //                         ? 200.0
        //                         : (screenSize.width / 4) + 12.0,
        //                     //  height: screenSize.height / 4 + 80,
        //                   ))
        //                 ],
        //               ),
        //             ),
        //             new Expanded(
        //               child: new Padding(
        //                 padding: new EdgeInsets.all(5.0),
        //               ),
        //             ),
        //             new Padding(padding: new EdgeInsets.symmetric(vertical: 10.0),),
        //             new Container(
        //               padding: new EdgeInsets.only(
        //                  bottom: 10.0,
        //                 top: 5.0
        //               ),
        //               child: new Column(
        //                 // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //                 // crossAxisAlignment: CrossAxisAlignment.center,
        //                 children: <Widget> [ //Padding between these please
        //                     new Text(
        //                       'Login',
        //                       textAlign: TextAlign.center,
        //                       // overflow: TextOverflow.ellipsis,
        //                       style: new TextStyle(
        //                         fontWeight: FontWeight.w500, 
        //                         fontSize: 20.0,
        //                         color: Colors.white,
        //                         // fontFamily: Font 
        //                         ),
        //                     ), 
        //                 ]
        //               )
        //             ),

        //             new Container(
        //               // height: screenSize.height / 2,
        //               child: new Column(
        //                 // crossAxisAlignment: CrossAxisAlignment.center,
        //                 mainAxisAlignment: MainAxisAlignment.center,
        //                 children: <Widget>[
                          
        //                   new Form(
        //                     key: this._formKey,
        //                     child: new Column(
        //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //                       children: <Widget>[
                                
        //                         new ListTile(
        //                           // leading: const Icon(Icons.person),
        //                           title: new TextFormField(
        //                               keyboardType: TextInputType.emailAddress, // Use email input type for emails.
        //                               decoration: new InputDecoration(
        //                                 prefixIcon: new Padding(
        //                                   padding: new EdgeInsets.only(top: 0.0),
        //                                   child: new Icon(Icons.mail_outline, color: Colors.blueGrey,),
        //                                 ),
        //                                 // labelText: 'Email Address',
        //                                 hintText: ' | Email Address',
        //                                 hintStyle: new TextStyle(
        //                                   color: Colors.blueGrey, 
        //                                   fontWeight: FontWeight.w100
        //                                   ),                                      
        //                                 filled: true,
        //                                 fillColor: Colors.white,
        //                                 border: UnderlineInputBorder(
        //                                   borderSide: BorderSide.none,
        //                                 ),
        //                                 contentPadding: new EdgeInsets.all(10.0)
        //                               ),
        //                               validator: this._validateEmail,
        //                               onSaved: (String value) {
        //                                 this._data.email = value;
        //                               }
        //                             ),
        //                         ),
        //                         new Padding(padding: new EdgeInsets.all(5.0),),
        //                         new ListTile(
        //                           // leading: const Icon(Icons.phone),
        //                           title:  new TextFormField(
        //                               obscureText: true, // Use secure text for passwords.
        //                               decoration: new InputDecoration(
        //                                   //labelText: 'Enter your password',
        //                                   hintText: ' | Password',
        //                                   prefixIcon: new Padding(
        //                                   padding: new EdgeInsets.only(top: 0.0),
        //                                   child: new Icon(Icons.lock_outline, color: Colors.blueGrey,),
        //                                 ),
        //                                 hintStyle: new TextStyle(
        //                                   color: Colors.blueGrey, 
        //                                   fontWeight: FontWeight.w100
        //                                 ),                                      
        //                                 filled: true,
        //                                 fillColor: Colors.white,
        //                                 border: UnderlineInputBorder(
        //                                   borderSide: BorderSide.none,
        //                                 ),
        //                                 contentPadding: new EdgeInsets.all(10.0
        //                                 )
        //                               ),
        //                               validator: this._validatePassword,
        //                               onSaved: (String value) {
        //                                 this._data.password = value;
        //                               }
        //                             ),
        //                         ),
                               
        //                          new Builder(
        //                               // Create an inner BuildContext so that the onPressed methods
        //                               // can refer to the Scaffold with Scaffold.of().
        //                               builder: (BuildContext context) {
        //                                 return new ListTile(
        //                                   title:   new  RaisedButton(
        //                                     child: new Row(
        //                                       crossAxisAlignment: CrossAxisAlignment.center,
        //                                       mainAxisAlignment: MainAxisAlignment.center,
        //                                           children: <Widget>[
        //                                             new Center(
        //                                               child: new Text(
        //                                                 'Login',
        //                                                 style: new TextStyle(
        //                                                   color: Colors.white,
        //                                                   fontWeight: FontWeight.w100,
        //                                                   fontSize: 20.0,
        //                                                 ),
        //                                             ),
        //                                             ),
        //                                             new Loader(loading)
        //                                           ],
        //                                         ),
        //                                       onPressed: () async {
        //                                         this.setState((){
        //                                           this.loading = true;
        //                                         });
                                              

        //                                         await submit(context).then((response){
                                                  
        //                                         });
                                                
        //                                       },
        //                                       color: WaawColors.green[700],
        //                                       padding: EdgeInsets.all(10.0),
                                              
        //                                     )
        //                                 );
                      
        //                               },
        //                             ),
        //                         // new ListTile(
        //                         //   // leading: const Icon(Icons.phone),
        //                         //   title:  new RaisedButton(
        //                         //      child: new Row(
        //                         //        crossAxisAlignment: CrossAxisAlignment.center,
        //                         //        mainAxisAlignment: MainAxisAlignment.center,
        //                         //           children: <Widget>[
        //                         //             new Center(
        //                         //               child: new Text(
        //                         //                 'Log In',
        //                         //                 style: new TextStyle(
        //                         //                   color: Colors.white,
        //                         //                   fontWeight: FontWeight.w100,
        //                         //                   fontSize: 20.0,
        //                         //                 ),
        //                         //             ),
        //                         //             ),
        //                         //             new Loader(loading)
        //                         //           ],
        //                         //         ),
        //                         //       onPressed: () async {
        //                         //         this.setState((){
        //                         //           this.loading = true;
        //                         //         });
        //                         //          await submit(context).then((response){
                                                  
        //                         //                 });
                                        
        //                         //       },
        //                         //       color: WaawColors.green[700],
        //                         //       padding: EdgeInsets.all(10.0),
                                      
        //                         //     ),
        //                         // ),
                                
        //                          new Container(
        //                             // padding: new EdgeInsets.only(top: 30.0),
        //                             child: new Row(
        //                               mainAxisAlignment: MainAxisAlignment.center,
        //                               children: [
                                        
        //                                 new Expanded(
        //                                     child: new Column(
        //                                       crossAxisAlignment: CrossAxisAlignment.center,
        //                                       children: [
        //                                          new Container(
        //                                           padding: const EdgeInsets.only(bottom: 10.0),
        //                                           child:  new Text(
        //                                               'Forget password?',
        //                                               textAlign: TextAlign.left,
        //                                               // overflow: TextOverflow.ellipsis,
        //                                               style: new TextStyle(
        //                                                 fontWeight: FontWeight.w300, 
        //                                                 fontSize: 16.0,
        //                                                 color: Colors.white,
        //                                                 ),
        //                                             ),
        //                                         ),
        //                                          new GestureDetector(
        //                                             onTap: (){
        //                                                Navigator.push(
        //                                                     context,
        //                                                     new MaterialPageRoute(builder: (context) => new SignupPage()),
        //                                                   );
        //                                             },
        //                                             child:  new Container(
        //                                               padding: const EdgeInsets.only(bottom: 30.0, right: 18.0),
                                                      
        //                                               child:  new Text(
        //                                                   'Signup',
        //                                                   textAlign: TextAlign.left,
        //                                                   // overflow: TextOverflow.ellipsis,
        //                                                   style: new TextStyle(
        //                                                     fontWeight: FontWeight.w300, 
        //                                                     fontSize: 16.0,
        //                                                     color: Colors.white,
        //                                                     ),
                                                            
        //                                                 ),
                                                        
        //                                             ),
        //                                         ),
                                            
        //                                       ]
        //                                     )
        //                                   )
        //                                 ]
        //                               )
        //                         ),
                                
                                 
                              
        //                       ],
        //                     ),
        //                   ),
                         
        //                 ],
        //               ),
        //             ),
        //             new Expanded(
        //               child: new Padding(
        //                 padding: new EdgeInsets.all(30.0),
        //               ),
        //             )
        //           ],
        //         ),

        //       ),
        
    );
  }
}