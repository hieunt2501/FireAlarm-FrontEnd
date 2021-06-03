// import 'dart:convert';
import 'package:firealarm/constants/colors.dart';
import 'package:firealarm/providers/auth_provider.dart';
import 'package:firealarm/utils/routes/routes.dart';
import 'package:provider/provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
// import 'package:http/http.dart' as http;
// import '../../constants/api.dart';

class EmailInput extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => EmailInputState();
}

class EmailInputState extends State<EmailInput> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  String email;
  String password;
  String message;
  // SharedPreferences localStorage;

  @override
  void initState() {
    super.initState();
    email = "";
    password = "";
    message = "";
  }

  bool okToLogin() {
    if (!EmailValidator.validate(email)) {
      message = "Invalid email!";
      print(message);
      return false;
    }
    if (email.isEmpty || password.isEmpty) {
      message = "Email or password missing!";
      print(message);
      return false;
    }
    message = "";
    return true;
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    final authProvider = Provider.of<AuthProvider>(context);
    return Container(
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              message,
              style: TextStyle(color: Colors.red),
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            height: height / 15,
            decoration: BoxDecoration(
                color: AppColors.kPrimaryColor,
                borderRadius: BorderRadius.circular(8)),
            child: TextFormField(
              controller: emailController,
              onChanged: (value) {
                email = value;
                setState(() {});
              },
              cursorColor: Colors.black,
              decoration: new InputDecoration(
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  contentPadding:
                      EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                  hintText: "Email"),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Container(
            padding: EdgeInsets.all(10),
            height: height / 15,
            decoration: BoxDecoration(
                color: AppColors.kPrimaryColor,
                borderRadius: BorderRadius.circular(8)),
            child: TextFormField(
              controller: passwordController,
              onChanged: (value) {
                password = value;
                setState(() {});
              },
              obscureText: true,
              cursorColor: Colors.black,
              decoration: new InputDecoration(
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  contentPadding:
                      EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                  hintText: "Password"),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 15),
            child: ElevatedButton(
                onPressed: () async {
                  FocusScope.of(context).unfocus();

                  bool status =
                      await authProvider.signIn(this.email, this.password);

                  if (status && okToLogin()) {
                    Navigator.pushNamed(context, Routes.home);
                  }
                },
                style: ButtonStyle(
                    minimumSize: MaterialStateProperty.all<Size>(Size(200, 50)),
                    backgroundColor: MaterialStateProperty.all<Color>(
                        AppColors.kSecondaryColor),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ))),
                child: Text(
                  "Login",
                  style: TextStyle(color: Colors.white),
                )),
          )
        ],
      ),
    );
  }
}
