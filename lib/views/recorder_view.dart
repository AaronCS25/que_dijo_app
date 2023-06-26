import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:que_dijo_app/services/recorder_service.dart';
import 'package:que_dijo_app/views/play_view.dart';

class DisplayMicrophone extends StatefulWidget {
  const DisplayMicrophone({Key? key}) : super(key: key);

  @override
  State<DisplayMicrophone> createState() => _DisplayMicrophoneState();
}

class _DisplayMicrophoneState extends State<DisplayMicrophone> {
  final grabacion = Recorder();
  String label = 'START';
  bool allowed = false;
  var icon = Icons.mic;

  @override
  void initState() {
    super.initState();
    grabacion.initMicrophone();
  }

  @override
  void dispose() {
    grabacion.diposeMicrophone();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Grabar audio'),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            StreamBuilder<RecordingDisposition>(
              stream: grabacion.grabacion.onProgress,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                final duration =
                    snapshot.hasData ? snapshot.data.duration : Duration.zero;

                String setToString(int n) => n.toString().padLeft(2, '0');
                final minutes = setToString(duration.inMinutes.remainder(60));
                final seconds = setToString(duration.inSeconds.remainder(60));
                final hours = setToString(duration.inHours.remainder(60));

                return Text(
                  '$hours:$minutes:$seconds',
                  style: const TextStyle(fontSize: 48.0, color: Colors.teal),
                );
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () async {
                setState(() {
                  if (label == 'START') {
                    label = 'STOP';
                    icon = Icons.stop;
                  } else {
                    label = 'START';
                    icon = Icons.mic;
                    allowed = true;
                  }
                });
                grabacion.statusRecording();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal, // background
                foregroundColor: Colors.white, // foreground
              ),
              label: Text(label),
              icon: Icon(icon),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () async {
                if (allowed) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const PlayAudio()));
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal, // background
                foregroundColor: Colors.white, // foreground
              ),
              label: const Text('ENVIAR'),
              icon: const Icon(Icons.send),
            ),
          ],
        ),
      ),
    );
  }
}
