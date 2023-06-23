import 'package:flutter/material.dart';
import 'package:que_dijo_app/apis/summary_api_service.dart';
import 'package:que_dijo_app/views/edit_summary_view.dart';
import 'package:audioplayers/audioplayers.dart';

class FullSummary extends StatefulWidget {
  const FullSummary(
      {super.key,
      required this.title,
      required this.contenido,
      required this.summaryId,
      this.audioUrl,
      required this.public});

  final String title;
  final String contenido;
  final int summaryId;
  final bool public;
  final String? audioUrl;

  @override
  State<FullSummary> createState() => _FullSummaryState();
}

class _FullSummaryState extends State<FullSummary> {
  final player = AudioPlayer();
  bool isPlaying = false;
  bool publicLocal = false;

  final apiService = SummaryApiService();

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
  void initState() {
    // TODO: implement initState
    super.initState();
    publicLocal = widget.public;
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
          PopupMenuButton(onSelected: (result) async {
            if (result == 0) {
              await Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => EditSummary(
                            title: widget.title,
                            content: widget.contenido,
                            summaryId: widget.summaryId,
                            audioUrl: widget.audioUrl,
                            public: widget.public,
                          )));
            } else if (result == 1) {
              try {
                await apiService.postSummary(
                    summaryId: widget.summaryId, public: !widget.public);
                setState(() {
                  publicLocal = !publicLocal;
                });
                // Optionally, show a success message or perform other actions
              } catch (e) {
                // Handle error, possibly by showing a message to the user
              }
            }
          }, itemBuilder: (context) {
            if (publicLocal) {
              return const [
                PopupMenuItem(
                  value: 0,
                  child: Row(
                    children: [
                      Icon(Icons.edit),
                      SizedBox(width: 8),
                      Text('Editar')
                    ],
                  ),
                ),
                PopupMenuItem(
                  value: 1,
                  child: Row(
                    children: [
                      Icon(Icons.public_off),
                      SizedBox(width: 8),
                      Text('Despublicar')
                    ],
                  ),
                ),
              ];
            } else {
              return const [
                PopupMenuItem(
                  value: 0,
                  child: Row(
                    children: [
                      Icon(Icons.edit),
                      SizedBox(width: 8),
                      Text('Editar')
                    ],
                  ),
                ),
                PopupMenuItem(
                  value: 1,
                  child: Row(
                    children: [
                      Icon(Icons.publish),
                      SizedBox(width: 8),
                      Text('Publicar')
                    ],
                  ),
                ),
              ];
            }
          })
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
