import 'dart:convert';

import 'package:amazon_clone/constants/error_handling.dart';
import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/features/home/screens/home_screen.dart';
import 'package:amazon_clone/helpers/ServiceHelpers/apiHelper.dart';
import 'package:amazon_clone/helpers/ServiceHelpers/apiResponse.dart';
import 'package:amazon_clone/models/user.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/utils.dart';
import '../features/common_widgets/bottom bar.dart';

class AuthService {
  ApiHelper helper = ApiHelper();
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

      ApiResponse response =
          await helper.post('api/signup', context, querryParam: user.toJson());
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
      ApiResponse response = await helper.post("api/signin", context,
          querryParam: {"email": email, "password": password});
      SharedPreferences prefs = await SharedPreferences.getInstance();
      Provider.of<UserProvider>(context, listen: false)
          .setUser(jsonEncode(response.data));
      await prefs.setString("x-auth-token", response.data["token"]);
      if (!response.error) {
        Navigator.pushNamedAndRemoveUntil(
            context, BottomBar.routeName, (route) => false);
      } else {
        showSnackbar(context, "Oops Something went wrong!!");
      } // print(response.body);
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
      var tokenRes = await http.post(
          Uri.parse(
            '$uri/tokenIsValid',
          ),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': token!
          });
      var response = jsonDecode(tokenRes.body);

      if (response) {
        //get user data
        http.Response userRes = await http.get(Uri.parse('$uri/'),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
              'x-auth-token': token
            });
        var userProvider = Provider.of<UserProvider>(context, listen: false);
        userProvider.setUser(userRes.body);
      }
    } catch (e) {
      showSnackbar(context, e.toString());
      rethrow;
    }
  }
}
