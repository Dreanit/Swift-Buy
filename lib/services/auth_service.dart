import 'dart:convert';

import 'package:amazon_clone/constants/error_handling.dart';
import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/features/home/screens/home_screen.dart';
import 'package:amazon_clone/models/user.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/utils.dart';

class AuthService {
  //Sign up user
  void signUpUser(
      {required String email,
      required String name,
      required String password,
      required String address,
      required BuildContext context}) async {
    try {
      User user = User(
          id: "",
          name: name,
          token: "",
          type: "",
          email: email,
          address: address,
          password: password);
      http.Response response = await http.post(Uri.parse('$uri/api/signup'),
          body: user.toJson(),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          });
      httpErrorHandle(
          response: response,
          context: context,
          onSuccess: () {
            showSnackbar(
                context, "Account created! Login with same credentials!");
          });
    } catch (e) {
      showSnackbar(context, e.toString());
      rethrow;
    }
  }

  //Sign up user
  void signInUser(
      {required String email,
      required String password,
      required BuildContext context}) async {
    try {
      User user = User(
          id: "",
          name: "",
          token: "",
          type: "",
          email: email,
          address: "",
          password: password);
      http.Response response = await http.post(Uri.parse('$uri/api/signin'),
          body: user.toJson(),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          });
      httpErrorHandle(
          response: response,
          context: context,
          onSuccess: () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            Provider.of<UserProvider>(context, listen: false)
                .setUser(response.body);
            await prefs.setString(
                "x-auth-token", jsonDecode(response.body)["token"]);
            Navigator.pushNamedAndRemoveUntil(
                context, HomeScreen.routeName, (route) => false);
          });
      // print(response.body);
    } catch (e) {
      showSnackbar(context, e.toString());
      rethrow;
    }
  }

  //get user data
  void getUserData(BuildContext context) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');
      if (token == null) {
        prefs.setString('x-auth-token', "");
      }
    var tokenRes= await http.post(Uri.parse('$uri/tokenIsValid',),
            headers: <String,String>{
              'Content-Type':'application/json; charset=UTF-8',
              'x-auth-token':token!
            });
  var response=jsonDecode(tokenRes.body);

  if(response){
    //get user data
  http.Response userRes=  await http.get(Uri.parse('$uri/'),  headers: <String,String>{
      'Content-Type':'application/json; charset=UTF-8',
      'x-auth-token':token
    });
    var userProvider= Provider.of<UserProvider>(context,listen: false);
    userProvider.setUser(userRes.body);
  }
    } catch (e) {
      showSnackbar(context, e.toString());
      rethrow;
    }
  }
}
