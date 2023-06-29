import 'package:flutter/material.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';

class FullPublicSummary extends StatefulWidget {
  const FullPublicSummary(
      {super.key,
      required this.title,
      required this.contenido,
      required this.summaryId,
      this.audioUrl,
      this.filePath});

  final String title;
  final String contenido;
  final int summaryId;
  final String? audioUrl;
  final String? filePath;
  @override
  State<FullPublicSummary> createState() => _FullPublicSummaryState();
}

class _FullPublicSummaryState extends State<FullPublicSummary> {
  final player = AudioPlayer();
  bool isPlaying = false;

  Future<void> downloadToLocalFile() async {
    final test = widget.audioUrl;
    print('Widget url: $test');
    // key = "audios/152/8e75c14a-4276-4d12-83fc-23bcc12fc3c1.mp3";

    if (isPlaying) {
      print('Pause');
      player.pause();
    } else {
      final documentsDir = await getApplicationDocumentsDirectory();
      final filepath = documentsDir.path + 'temp.mp3';
      if (widget.audioUrl != null) {
        try {
          final result = await Amplify.Storage.downloadFile(
            key: widget.audioUrl!,
            localFile: AWSFile.fromPath(filepath),
            onProgress: (progress) {
              safePrint('Fraction completed: ${progress.fractionCompleted}');
            },
          ).result;

          safePrint('Downloaded file is located at: ${result.localFile.path}');
        } on StorageException catch (e) {
          safePrint(e.message);
        } finally {
          var urlSource = DeviceFileSource(filepath);
          player.play(urlSource);
        }
      } else {
        print('No hay path');
      }
    }
    setState(() {
      isPlaying = !isPlaying;
    });
  }

  // void playAudio() {
  //   AudioPlayer audioPlayer = AudioPlayer();
  //   var urlSource = DeviceFileSource(filepath);
  //   audioPlayer.play(urlSource);
  // }

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
          downloadToLocalFile();
          // await playAudioFromUrl();
        },
        shape: const CircleBorder(),
        child: const Icon(Icons.play_lesson),
      ),
    );
  }
}
