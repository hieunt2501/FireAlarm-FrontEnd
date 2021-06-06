import 'package:email_validator/email_validator.dart';
import 'package:firealarm/constants/colors.dart';
import 'package:firealarm/providers/auth_provider.dart';
import 'package:firealarm/utils/routes/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'email_input.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  String email;
  String password;
  String message;

  @override
  void initState() {
    super.initState();
    email = password = message = "";
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
    final authProvider = Provider.of<AuthProvider>(context);
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
                            style:
                                TextStyle(color: AppColors.kText, fontSize: 50),
                          ),
                        ),
                ),
                Container(
                  padding: EdgeInsets.only(bottom: 45),
                  child: Image.asset(
                    "lib/icon/alarm-icon.png",
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    message,
                    style: TextStyle(color: Colors.red),
                  ),
                ),
                Container(
                    padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                    child: EmailInput(
                      onEmailChanged: (value) {
                        email = value;
                      },
                      onPasswordChanged: (value) {
                        password = value;
                      },
                    )),
                Padding(
                  padding: EdgeInsets.only(top: 15),
                  child: ElevatedButton(
                      onPressed: () async {
                        FocusScope.of(context).unfocus();

                        bool status = await authProvider.signIn(
                            this.email, this.password);

                        if (status && okToLogin()) {
                          Navigator.pushNamed(context, Routes.home);
                        } else
                          print("Error?");
                      },
                      style: ButtonStyle(
                          minimumSize:
                              MaterialStateProperty.all<Size>(Size(200, 50)),
                          backgroundColor: MaterialStateProperty.all<Color>(
                              AppColors.kSecondaryColor),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ))),
                      child: Text(
                        "Login",
                        style: TextStyle(color: Colors.white),
                      )),
                ),
                MaterialButton(
                  onPressed: () {},
                  child: Text(
                    "Forgot Password?",
                    style: TextStyle(color: AppColors.kText),
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
                              onPressed: () {
                                Navigator.pushNamed(context, Routes.signup);
                              },
                              child: Text(
                                "Sign Up",
                                style: TextStyle(
                                    color: AppColors.kText, fontSize: 13),
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
