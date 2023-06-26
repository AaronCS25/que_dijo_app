import 'package:flutter/material.dart';
import 'dart:io';
import 'package:que_dijo_app/services/play_service.dart';
import 'package:que_dijo_app/services/recorder_service.dart';
import 'package:que_dijo_app/views/charging_view.dart';

class PlayAudio extends StatefulWidget {
  const PlayAudio({super.key});

  @override
  State<PlayAudio> createState() => _PlayAudioState();
}

class _PlayAudioState extends State<PlayAudio> {
  SoundPlay player = SoundPlay();
  var icon = Icons.play_arrow;
  bool isUploading = false;

  @override
  void initState() {
    super.initState();
    player.initPlayer();
  }

  @override
  void dispose() {
    player.diposePlayer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    File file = File(archivoToSave);
    return Scaffold(
      appBar: AppBar(title: const Text('Enviar audio')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: () async {
                    await player.stateAudio(
                        whenFinished: () => setState(() {
                              if (player.paudio.isStopped) {
                                icon = Icons.play_arrow;
                              }
                            }));
                    setState(() {
                      if (icon == Icons.pause || player.paudio.isStopped) {
                        icon = Icons.play_arrow;
                      } else {
                        icon = Icons.pause;
                      }
                    });
                  },
                  child: Icon(icon, size: 60)),
              const SizedBox(height: 30),
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => LoadingScreen(file: file),
                      ),
                    );
                  },
                  child: const Icon(Icons.send, size: 60)),
            ],
          ),
        ),
      ),
    );
  }
}
