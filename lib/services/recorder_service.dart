import 'package:flutter_sound/flutter_sound.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

String archivoToSave = 'audio_example.aac';

class Recorder {
  FlutterSoundRecorder grabacion = FlutterSoundRecorder();

  Future startRecording() async {
    final directory = await getApplicationDocumentsDirectory();
    archivoToSave = '${directory.path}/audio_example.aac';
    await grabacion.startRecorder(toFile: archivoToSave);
  }

  Future stopRecording() async {
    final path = await grabacion.stopRecorder();
    final audioFile = File(path!);
    print('Recorded audio: $audioFile');
  }

  Future statusRecording() async {
    if (grabacion.isStopped) {
      await startRecording();
    } else {
      await stopRecording();
    }
  }

  Future initMicrophone() async {
    PermissionStatus status = await Permission.microphone.request();
    if (status.isGranted) {
      await grabacion.openRecorder();
      grabacion.setSubscriptionDuration(const Duration(milliseconds: 500));
    } else {
      openAppSettings();
    }
  }

  Future diposeMicrophone() async {
    grabacion.closeRecorder();
  }
}
