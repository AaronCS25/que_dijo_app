import 'package:flutter/material.dart';
import 'package:que_dijo_app/apis/summary_api_service.dart';
import 'package:que_dijo_app/models/summary_get_model.dart';
import 'package:que_dijo_app/views/full_public_summary_view.dart';
import 'package:que_dijo_app/widgets/summary_card_public.dart';

class PublicPerSummary extends StatelessWidget {
  PublicPerSummary(
      {super.key,
      required this.title,
      required this.contenido,
      required this.summaryId,
      required this.likes});

  final String title;
  final String contenido;
  final int summaryId;
  final int likes;

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
                  builder: (context) => FullPublicSummary(
                        title: summaryGetResponseModel.titulo,
                        contenido: summaryGetResponseModel.resumen,
                        summaryId: summaryId,
                      )));
        },
        child: PublicSummaryCard(
            title: title, contenido: contenido, likes: likes));
  }
}
