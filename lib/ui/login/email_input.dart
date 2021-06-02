import 'dart:convert';
import 'package:firealarm/constants/colors.dart';
import 'package:firealarm/utils/routes/routes.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:http/http.dart' as http;
import '../../constants/api.dart';

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
  SharedPreferences localStorage;

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

  Future<bool> authenticateUser(String email, String password) async {
    var payload = {"email": email, "password": password};
    var url =
        Uri.https(APIs.baseAuthenticationUrl, "/api/authentication/login");
    var headers = {
      'Content-Type': 'application/json; charset=UTF-8',
    };
    final response =
        await http.post(url, headers: headers, body: jsonEncode(payload));
    print('____________________________________');
    Map<String, dynamic> data = jsonDecode(response.body);
    if (data != null && data['data'] != null) {
      print(data['data']);
      var token = data['data']['accessToken'];
      print(token);
      this.localStorage = await SharedPreferences.getInstance();
      this.localStorage.setString('token', token);
      print('____________________________________');
      return (token != null);
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
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
                color: kPrimaryColor, borderRadius: BorderRadius.circular(8)),
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
                color: kPrimaryColor, borderRadius: BorderRadius.circular(8)),
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
                  await authenticateUser(this.email, this.password);
                  if (okToLogin()) {
                    setState(() {});
                    authenticateUser(email, password).then((value) {
                      if (value) Navigator.pushNamed(context, Routes.home);
                    });
                  }
                  setState(() {});
                },
                style: ButtonStyle(
                    minimumSize: MaterialStateProperty.all<Size>(Size(200, 50)),
                    backgroundColor:
                        MaterialStateProperty.all<Color>(kSecondaryColor),
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
