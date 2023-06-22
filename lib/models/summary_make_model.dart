class SummaryMakeRequestModel {
  SummaryMakeRequestModel({required this.pathBucket, required this.userId});
  final String pathBucket;
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
