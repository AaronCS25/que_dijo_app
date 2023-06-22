class SummaryMakeRequestModel {
  SummaryMakeRequestModel(
      {required this.pathBucket,
      required this.userId,
      required this.extensionFileName});
  final String pathBucket;
  final String extensionFileName;
  final int userId;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['path_bucket'] = pathBucket;
    data['user_id'] = userId;
    return data;
  }
}

class SummaryMakeResponseModel {
  SummaryMakeResponseModel({required this.statusCode, required this.idText});

  final int statusCode;
  final String idText;

  factory SummaryMakeResponseModel.fromJson(
      int statusCode, Map<String, dynamic> json) {
    return SummaryMakeResponseModel(
        statusCode: statusCode, idText: json['id_text']);
  }
}

class GenerateSummaryRequestModel {
  GenerateSummaryRequestModel(
      {required this.idText, required this.userId, required this.languageCode});

  final String idText;
  final int userId;
  final String languageCode;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id_text'] = idText;
    data['user_id'] = userId;
    data['language_code'] = languageCode;
    return data;
  }
}

class GenerateSummaryResponseModel {
  GenerateSummaryResponseModel(
      {required this.statusCode, required this.idText});

  final int statusCode;
  final String idText;

  factory GenerateSummaryResponseModel.fromJson(
      int statusCode, Map<String, dynamic> json) {
    return GenerateSummaryResponseModel(
        statusCode: statusCode, idText: json['id_text']);
  }
}
