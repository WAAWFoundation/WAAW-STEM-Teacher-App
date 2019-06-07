import 'package:flutter/material.dart';
import 'package:kurriki/module/auth/login.dart';
import 'package:kurriki/module/auth/signup.dart';
import 'package:kurriki/module/chat/conversations.dart';
import 'package:kurriki/module/chat/conversation.dart';
import 'package:kurriki/module/curriculum/curriculum.dart';

import 'package:kurriki/module/home/home.dart';
import 'package:kurriki/module/static/faq.dart';
import 'package:kurriki/module/static/settings.dart';

final routes = {
  //  '/':         (BuildContext context) => new Home(),
  
   //home
   '/curriculums':         (BuildContext context) => new Curriculum(),
   '/conversations':         (BuildContext context) => new Conversations(),
  //  '/signup':         (BuildContext context) => new SignupPage(),
   '/faqs' :          (BuildContext context) => new Faq(),
   '/settings' :          (BuildContext context) => new Curriculum(),
  //  '/settings' :          (BuildContext context) => new Settings(),
   
};