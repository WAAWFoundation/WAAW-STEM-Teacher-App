import 'package:flutter/material.dart';
import 'package:kurriki/module/auth/login.dart';
import 'package:kurriki/module/home/home.dart';
import 'package:kurriki/module/auth/auth_service.dart';


import 'package:kurriki/shared/theme_data.dart';

import 'package:kurriki/module/curriculum/curriculum.dart';


import 'package:kurriki/shared/theme_data.dart';
import 'package:kurriki/shared/env.dart';
import 'package:kurriki/shared/shared_store.dart';
import 'package:kurriki/shared/controls.dart';
import 'dart:async';
import 'dart:math';
import 'package:kurriki/route.dart';
import 'dart:io' show HttpClient, HttpClientBasicCredentials, HttpClientCredentials;
import 'package:http/http.dart' as http;
import 'dart:convert';


void main() async {
AuthService appAuth = new AuthService();

  // Set default home.
  Widget _defaultHome = new LoginPage();
  // Widget _defaultHome = new Home();

  // Get result of the login function.
  bool _result = await appAuth.checkLoin();
  if (_result) {
    _defaultHome = new Curriculum();
  }

  // Run app!
  runApp(
    new MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'WAAW',
    home: _defaultHome,
    routes: routes
  )

  );

  
}
