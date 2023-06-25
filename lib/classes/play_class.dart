import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:que_dijo_app/classes/recorder_class.dart';

class SoundPlay {
  FlutterSoundPlayer paudio = FlutterSoundPlayer();
  Future audioPlay(VoidCallback whenFinished) async {
    await paudio.startPlayer(
      fromURI: archivoToSave,
      whenFinished: whenFinished,
    );
  }

  Future initPlayer() async {
    await paudio.openPlayer();
  }

  Future diposePlayer() async {
    await paudio.closePlayer();
  }

  Future audioStop() async {
    await paudio.stopPlayer();
  }

  Future stateAudio({required VoidCallback whenFinished}) async {
    if (paudio.isStopped) {
      await audioPlay(whenFinished);
    } else {
      await audioStop();
    }
  }
}
