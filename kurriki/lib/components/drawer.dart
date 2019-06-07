import 'package:flutter/material.dart';
import 'dart:async';

import 'package:kurriki/shared/style.dart';
import 'package:kurriki/module/auth/login.dart';
import 'package:kurriki/module/auth/auth_service.dart';
import 'package:kurriki/shared/shared_store.dart';

import 'package:kurriki/shared/theme_data.dart';
import 'package:kurriki/shared/controls.dart';

class MenuDrawer extends StatefulWidget{

  // var  _election = Polls();
  @override
  State<StatefulWidget> createState() => new MenuDrawerState();
}
class MenuDrawerState extends State<MenuDrawer> {

    String userName = "";
    String userEmail = "";


  Future<String> getUser() async {
    this.setState((){ 
      var user = SharedStore().getUser().then((response){
        print(response);
      this.userName = response["account"]["first_name"] + " " + response["account"]["last_name"]; 
      this.userEmail = response["email"];
      });
    });
    return "";
  }

  @override
  void initState() {
      // TODO: implement initState
      super.initState();
      this.getUser();
  }
  

  @override
  Widget build(BuildContext context) {
    return (
       new Drawer(
        child: new ListView(
          children: <Widget>[
            // new UserAccountsDrawerHeader(
            //   decoration: new BoxDecoration(
            //     color: WaawColors.green[800]
                
            //   ),
            //   accountName:  new Text(this.userName),
            //   accountEmail: new Text(this.userEmail),
            //   currentAccountPicture: new CircleAvatar(
            //     backgroundColor: Colors.white70,
            //     // backgroundImage:  new ExactAssetImage(
            //     //    "assets/user.png"
            //     // )
            //   ),
             
            //   margin: EdgeInsets.zero,
            // ),
            Container(
             height: 100.0,
             padding: EdgeInsets.all(20.0),
             decoration: BoxDecoration(
               color: WaawColors.green[800]
             ),
              child: Row(
                children: <Widget>[
                  ClipOval(
                  clipper: new CircleClipper(),
                  child: new Container(
                      decoration: BoxDecoration(color: WaawColors.green[700]),
                      width: 50.0,
                      height: 50.0,
                      child: Center(
                        child: Icon(Icons.account_circle, size: 50.0, color: Colors.white70)
                          
                      )
                      ),
                  ),
                  Expanded(

                    child: Container(
                      padding: EdgeInsets.all(5.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          new RichText(
                          text: TextSpan(
                            children: [
                              new TextSpan(
                                text: this.userName,
                                style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w700
                                )
                              ),
                              // new TextSpan(
                              //   text: "imo@reimnet.com"
                              // )
                            ]
                          ),
                        ),
                        new RichText(
                          text: TextSpan(
                            children: [
                              new TextSpan(
                                text: this.userEmail,
                                style: TextStyle(
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.w100
                                )
                              ),
                              // new TextSpan(
                              //   text: "imo@reimnet.com"
                              // )
                            ]
                          ),
                        ),
                        ],
                      )
                    )
                  )
                ],
              ),
            ),
           
           
            new ListTile(
              leading: new Icon(Icons.library_books),
              title: new Text('Curriculums'),
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).pushNamed('/curriculums');
              }
            ),
            new ListTile(
              leading: new Icon(Icons.chat),
              title: new Text('Conversations'),
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).pushNamed('/conversations');
              }
            ),
            new ListTile(
              leading: new Icon(Icons.settings),
              title: new Text('Settings'),
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).pushNamed('/settings');
              }
            ),
            
            
          
            new Divider(),
            new ListTile(
              leading: new Icon(Icons.exit_to_app),
              title: new Text('Sign Out'),
              onTap: () async {
              bool logout = await AuthService().logout();
              print(logout);
              // Future<dynamic> db =  WevoteDatabase.get().deleteAll();
              Navigator.push(context, new MaterialPageRoute(builder: (__) => new LoginPage()));
              }
            ),
          ],
        )
      )
    );
  }
}
