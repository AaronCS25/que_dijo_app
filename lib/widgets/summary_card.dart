import 'package:flutter/material.dart';
import 'package:que_dijo_app/apis/summary_api_service.dart';
//import 'package:que_dijo_app/models/summary_get_model.dart';

class PerSummary extends StatelessWidget {
  PerSummary(
      {super.key,
      required this.titulo,
      required this.contenido,
      required this.summaryId});

  final String titulo;
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
      child: Card(
        child: SizedBox(
          width: 300,
          height: 200,
          child: Column(
            children: [
              Text(titulo),
              const Divider(),
              Expanded(
                child: Text(
                  contenido,
                  overflow: TextOverflow.clip,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
