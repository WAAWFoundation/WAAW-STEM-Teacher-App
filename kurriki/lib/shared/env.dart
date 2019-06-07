
import 'package:kurriki/module/auth/auth_service.dart';


import 'package:kurriki/utils/network.dart';
import 'package:kurriki/shared/shared_store.dart';
import 'dart:async';
import 'dart:math';
import 'dart:io' show HttpClient, HttpClientBasicCredentials, HttpClientCredentials;
import 'package:http/http.dart' as http;
import 'dart:convert';

class Env {
  Env();

  String apiUrl= "http://127.0.0.1:4070"; //localhost
  // String apiUrl= "https://waawapi.herokuapp.com";

  Future<Map> getAuthHeader() async {
    var token =  await SharedStore().getToken() ;
    Map<String, String> header = {
         "Accept": "application/json",
         "Authorization": "bearer $token"
    };
    return header; 
  }

   Future<Map> getHeader() async {
    Map<String, String> header = {
         "Accept": "application/json",
    };
    return header; 
  }



}