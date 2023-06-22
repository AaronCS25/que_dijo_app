import 'dart:convert';

import 'package:que_dijo_app/models/summary_make_model.dart';
import 'package:que_dijo_app/services/auth_service.dart';
import 'package:http/http.dart' as http;

class GenerateSummaryApiService {
  Future<SummaryMakeResponseModel> makeImgSummary(
      SummaryMakeRequestModel summaryMakeRequestModel) async {
    final String token = await Auth.getToken();
    const String url =
        'https://1ssna2zneh.execute-api.us-east-1.amazonaws.com/prod/texto/text';
    final Uri uri = Uri.parse(url);

    final response = await http.post(uri,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'token': token
        },
        body: jsonEncode(summaryMakeRequestModel.toJson()));

    final int statusCode = response.statusCode;

    if (statusCode == 200) {
      return SummaryMakeResponseModel.fromJson(
          statusCode, json.decode(response.body));
    } else {
      throw Exception(
          'Failed to make summary part1 (generate_summary_api_service)');
    }
  }

  Future<SummaryMakeResponseModel> makeVoiceSummary(
      SummaryMakeRequestModel summaryMakeRequestModel) async {
    final String token = await Auth.getToken();
    const String url =
        'https://1ssna2zneh.execute-api.us-east-1.amazonaws.com/prod/texto/voice';
    final Uri uri = Uri.parse(url);

    final response = await http.post(uri,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'token': token
        },
        body: jsonEncode(summaryMakeRequestModel.toJson()));

    final int statusCode = response.statusCode;

    if (statusCode == 200) {
      return SummaryMakeResponseModel.fromJson(
          statusCode, json.decode(response.body));
    } else {
      throw Exception(
          'Failed to make summary part1 (generate_summary_api_service)');
    }
  }

  
}
