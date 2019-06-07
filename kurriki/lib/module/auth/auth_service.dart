import 'dart:async';
import 'dart:math';
import 'dart:io' show HttpClient, HttpClientBasicCredentials, HttpClientCredentials;
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:kurriki/shared/shared_store.dart';

import 'package:kurriki/utils/network.dart';
//  import 'package:kurriki/module/auth/models/user.dart';
// import 'package:kurriki/module/auth/auth_service.dart';



class AuthService {
  // NetworkUtil _netUtil = new NetworkUtil();
  // Login
  Future<bool> checkLoin() async {
    bool returned;
    // Simulate a future for response after 2 second.
  String token =  await SharedStore().getToken().then((response){
    var kk = response.toString();
        print('login: $response');
        // return true;
        if(response == null){
           returned =  false;
        }else{
           returned =  true;
        }
    });
   return returned;
  }

  // Logout
  Future<bool> logout() async {
    await SharedStore().deleteStore("token");
    await SharedStore().deleteStore("user");
    return true;
  }



}
