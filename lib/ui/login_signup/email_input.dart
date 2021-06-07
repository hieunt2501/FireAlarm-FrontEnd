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
  final ValueChanged<String> onEmailChanged;
  final ValueChanged<String> onPasswordChanged;
  final ValueChanged<String> onConfirmChanged;
  final ValueChanged<String> onAddressChanged;
  final ValueChanged<String> onPhoneChanged;
  EmailInput(
      {@required this.onEmailChanged,
      @required this.onPasswordChanged,
      this.onAddressChanged,
      this.onConfirmChanged,
      this.onPhoneChanged});
  @override
  State<StatefulWidget> createState() => EmailInputState();
}

class EmailInputState extends State<EmailInput> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(10),
          height: height / 15,
          decoration: BoxDecoration(
              color: AppColors.kPrimaryColor,
              borderRadius: BorderRadius.circular(8)),
          child: TextFormField(
            onChanged: (value) {
              widget.onEmailChanged(value);
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
            onChanged: (value) {
              widget.onPasswordChanged(value);
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
        SizedBox(
          child: widget.onConfirmChanged == null
              ? null
              : Column(
                  children: [
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
                        onChanged: (value) {
                          widget.onConfirmChanged(value);
                        },
                        obscureText: true,
                        cursorColor: Colors.black,
                        decoration: new InputDecoration(
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            contentPadding: EdgeInsets.only(
                                left: 15, bottom: 11, top: 11, right: 15),
                            hintText: "Confirm Password"),
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
                        onChanged: (value) {
                          widget.onPhoneChanged(value);
                        },
                        keyboardType: TextInputType.number,
                        cursorColor: Colors.black,
                        decoration: new InputDecoration(
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            contentPadding: EdgeInsets.only(
                                left: 15, bottom: 11, top: 11, right: 15),
                            hintText: "Phone Number"),
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
                        onChanged: (value) {
                          widget.onAddressChanged(value);
                        },
                        cursorColor: Colors.black,
                        decoration: new InputDecoration(
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            contentPadding: EdgeInsets.only(
                                left: 15, bottom: 11, top: 11, right: 15),
                            hintText: "Address"),
                      ),
                    ),
                  ],
                ),
        )
      ],
    );
  }
}
