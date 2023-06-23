import 'dart:convert';

import 'package:que_dijo_app/models/signup_model.dart';

import 'package:http/http.dart' as http;

class SignUpApiService {
  Future<SignUpResponseModel> signup(
      SignUpRequestModel signUpRequestModel) async {
    const String url =
        'https://1ssna2zneh.execute-api.us-east-1.amazonaws.com/prod/register';
    final Uri uri = Uri.parse(url);
    final response = await http.post(uri,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(signUpRequestModel.toJson()));
    print('status code_: ${response.statusCode}');
    print(jsonEncode(signUpRequestModel.toJson()));
    if (response.statusCode == 200) {
      return SignUpResponseModel.fromJson(
          response.statusCode, json.decode(response.body));
    } else {
      throw Exception('Failed to load data! (signup_api_service)');
    }
  }
}
