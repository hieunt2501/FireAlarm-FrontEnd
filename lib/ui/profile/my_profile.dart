import 'dart:convert';
import 'dart:io';

import 'package:firealarm/constants/api.dart';
import 'package:firealarm/models/user.dart';
import 'package:firealarm/providers/auth_provider.dart';
import 'package:firealarm/utils/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:firealarm/constants/colors.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';

class MyProfileScreen extends StatefulWidget {
  @override
  _MyProfileScreenState createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {
  File _image;
  User user;
  Future<void> getUser() async {
    final response = await http.get(
        Uri.https(APIs.baseResourceUrl, APIs.instruction),
        headers: {"Authorization": APIs.userToken});
    if (response.statusCode == 200) {
      setState(() {
        user = User.fromJson(json.decode(response.body));
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getUser();
  }

  Future _imgFromCamera() async {
    // File image = await ImagePicker.pickImage(
    //     source: ImageSource.camera, imageQuality: 50);
    PickedFile image = await ImagePicker().getImage(
      source: ImageSource.camera,
    );
    setState(() {
      _image = File(image.path);
    });
  }

  Future _imgFromGallery() async {
    // File image = await ImagePicker.pickImage(
    //     source: ImageSource.gallery, imageQuality: 50);
    PickedFile image = await ImagePicker().getImage(
      source: ImageSource.gallery,
    );
    setState(() {
      _image = File(image.path);
    });
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Library'),
                      onTap: () {
                        _imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      _imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    if (user != null) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 1,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios_new,
              color: Colors.pink,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Container(
          padding: EdgeInsets.only(left: 16, top: 25, right: 16),
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: ListView(
              children: [
                Text(
                  "My Profile",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 15,
                ),
                Center(
                  child: Stack(
                    children: [
                      MaterialButton(
                        onPressed: () {
                          _showPicker(context);
                        },
                        child: Container(
                          width: 140,
                          height: 140,
                          decoration: BoxDecoration(
                            color: _image == null
                                ? AppColors.kPrimaryColor
                                : Colors.white,
                            image: _image == null
                                ? null
                                : DecorationImage(image: FileImage(_image)),
                            border: Border.all(
                                width: 4,
                                color:
                                    Theme.of(context).scaffoldBackgroundColor),
                            boxShadow: [
                              BoxShadow(
                                spreadRadius: 5,
                                blurRadius: 10,
                                color: Colors.black.withOpacity(0.1),
                                offset: Offset(0, 10),
                              ),
                            ],
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                      Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                              color: Colors.pink,
                              shape: BoxShape.circle,
                              border: Border.all(
                                  width: 4,
                                  color: Theme.of(context)
                                      .scaffoldBackgroundColor),
                            ),
                            child: Icon(Icons.camera, color: Colors.white),
                          )),
                      SizedBox(
                        height: 35,
                      )
                    ],
                  ),
                ),
                buildTextField("Email", user.email),
                buildTextField("Phone number", user.phoneNumber),
                buildTextField("Available houses", "2"),
                buildTextField("Available rooms", "5"),
                buildTextField("Available devices", "DHT11"),
                Padding(
                  padding: EdgeInsets.only(top: 15),
                  child: ElevatedButton(
                      onPressed: () async {
                        await authProvider.signOut();
                        Navigator.pushNamed(context, Routes.login);
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
                        "Sign out",
                        style: TextStyle(color: Colors.white),
                      )),
                ),
              ],
            ),
          ),
        ),
      );
    }
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget buildTextField(String labelText, String placeholder) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 25),
      child: TextField(
        decoration: InputDecoration(
            contentPadding: EdgeInsets.only(bottom: 3),
            labelText: labelText,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintText: placeholder,
            hintStyle: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black)),
      ),
    );
  }
}
