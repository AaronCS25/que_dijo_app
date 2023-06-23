import 'package:flutter/material.dart';
import 'package:que_dijo_app/views/edit_summary_view.dart';
import 'package:audioplayers/audioplayers.dart';

class FullSummary extends StatefulWidget {
  const FullSummary(
      {super.key,
      required this.title,
      required this.contenido,
      required this.summaryId,
      this.audioUrl});

  final String title;
  final String contenido;
  final int summaryId;
  final String? audioUrl;

  @override
  State<FullSummary> createState() => _FullSummaryState();
}

class _FullSummaryState extends State<FullSummary> {
  final player = AudioPlayer();
  bool isPlaying = false;

  Future<void> playAudioFromUrl() async {
    if (isPlaying) {
      print('Pause');
      player.pause();
    } else {
      print('Play: ${widget.audioUrl}');
      if (widget.audioUrl != null) {
        await player.play(UrlSource(widget.audioUrl!));
      } else {
        print('No hay link');
      }
    }
    setState(() {
      isPlaying = !isPlaying;
    });
  }

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
        title: Text(widget.title),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.edit),
            tooltip: 'Edit Summary',
            onPressed: () async {
              await Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => EditSummary(
                            title: widget.title,
                            content: widget.contenido,
                            summaryId: widget.summaryId,
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
                        widget.contenido,
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
        onPressed: () async {
          print('Reproducir');
          await playAudioFromUrl();
        },
        shape: const CircleBorder(),
        child: const Icon(Icons.play_lesson),
      ),
    );
  }
}
