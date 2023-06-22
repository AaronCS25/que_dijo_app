import 'dart:convert';

import 'package:que_dijo_app/models/login_model.dart';
import 'package:http/http.dart' as http;

class LoginApiService {
  Future<LoginResponseModel> login(LoginRequestModel loginRequestModel) async {
    const String url =
        'https://1ssna2zneh.execute-api.us-east-1.amazonaws.com/prod/login';
    final Uri uri = Uri.parse(url);
    final response = await http.post(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(loginRequestModel.toJson()),
    );

    if (response.statusCode == 200) {
      return LoginResponseModel.fromJson(
          response.statusCode, json.decode(response.body));
    } else {
      throw Exception('Failed to load data! (login_api_service)');
    }
  }
}
