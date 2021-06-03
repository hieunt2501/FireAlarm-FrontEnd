import 'dart:convert';
// import 'package:firebase_core/firebase_core.dart';
import 'package:http/http.dart' as http;
// import '../constants/api.dart';

class FirebaseAPIs {
  FirebaseAPIs._();

  static Future<void> sendTokenToServer(String token) async {
    final String userToken =
        "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJJZCI6IjIiLCJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9lbWFpbGFkZHJlc3MiOiJuaGFuQGVtYWlsLmNvbSIsImh0dHA6Ly9zY2hlbWFzLnhtbHNvYXAub3JnL3dzLzIwMDUvMDUvaWRlbnRpdHkvY2xhaW1zL21vYmlsZXBob25lIjoiMDEyMyIsIm5iZiI6MTYyMTUyMDIwNiwiZXhwIjoxNjIyMDM4NjA2LCJpc3MiOiJodHRwczovL2xvY2FsaG9zdDo1MDAxIiwiYXVkIjoiaHR0cHM6Ly9sb2NhbGhvc3Q6NTAwMSJ9.UsfW5NTXc1dwhOJgqHRG7F3NzaCWyaM1iXRhes4vdfY";
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
  }
}
