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
      ),
      body: Padding(
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
    );
  }
}
