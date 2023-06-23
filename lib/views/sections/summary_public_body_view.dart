import 'package:flutter/material.dart';
import 'package:que_dijo_app/apis/summary_api_service.dart';
import 'package:que_dijo_app/models/summary_get_model.dart';
import 'package:que_dijo_app/widgets/summary_card_public_list.dart';

class BuildPublicSummaryView extends StatefulWidget {
  const BuildPublicSummaryView({super.key});

  @override
  State<BuildPublicSummaryView> createState() => _BuildPublicSummaryViewState();
}

class _BuildPublicSummaryViewState extends State<BuildPublicSummaryView> {
  late Future<ListSummariesGetResponseModel> futureData;
  final SummaryApiService summaryApiService = SummaryApiService();

  @override
  void initState() {
    super.initState();
    futureData = summaryApiService.getPublicSummaries();
  }

  Future<void> reloadData() async {
    setState(() {
      futureData = summaryApiService.getPublicSummaries();
    });
    await futureData;
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: reloadData,
      child: FutureBuilder<ListSummariesGetResponseModel>(
        future: futureData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final dataList = snapshot.data!.resumenes;

            return ListView(
              children: dataList.map((item) {
                final titulo = 'Resumen #${item.idResumen}';
                final contenido = item.limiteResumen;
                final summaryId = item.idResumen;
                final likes = item.likes;
                return PublicPerSummary(
                  title: titulo,
                  contenido: contenido,
                  summaryId: summaryId,
                  likes: likes,
                );
              }).toList(),
            );
          } else if (snapshot.hasError) {
            return Text(
                'Error al obtener los datos: ${snapshot.error} (summary_body_view)');
          }
          return const CircularProgressIndicator();
        },
      ),
    );
  }
}
