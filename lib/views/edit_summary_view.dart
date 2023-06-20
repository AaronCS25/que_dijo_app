import 'package:flutter/material.dart';

class EditSummary extends StatefulWidget {
  const EditSummary({super.key, required this.title, required this.content});
  final String title;
  final String content;

  @override
  State<EditSummary> createState() => _EditSummaryState();
}

class _EditSummaryState extends State<EditSummary> {
  late TextEditingController titleController;
  late TextEditingController contentController;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.title);
    contentController = TextEditingController(text: widget.content);
  }

  @override
  void dispose() {
    titleController.dispose();
    contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: titleController,
          decoration: const InputDecoration(
              hintText: 'Enter title', border: InputBorder.none),
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.save),
            tooltip: 'Save Changes',
            onPressed: () async {
              // TODO: PUT REQUEST
            },
          )
        ],
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
                  TextField(
                    controller: contentController,
                    maxLines: null,
                    decoration: const InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.all(8.0)),
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
