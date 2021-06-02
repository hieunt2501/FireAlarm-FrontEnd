import 'dart:convert';
import 'package:http/http.dart' as http;

class APIs {
  static final String baseResourceUrl =
      "resourceservermultiproject.azurewebsites.net";

  static final String baseAuthenticationUrl =
      "multiprojectauthenticationserver.azurewebsites.net";

  static final String userToken =
      "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJJZCI6IjIiLCJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9lbWFpbGFkZHJlc3MiOiJuaGFuQGVtYWlsLmNvbSIsImh0dHA6Ly9zY2hlbWFzLnhtbHNvYXAub3JnL3dzLzIwMDUvMDUvaWRlbnRpdHkvY2xhaW1zL21vYmlsZXBob25lIjoiMDEyMyIsIm5iZiI6MTYyMjUzMzM3MCwiZXhwIjoxNjc0MzczMzcwLCJpc3MiOiJodHRwczovL2xvY2FsaG9zdDo1MDAxIiwiYXVkIjoiaHR0cHM6Ly9sb2NhbGhvc3Q6NTAwMSJ9.9K39WGJMfGdJGfuYazNxZiH1vL_tpbcstkQE07nmR9o";

  static var deviceLogs = "/api/monitor/deviceLogs";
  static var myDevices = "/api/account/myDevices";
  static var turnOnDeviceRoute = "/api/device/turnOnDevice";
  static var turnOffDeviceRoute = "/api/device/turnOffDevice";
}
