import 'dart:convert';
// import 'package:firebase_core/firebase_core.dart';
import 'package:http/http.dart' as http;
import '../constants/api.dart';

class FirebaseAPIs {
  FirebaseAPIs._();

  static Future<int> sendTokenToServer(String token) async {
    final String userToken = APIs.userToken;
    var url = Uri.parse(
        'https://resourceservermultiproject.azurewebsites.net/api/account/updateFirebaseToken');

    var body = jsonEncode({'firebaseToken': token});

    var response = await http.patch(url,
        headers: {
          "Content-Type": "application/json",
          "Accept-Encoding": "gzip, deflate, br",
          "Connection": "keep-alive",
          "Authorization": userToken
        },
        body: body);

    print(response.statusCode);
    print(response.body);
    return response.statusCode;
  }
}
