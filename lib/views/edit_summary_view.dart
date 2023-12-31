import 'package:flutter/material.dart';
import 'package:que_dijo_app/apis/summary_api_service.dart';
import 'package:que_dijo_app/views/full_summary_view.dart';

class EditSummary extends StatefulWidget {
  const EditSummary(
      {super.key,
      required this.title,
      required this.content,
      required this.summaryId,
      this.audioUrl,
      required this.public});
  final String title;
  final String content;
  final int summaryId;
  final String? audioUrl;
  final bool public;

  @override
  State<EditSummary> createState() => _EditSummaryState();
}

class _EditSummaryState extends State<EditSummary> {
  late TextEditingController titleController;
  late TextEditingController contentController;
  late int summaryId;
  late String? audioUrl;

  final SummaryApiService summaryApiService = SummaryApiService();
  bool _isUpdating = false;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.title);
    contentController = TextEditingController(text: widget.content);
    summaryId = widget.summaryId;
    audioUrl = widget.audioUrl;
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
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          iconSize: 30,
          onPressed: () {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => FullSummary(
                          title: titleController.text,
                          contenido: contentController.text,
                          summaryId: summaryId,
                          audioUrl: audioUrl,
                          public: widget.public,
                        )));
          },
        ),
        title: TextField(
          controller: titleController,
          decoration: const InputDecoration(
              hintText: 'Enter title', border: InputBorder.none),
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.save),
            tooltip: 'Save Changes',
            onPressed: _isUpdating
                ? null
                : () async {
                    setState(() {
                      _isUpdating = true;
                    });

                    try {
                      await summaryApiService.updateSummary(
                          summaryId: summaryId,
                          title: titleController.text,
                          content: contentController.text);
                    } catch (error) {
                      // TODO: NOTIFICAR FALLO ACTUALIZACIÓN
                      print(
                          'No se pudo actualizar (edit_summary_view): $error');
                    } finally {
                      setState(() {
                        _isUpdating = false;
                      });
                    }
                  },
          )
        ],
      ),
      body: _isUpdating
          ? const Center(child: CircularProgressIndicator())
          : Padding(
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
