import 'package:flutter/material.dart';
import 'package:que_dijo_app/views/edit_summary_view.dart';

class FullSummary extends StatelessWidget {
  const FullSummary(
      {super.key,
      required this.title,
      required this.contenido,
      required this.summaryId});

  final String title;
  final String contenido;
  final int summaryId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          iconSize: 30,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(title),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.edit),
            tooltip: 'Edit Summary',
            onPressed: () async {
              await Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => EditSummary(
                            title: title,
                            content: contenido,
                            summaryId: summaryId,
                          )));
            },
          )
        ],
      ),
      body: Column(children: [
        const Divider(
          color: Colors.grey,
          thickness: 1,
          //height: 1,
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Scrollbar(
              child: ListView(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      SelectableText(
                        contenido,
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ]),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //TODO: Hacer un reproductor.
        },
        shape: const CircleBorder(),
        child: const Icon(Icons.play_lesson),
      ),
    );
  }
}
