import 'package:flutter/material.dart';

class FullSummary extends StatelessWidget {
  const FullSummary({super.key, required this.title, required this.contenido});

  final String title;
  final String contenido;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.edit),
            tooltip: 'Edit Summary',
            onPressed: () {
              //TODO: Hacer una forma de edición.
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
