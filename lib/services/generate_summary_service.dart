import 'package:que_dijo_app/apis/generate_summary_api_service.dart';
import 'package:que_dijo_app/models/summary_make_model.dart';
import 'package:que_dijo_app/services/auth_service.dart';

class GenerateSummary {
  final GenerateSummaryApiService generateSummaryApiService =
      GenerateSummaryApiService();

  final List<String> extensionImgAvailable = [
    '.jpg',
    '.jpeg',
    '.png',
    '.bmp',
    '.pdf'
  ];
  final List<String> extensionVoiceAvailable = [
    '.wav',
    '.mp3',
    '.flac',
    '.m4a',
    '.aac'
  ];

  // Primer paso: manda a extraer el contenido
  Future<void> generateFullSummary(
      String pathBucket, String extensionFileName) async {
    int userId = int.parse(await Auth.getUserId());
    SummaryMakeRequestModel summaryMakeRequestModel = SummaryMakeRequestModel(
        pathBucket: pathBucket,
        userId: userId,
        extensionFileName: extensionFileName);

    // Realizamos la extracción.
    final SummaryMakeResponseModel summaryMakeResponseModel;
    if (extensionImgAvailable
        .contains(summaryMakeRequestModel.extensionFileName)) {
      summaryMakeResponseModel = await generateSummaryApiService
          .makeImgSummary(summaryMakeRequestModel);
    } else if (extensionVoiceAvailable
        .contains(summaryMakeRequestModel.extensionFileName)) {
      summaryMakeResponseModel = await generateSummaryApiService
          .makeVoiceSummary(summaryMakeRequestModel);
    } else {
      throw Exception('File extension not supported');
    }

    GenerateSummaryRequestModel generateSummaryRequestModel =
        GenerateSummaryRequestModel(
            idText: summaryMakeResponseModel.idText,
            userId: userId,
            languageCode: 'es-MX');

    GenerateSummaryResponseModel generateSummaryResponseModel =
        await generateSummaryApiService
            .generateSummary(generateSummaryRequestModel);

    int statusCode = generateSummaryResponseModel.statusCode;

    if (statusCode == 200) {
    } else {
      throw Exception('No se pudo hacer el resumen');
    }
  }
}
