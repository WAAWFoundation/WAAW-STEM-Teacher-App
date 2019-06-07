import 'package:flutter/material.dart';
import 'package:validate/validate.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:kurriki/module/home/home.dart';


import 'package:kurriki/shared/style.dart';
import 'package:kurriki/shared/theme_data.dart';
// import 'package:kurriki/shared/form/ensure_visible.dart';
import 'package:kurriki/module/auth/login.dart';

import 'package:kurriki/module/auth/auth_service.dart';


import 'package:kurriki/utils/network.dart';
import 'package:kurriki/shared/shared_store.dart';

import 'package:kurriki/shared/env.dart';

import 'package:kurriki/shared/loader.dart';

class SignupPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _SignupPageState();
}

class _SignupData {
  String email = '';
  String first_name = '';
  String last_name = '';
  String  phone = '';
  String password = '';
}

class _SignupPageState extends State<SignupPage> {
final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  _SignupData _data = new _SignupData();
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
    if (value.length < 8) {
      return 'The Password must be at least 8 characters.';
    }

    return null;
  }

    String _validateRequired(String value) {
    if (value.length < 1) {
      return 'Phone Number Required!';
    }
    return null;
  }

  Future submit(context) async {
      _formKey.currentState.save(); // Save our form now.

      if (this._formKey.currentState.validate()) {
          Map<String, String> body = {
            'email': _data.email,
            'first_name': _data.first_name,
            'last_name': _data.last_name,
            'phone': _data.phone,
            'password': _data.password
          };
              print(body);
              print(url);


          await Env().getHeader().then((Map header){
           var response = http.post(
            Uri.encodeFull("$url/users"),
            headers: header,
            body: body
            ).then((response){
              // return response;
              print(response);
                if(response.statusCode == 201){
                  this.setState((){
                    this.loading = false;
                  });


                  final snackBar = SnackBar(
                    content: Text("Signup Successful!"),
                    backgroundColor: Colors.green,
                  );
                  Scaffold.of(context).showSnackBar(snackBar); 

                 new Future<bool>.delayed(
                    new Duration(
                      seconds: 5
                    ), (){
                      Scaffold.of(context).showSnackBar(snackBar); 
                      Navigator.push(context, new MaterialPageRoute(builder: (__) => new LoginPage()));
                    }
                  );
                }else{

                  final snackBar = SnackBar(
                    content: Text(response.statusCode.toString()),
                  backgroundColor: Colors.black45,
                  );
                  
                  Scaffold.of(context).showSnackBar(snackBar); 
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
        body:  new Container(
                padding: new EdgeInsets.all(20.0),
                decoration: new BoxDecoration( color: WaawColors.green[800]),
                child: SingleChildScrollView(
                    reverse: true,
                    child: new Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        new Container(
                          padding: EdgeInsets.only(top: screenSize.height / 6),
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
                                  height: screenSize.height / 5,
                              ))
                            ],
                          ),
                        ),
                        new Container(
                          padding: new EdgeInsets.only(
                             bottom: 10.0,
                          ),
                          child: new Text(
                                  'Sign Up',
                                  textAlign: TextAlign.center,
                                  // overflow: TextOverflow.ellipsis,
                                  style: new TextStyle(
                                    fontWeight: FontWeight.w500, 
                                    fontSize: 20.0,
                                    color: Colors.white, 
                                    ),
                                ),
                        ),
                       new Column(
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
                                          keyboardType: TextInputType.text, 
                                          decoration: new InputDecoration(
                                            prefixIcon: new Padding(
                                              padding: new EdgeInsets.only(top: 0.0),
                                              child: new Icon(Icons.add_circle_outline, color: Colors.blueGrey,),
                                            ),
                                            // labelText: 'Email Address',
                                            hintText: ' | First Name',
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
                                          
                                          
                                          validator: this._validateRequired,
                                          onSaved: (String value) {
                                            this._data.first_name = value;
                                          }
                                        ),
                                    ),
                                     new ListTile(
                                      // leading: const Icon(Icons.person),
                                      title: new TextFormField(
                                          keyboardType: TextInputType.text, 
                                          decoration: new InputDecoration(
                                            prefixIcon: new Padding(
                                              padding: new EdgeInsets.only(top: 0.0),
                                              child: new Icon(Icons.add_circle_outline, color: Colors.blueGrey,),
                                            ),
                                            // labelText: 'Email Address',
                                            hintText: ' | Last Name',
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
                                          
                                          
                                          validator: this._validateRequired,
                                          onSaved: (String value) {
                                            this._data.last_name = value;
                                          }
                                        ),
                                    ),
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
                                    new ListTile(
                                      // leading: const Icon(Icons.person),
                                      title: new TextFormField(
                                          keyboardType: TextInputType.number, // Use email input type for emails.
                                          decoration: new InputDecoration(
                                            prefixIcon: new Padding(
                                              padding: new EdgeInsets.only(top: 0.0),
                                              child: new Icon(Icons.call, color: Colors.blueGrey,),
                                            ),
                                            // labelText: 'Email Address',
                                            hintText: ' | Phone',
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
                                          validator: this._validateRequired,
                                          onSaved: (String value) {
                                            this._data.phone = value;
                                          }
                                        ),
                                    ),
                                    new ListTile(
                                      title:  new TextFormField(
                                          obscureText: true, // Use 
                                          decoration: new InputDecoration(
                                            prefixIcon: new Padding(
                                              padding: new EdgeInsets.only(top: 0.0),
                                              child: new Icon(Icons.lock, color: Colors.blueGrey,),
                                            ),
                                            // labelText: 'Email Address',
                                            hintText: ' | Password',
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
                                          validator: this._validatePassword,
                                          onSaved: (String value) {
                                            this._data.password = value;
                                          }
                                        ),
                                    ),
                                    
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
                                                        'Sign Up',
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
                                    new Container(
                                        child: new Row(
                                          children: [
                                            new Expanded(
                                                child: new Column(
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  children: [
                                                    new GestureDetector(
                                                        onTap: (){
                                                           Navigator.push(
                                                                context,
                                                                new MaterialPageRoute(builder: (context) => new LoginPage()),
                                                              );
                                                        },
                                                        child:  new Container(
                                                          decoration: BoxDecoration(
                                                            //color: WaawColors.green[700]
                                                          ),
                                                          

                                                          padding: const EdgeInsets.only(bottom: 0.0, right: 18.0, top: 10.0), 
                                                          child:  new Text(
                                                              'Login',
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
                                                   
                                                  ]
                                                )
                                              )
                                            ]
                                          )
                                      ),
                                  
                                  ],
                                ),
                              ),
                              // Container(
                              //  height: screenSize.height / 4
                              // )
                            ],
                        )
                      ],
                    ),
                ),

              ),
        
    );
  }
}