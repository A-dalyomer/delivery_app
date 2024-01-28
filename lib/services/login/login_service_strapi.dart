import 'dart:convert';

import 'package:bloomdeliveyapp/services/service_locator.dart';
import 'package:bloomdeliveyapp/services/storage/local_storage_service.dart';

class LoginServiceStrapi {
  final LocalStorageService _storageService =
      serviceLocator<LocalStorageService>();

  late String _token;

  Future login(String identifier, String password) async {
    var res = {
      "jwt":
          "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MTcsImlhdCI6MTcwNTkzNzQyNywiZXhwIjoxNzA4NTI5NDI3fQ.JYSsjtTzRSHu3W7afFLhE36vrsQwQCGHZyjAy6P_1Nw",
      "user": {
        "id": 17,
        "username": "910627594",
        "email": "ahmadtibin@gmail.com",
        "provider": "local",
        "confirmed": true,
        "blocked": false,
        "createdAt": "2022-06-21T22:43:34.980Z",
        "updatedAt": "2024-01-22T08:42:43.158Z",
        "phone": "910627594",
        "fullname": "Ahmed Ibrahim Tibin",
        "type": "Normal",
        "otp": null,
        "confirmedPhone": true
      }
    };
    var resencoded = jsonEncode(res);
    var parsed = jsonDecode(resencoded);
    _token = parsed['jwt'];
    await _saveToken(_token);
    return parsed;
  }

  _saveToken(String token) async {
    await _storageService.saveToken(token);
  }
}
