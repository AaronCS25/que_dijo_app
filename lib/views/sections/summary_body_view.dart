import 'package:flutter/material.dart';
import 'package:que_dijo_app/apis/summary_api_service.dart';
import 'package:que_dijo_app/models/summary_get_model.dart';
import 'package:que_dijo_app/widgets/summary_card_list.dart';

class BuildSummaryView extends StatefulWidget {
  const BuildSummaryView({super.key});

  @override
  State<BuildSummaryView> createState() => _BuildSummaryViewState();
}

class _BuildSummaryViewState extends State<BuildSummaryView> {
  late Future<ListSummariesGetResponseModel> futureData;
  final SummaryApiService summaryApiService = SummaryApiService();

  @override
  void initState() {
    super.initState();
    futureData = summaryApiService.getSummaries();
  }

  Future<void> reloadData() async {
    setState(() {
      futureData = summaryApiService.getSummaries();
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
                return PerSummary(
                  title: titulo,
                  contenido: contenido,
                  summaryId: summaryId,
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
