import 'package:firealarm/constants/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'email_input.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: GestureDetector(
          onTap: () {
            FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
          },
          child: Container(
            padding: EdgeInsets.fromLTRB(20, 80, 20, 20),
            decoration: BoxDecoration(border: Border.all(color: Colors.blue)),
            child: Column(
              children: [
                Container(
                  child: MediaQuery.of(context).viewInsets.bottom != 0
                      ? null
                      : Container(
                          padding: EdgeInsets.only(top: 60, bottom: 45),
                          child: Text(
                            "FireAlarm",
                            style: TextStyle(color: kText, fontSize: 50),
                          ),
                        ),
                ),
                Container(
                  padding: EdgeInsets.only(bottom: 45),
                  child: Image.asset(
                    "lib/icon/alarm-icon.png",
                  ),
                ),
                Container(
                    padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                    child: EmailInput()),
                MaterialButton(
                  onPressed: () {},
                  child: Text(
                    "Forgot Password?",
                    style: TextStyle(color: kText),
                  ),
                ),
                Container(
                  child: MediaQuery.of(context).viewInsets.bottom != 0
                      ? null
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Don't have an account?"),
                            MaterialButton(
                              onPressed: () {},
                              child: Text(
                                "Sign Up",
                                style: TextStyle(color: kText, fontSize: 13),
                              ),
                            )
                          ],
                        ),
                )
              ],
            ),
          ),
        ));
  }
}
