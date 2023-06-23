import 'package:que_dijo_app/models/summary_get_model.dart';
import 'package:que_dijo_app/models/summary_put_model.dart';
import 'package:que_dijo_app/services/auth_service.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SummaryApiService {
  //*GET - {Id}
  Future<SummaryGetResponseModel> getSummary({required int summaryId}) async {
    final String token = await Auth.getToken();

    final String url =
        'https://1ssna2zneh.execute-api.us-east-1.amazonaws.com/prod/resumen/$summaryId';
    final Uri uri = Uri.parse(url);

    final response = await http.get(uri, headers: {'token': token});

    if (response.statusCode == 200) {
      return SummaryGetResponseModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Error al cargar los datos del resumen');
    }
  }

  //* GET - List Of Summaries
  Future<ListSummariesGetResponseModel> getSummaries() async {
    final String token = await Auth.getToken();
    final String userId = await Auth.getUserId();

    final String url =
        'https://1ssna2zneh.execute-api.us-east-1.amazonaws.com/prod/resumen?user_id=$userId&complete=true';
    final Uri uri = Uri.parse(url);

    final response = await http.get(uri, headers: {'token': token});

    if (response.statusCode == 200) {
      return ListSummariesGetResponseModel.fromJson(json.decode(response.body));
    } else {
      throw Exception(
          'Error al cargar los datos del resumen (summary_api_service)');
    }
  }

  //* PUT - {Id}
  Future<SummaryPutResponseModel> updateSummary(
      {required int summaryId,
      required String title,
      required String content}) async {
    final String token = await Auth.getToken();

    final String url =
        'https://1ssna2zneh.execute-api.us-east-1.amazonaws.com/prod/resumen/$summaryId';
    final Uri uri = Uri.parse(url);

    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'token': token,
    };

    final Map<String, String> body = {
      'titulo': title,
      'resumen': content,
    };

    final response =
        await http.put(uri, headers: headers, body: json.encode(body));

    if (response.statusCode == 200) {
      return SummaryPutResponseModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Error al actualizar el resumen (summary_api_service)');
    }
  }

  //* GET - List Of Summaries
  Future<ListSummariesGetResponseModel> getPublicSummaries() async {
    final String token = await Auth.getToken();

    const String url =
        'https://1ssna2zneh.execute-api.us-east-1.amazonaws.com/prod/resumen?complete=true&public=true';
    final Uri uri = Uri.parse(url);

    final response = await http.get(uri, headers: {'token': token});

    if (response.statusCode == 200) {
      return ListSummariesGetResponseModel.fromJson(json.decode(response.body));
    } else {
      throw Exception(
          'Error al cargar los datos de public resumen (summary_api_service)');
    }
  }

  Future<SummaryPutResponseModel> postSummary(
      {required int summaryId, required bool public}) async {
    final String token = await Auth.getToken();

    final String url =
        'https://1ssna2zneh.execute-api.us-east-1.amazonaws.com/prod/resumen/$summaryId';
    final Uri uri = Uri.parse(url);

    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'token': token,
    };

    final Map<String, dynamic> body = {
      'publico': public,
    };

    final response =
        await http.put(uri, headers: headers, body: json.encode(body));

    if (response.statusCode == 200) {
      return SummaryPutResponseModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Error al publicar resumen (summary_api_service)');
    }
  }
}
