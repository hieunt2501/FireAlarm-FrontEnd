import 'package:email_validator/email_validator.dart';
import 'package:firealarm/constants/colors.dart';
import 'package:firealarm/providers/auth_provider.dart';
import 'package:firealarm/utils/routes/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import 'email_input.dart';

class SignupScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SignupScreenState();
}

class SignupScreenState extends State<SignupScreen> {
  String email;
  String password;
  String confirm;
  String address;
  String phone;
  String message;

  @override
  void initState() {
    super.initState();
    email = password = confirm = address = phone = message = "";
  }

  bool isValidInput() {
    if (!EmailValidator.validate(email)) {
      message = "Invalid email";
      return false;
    }
    if (email.isEmpty ||
        password.isEmpty ||
        confirm.isEmpty ||
        address.isEmpty ||
        phone.isEmpty) {
      message = "Please enter full information!";
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
            padding: EdgeInsets.fromLTRB(20, 50, 20, 20),
            decoration: BoxDecoration(border: Border.all(color: Colors.blue)),
            child: Column(
              children: [
                SizedBox(
                  child: MediaQuery.of(context).viewInsets.bottom != 0
                      ? null
                      : Container(
                          alignment: Alignment.centerLeft,
                          padding:
                              EdgeInsets.only(top: 60, bottom: 15, left: 20),
                          child: Text(
                            "Sign up",
                            style:
                                TextStyle(color: AppColors.kText, fontSize: 30),
                          ),
                        ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 20, top: 20),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    message,
                    style: TextStyle(color: Colors.red),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(20, 5, 20, 0),
                  child: EmailInput(
                    onEmailChanged: (value) {
                      email = value;
                    },
                    onPasswordChanged: (value) {
                      password = value;
                    },
                    onConfirmChanged: (value) {
                      confirm = value;
                    },
                    onAddressChanged: (value) {
                      address = value;
                    },
                    onPhoneChanged: (value) {
                      phone = value;
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 15),
                  child: ElevatedButton(
                      onPressed: () async {
                        FocusScope.of(context).unfocus();

                        bool status = await authProvider.signUp(
                            email, password, confirm, phone, address);

                        if (status && isValidInput()) {
                          Navigator.pop(context);
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
                        "Sign up",
                        style: TextStyle(color: Colors.white),
                      )),
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Already have an account?"),
                      MaterialButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          "Sign In",
                          style:
                              TextStyle(color: AppColors.kText, fontSize: 13),
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
