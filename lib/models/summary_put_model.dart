class SummaryPutRequestModel {
  SummaryPutRequestModel({required this.title, required this.resumen});

  final int title;
  final String resumen;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['resumen'] = resumen;
    return data;
  }
}

class SummaryPutPublicRequestModel {
  SummaryPutPublicRequestModel({required this.public});

  final bool public;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['public'] = public;
    return data;
  }
}

class SummaryPutResponseModel {
  SummaryPutResponseModel({required this.summaryId, required this.updatedData});

  final String summaryId;
  final Map<String, dynamic> updatedData;

  factory SummaryPutResponseModel.fromJson(Map<String, dynamic> json) {
    return SummaryPutResponseModel(
        summaryId: json['id_resumen'], updatedData: json['updated_data']);
  }
}
