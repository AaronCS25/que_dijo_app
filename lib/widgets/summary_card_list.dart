import 'package:flutter/material.dart';
import 'package:que_dijo_app/apis/summary_api_service.dart';
import 'package:que_dijo_app/models/summary_get_model.dart';
import 'package:que_dijo_app/views/full_summary_view.dart';
import 'package:que_dijo_app/widgets/summary_card.dart';

class PerSummary extends StatelessWidget {
  PerSummary(
      {super.key,
      required this.title,
      required this.contenido,
      required this.summaryId});

  final String title;
  final String contenido;
  final int summaryId;

  final SummaryApiService summaryApiService = SummaryApiService();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () async {
          SummaryGetResponseModel summaryGetResponseModel =
              await summaryApiService.getSummary(summaryId: summaryId);
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => FullSummary(
                      title: summaryGetResponseModel.titulo,
                      contenido: summaryGetResponseModel.resumen)));
        },
        child: SummaryCard(title: title, contenido: contenido));
  }
}
