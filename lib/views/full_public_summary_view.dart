import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class FullPublicSummary extends StatefulWidget {
  const FullPublicSummary(
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
  State<FullPublicSummary> createState() => _FullPublicSummaryState();
}

class _FullPublicSummaryState extends State<FullPublicSummary> {
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
