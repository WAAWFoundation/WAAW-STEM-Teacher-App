import 'package:flutter/material.dart';
import 'dart:async';


import 'package:kurriki/shared/theme_data.dart';

import 'package:kurriki/components/drawer.dart';
import 'package:kurriki/module/auth/auth_service.dart';
import 'package:kurriki/module/auth/login.dart';
import 'package:kurriki/module/curriculum/curriculum.dart';
import 'package:kurriki/module/curriculum/topics.dart';
import 'package:kurriki/module/chat/conversation.dart';


import 'package:kurriki/shared/theme_data.dart';
import 'package:kurriki/shared/env.dart';
import 'package:kurriki/shared/shared_store.dart';
import 'package:kurriki/shared/controls.dart';
import 'dart:async';
import 'dart:math';
import 'dart:io' show HttpClient, HttpClientBasicCredentials, HttpClientCredentials;
import 'package:http/http.dart' as http;
import 'dart:convert';



class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: new ThemeData(
          brightness: Brightness.light,
          primaryColor: WaawColors.green[800], //Changing this will change the color of the TabBar
          accentColor: Colors.cyan[600],
        ),
        home: DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: AppBar(
              centerTitle: false,
              //  backgroundColor: WaawColors.green[700],
              title: new Text(
                  'WAAW MOBILE', 
                  style: new TextStyle(
                    color: Colors.white70,
                    fontSize: Theme.of(context).platform == TargetPlatform.iOS ? 17.0 : 20.0,
                    fontWeight: FontWeight.w700,
                    // fontFamily: 
                  ),
                ),
                elevation: Theme.of(context).platform == TargetPlatform.iOS ? 4.0 : 4.0,
              actions: <Widget>[
               
                new Icon(Icons.sync),
              ],
              bottom: TabBar(
                indicator: BoxDecoration(
                  color: WaawColors.green[700]
                ),
                // labelColor: Colors.black,
                labelStyle: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w700,
                  

                ),
                tabs: <Widget>[
                  Tab(
                    // icon: Icon(Icons.home),
                    text: 'Curriculums',
                  ),
                  Tab(
                    // icon: Icon(Icons.favorite),
                    text: "Groups Chat",
                  )
                ],
              ),
            ),
            body: TabBarView(
              children: <Widget>[
                Curriculum(),
                Topics([]),
                // Conversation(),
                // LoginPage(),
              ],
            ),
            drawer: new MenuDrawer(),
          ),
        ));
  }
}
