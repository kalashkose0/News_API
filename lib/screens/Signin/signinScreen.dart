import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:news_api/models/signInModel.dart';
import 'package:news_api/screens/Widgets/uiHelper.dart';
import 'package:http/http.dart' as http;

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("SignIn Screen"),
          centerTitle: true,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            UiHelper.CustomTextField(emailcontroller, "Email"),
            UiHelper.CustomTextField(passwordcontroller, "password"),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () {
                  signin(
                    emailcontroller.text.toString(),
                    passwordcontroller.text.toString(),
                  );
                },
                child: Text("SignIn"))
          ],
        ));
  }

  signin(String email, String password) async {
    if (email == "" || password == "") {
      return ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Enter Required Field's")));
    } else {
      final respose = await http.post(Uri.parse("https://reqres.in/api/signin"),
          body: jsonEncode({"email": email, "password": password}),
          headers: {"Content-Type": "application/json"});
      if (respose.statusCode == 200) {
        Map<String, dynamic> responsedata = jsonDecode(respose.body);
        signInModel signinmodel = signInModel.fromJson(responsedata);
        String msg = responsedata['message'];
        log(msg.toString());
        // log(signinModel.toString());
      } else {
        log(respose.body);
      }
    }
  }
}
