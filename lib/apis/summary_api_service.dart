import 'package:que_dijo_app/models/summary_get_model.dart';
import 'package:que_dijo_app/services/auth_service.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SummaryApiService {
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
}
