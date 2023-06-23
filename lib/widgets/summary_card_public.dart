import 'package:flutter/material.dart';

class PublicSummaryCard extends StatelessWidget {
  const PublicSummaryCard(
      {super.key,
      required this.title,
      required this.contenido,
      required this.likes});

  final String title;
  final String contenido;
  final int likes;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 2,
        child: Container(
          width: double.infinity,
          height: 220,
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                    fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
              const Divider(
                  color: Colors.grey,
                  height: 20,
                  thickness: 1,
                  indent: 20,
                  endIndent: 20),
              Expanded(
                child: Text(
                  contenido,
                  style: const TextStyle(fontSize: 14.0),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 5,
                ),
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  /* Row(
                    children: [
                      const Icon(Icons.favorite, color: Colors.red),
                      const SizedBox(width: 8),
                      Text('$likes')
                    ],
                  ), */
                  /* IconButton(
                    onPressed: () {
                      // TODO: agregar funcionalidad para dar likes.
                    },
                    icon: const Icon(Icons.favorite_border),
                  ) */
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
