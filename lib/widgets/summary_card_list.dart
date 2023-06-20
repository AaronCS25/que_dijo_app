import 'package:flutter/material.dart';
import 'package:que_dijo_app/apis/summary_api_service.dart';
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
          //SummaryGetResponseModel summaryGetResponseModel = await summaryApiService.getSummary(summaryId: summaryId);
          //TODO: navigate to full summary.
        },
        child: SummaryCard(title: title, contenido: contenido));
  }
}
