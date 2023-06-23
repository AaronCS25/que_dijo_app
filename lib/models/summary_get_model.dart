class SummaryGetResponseModel {
  final int idResumen;
  //final String idTexto;
  final String titulo;
  final String resumen;

  SummaryGetResponseModel(
      {required this.idResumen,
      //required this.idTexto,
      required this.titulo,
      required this.resumen});

  factory SummaryGetResponseModel.fromJson(Map<String, dynamic> json) {
    return SummaryGetResponseModel(
        idResumen: json['id_resumen'],
        //idTexto: json['idTexto'],
        titulo: json['titulo'],
        resumen: json['resumen']);
  }
}

class SummariesGetResponseModel {
  SummariesGetResponseModel({
    required this.idResumen,
    required this.idUsuario,
    required this.idTexto,
    required this.likes,
    required this.idioma,
    required this.limiteResumen,
    this.keyAudio,
    required this.publico,
  });

  final int idResumen;
  final int idUsuario;
  final String idTexto;
  final int likes;
  final String idioma;
  final String limiteResumen;
  String? keyAudio;
  final bool publico;

  factory SummariesGetResponseModel.fromJson(Map<String, dynamic> json) {
    return SummariesGetResponseModel(
      idResumen: json['id_resumen'],
      idUsuario: json['id_usuario'],
      idTexto: json['id_texto'],
      likes: json['likes'],
      idioma: json['idioma'],
      limiteResumen: json['limite_resumen'],
      keyAudio: json['key_audio'],
      publico: json['publico'],
    );
  }
}

class ListSummariesGetResponseModel {
  ListSummariesGetResponseModel({required this.resumenes});

  List<SummariesGetResponseModel> resumenes;

  factory ListSummariesGetResponseModel.fromJson(Map<String, dynamic> json) {
    List<dynamic> dataList = json['data'];
    List<SummariesGetResponseModel> summaries = dataList
        .map((resumenJson) => SummariesGetResponseModel.fromJson(resumenJson))
        .toList();

    return ListSummariesGetResponseModel(resumenes: summaries);
  }
}
