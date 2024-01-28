import 'dart:convert';
import 'package:http/http.dart' show post, Response;

class StrapiLocalApi {
  // url
  //final _host = 'http://3.145.118.79:1337';
  final _host = 'http://192.168.0.34:1337';
  String _path = '';

  final Map<String, String> _headers = {
    'Content-Type': 'application/json; charset=utf-8'
  };

  Future<Response> login(identifier, password) async {
    _path = 'api/auth/local';
    final loginUrl = _host + "/" + _path;
    dynamic bodyToSend = {
      'identifier': identifier,
      'password': password,
    };
    var body = json.encode(bodyToSend);
    return await post(Uri.parse(loginUrl), body: body, headers: _headers);
  }

  Future<Response> register(String fullname, String username, String email,
      String phonenumber, String password, String code) async {
    _path = 'api/auth/local/register';
    final loginUrl = _host + "/" + _path;
    username = phonenumber;
    dynamic bodyToSend = {
      'fullname': fullname,
      'username': username,
      'email': email,
      'phone': phonenumber,
      'password': password,
      'confirmedPhone': false,
      'otp': code,
    };
    var body = json.encode(bodyToSend);
    return await post(Uri.parse(loginUrl), body: body, headers: _headers);
  }
}
