import 'dart:convert';
import 'package:http/http.dart' as http;

class APIS {
  static final String baseResourceUrl =
      "resourceservermultiproject.azurewebsites.net";

  static final String baseAuthenticationUrl =
      "multiprojectauthenticationserver.azurewebsites.net";

  static final String userToken =
      "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJJZCI6IjIiLCJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9lbWFpbGFkZHJlc3MiOiJuaGFuQGVtYWlsLmNvbSIsImh0dHA6Ly9zY2hlbWFzLnhtbHNvYXAub3JnL3dzLzIwMDUvMDUvaWRlbnRpdHkvY2xhaW1zL21vYmlsZXBob25lIjoiMDEyMyIsIm5iZiI6MTYyMTU2NjM5OCwiZXhwIjoxNjIyMDg0Nzk4LCJpc3MiOiJodHRwczovL2xvY2FsaG9zdDo1MDAxIiwiYXVkIjoiaHR0cHM6Ly9sb2NhbGhvc3Q6NTAwMSJ9.42CcwqL2i01K0rEJnugxk_hwXbJM-trl975EJwo3N0g";

  static var deviceLogs = "/api/monitor/deviceLogs";
  static var myDevices = "/api/account/myDevices";
  static var turnOnDeviceRoute = "/api/device/turnOnDevice";
  static var turnOffDeviceRoute = "/api/device/turnOffDevice";

  Future<void> turnOnDevice(String deviceID) async {
    var response = await http.post(
        Uri.https(APIS.baseResourceUrl, APIS.turnOnDeviceRoute, {"roomDeviceId" : deviceID}),
        headers: {"Authorization": APIS.userToken});
    print(response.statusCode);
    if (response.statusCode == 200) {
      print('Succeed!');
    } else {
      throw Exception('Failed to turn on device!');
    }
  }

  Future<void> turnOffDevice(String deviceID) async {
    var response = await http.post(
        Uri.https(APIS.baseResourceUrl, APIS.turnOffDeviceRoute, {"roomDeviceId": deviceID}),
        headers: {"Authorization": APIS.userToken});
    print(response.statusCode);
    // print(response.body['message']);
    if (response.statusCode == 200) {
      print('Succeed!');
    } else {
      throw Exception('Failed to turn off device!');
    }
  }

  Future<void> sendTokenToServer(String token) async {
    final String userToken = "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJJZCI6IjIiLCJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9lbWFpbGFkZHJlc3MiOiJuaGFuQGVtYWlsLmNvbSIsImh0dHA6Ly9zY2hlbWFzLnhtbHNvYXAub3JnL3dzLzIwMDUvMDUvaWRlbnRpdHkvY2xhaW1zL21vYmlsZXBob25lIjoiMDEyMyIsIm5iZiI6MTYyMTUyMDIwNiwiZXhwIjoxNjIyMDM4NjA2LCJpc3MiOiJodHRwczovL2xvY2FsaG9zdDo1MDAxIiwiYXVkIjoiaHR0cHM6Ly9sb2NhbGhvc3Q6NTAwMSJ9.UsfW5NTXc1dwhOJgqHRG7F3NzaCWyaM1iXRhes4vdfY";
    var url = Uri.parse('https://resourceservermultiproject.azurewebsites.net/api/account/updateFirebaseToken');
    
    var body = jsonEncode({
      'firebaseToken': token
    });

    var response = await http.patch(
        url, 
        headers: {
          "Content-Type"  : "application/json",
          "Accept-Encoding" : "gzip, deflate, br",
          "Connection" : "keep-alive",
          "Authorization" : userToken
        },
        body: body);

    print(response.statusCode);
    print(response.body);
  }

}

