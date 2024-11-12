import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:news_api/models/signUpModel.dart';
import 'package:news_api/screens/Widgets/uiHelper.dart';
import 'package:http/http.dart' as http;

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  TextEditingController usernamecontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign Up Screen"),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          UiHelper.CustomTextField(emailcontroller, "Email"),
          UiHelper.CustomTextField(passwordcontroller, "password"),
          UiHelper.CustomTextField(emailcontroller, "username"),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
              onPressed: () {
                signup(
                    emailcontroller.text.toString(),
                    passwordcontroller.text.toString(),
                    usernamecontroller.text.toString());
              },
              child: Text("Sign Up"))
        ],
      ),
    );
  }

  signup(String email, String password, String username) async {
    if (email == "" || password == "" || username == "") {
      return ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Enter Required Field's")));
    } else {
      final respose = await http.post(Uri.parse("https://reqres.in/api/signup"),
          body: jsonEncode(
              {"email": email, "password": password, "username": username}),
          headers: {"Content-Type": "application/json"});
      if (respose.statusCode == 200) {
        Map<String, dynamic> responsedata = jsonDecode(respose.body);
        signUpModel signUpmodel = signUpModel.fromJson(responsedata);
        String msg = responsedata['message'];
        log(msg.toString());
        // log(signUpModel.toString());
      } else {
        log(respose.body);
      }
    }
  }
}
