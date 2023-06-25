import 'package:flutter/material.dart';
import 'dart:io';
import 'package:que_dijo_app/classes/play_class.dart';
import 'package:que_dijo_app/classes/recorder_class.dart';
import 'package:path/path.dart' as path;
import 'package:que_dijo_app/services/auth_service.dart';
import 'package:que_dijo_app/services/crypto_name_service.dart';
import 'package:que_dijo_app/services/generate_summary_service.dart';
import 'package:que_dijo_app/services/s3_service.dart';

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
    //String fileName = path.basename(file.path);

    final S3UploadService s3uploadService = S3UploadService();
    final CryptoNameService cryptoNameService = CryptoNameService();
    final GenerateSummary generateSummary = GenerateSummary();
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
                  onPressed: isUploading
                      ? null
                      : () async {
                          setState(() {
                            isUploading = true;
                          });
                          try {
                            //TODO: Actualizar S3UploadServices.
                            String userId = await Auth.getUserId();
                            String fileName = path.basename(file.path);
                            String fileExtension = path.extension(file.path);
                            String fileNameCrypto = cryptoNameService
                                .encryptName(fileName, fileExtension, userId);
                            print(fileNameCrypto);
                            print(fileExtension);
                            await s3uploadService.uploadFile(
                                file, fileNameCrypto);
                            // TODO: Actualizar la función para generar resúmenes.
                            generateSummary.generateFullSummary(
                                fileNameCrypto, fileExtension);
                          } catch (e) {
                            //Falta hacer
                          } finally {
                            setState(() {
                              isUploading = false;
                            });
                          }
                        },
                  child: const Icon(Icons.send, size: 60)),
              if (isUploading)
                const Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: CircularProgressIndicator(),
                ),
              if (isUploading)
                const Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Text("Subiendo el archivo..."),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
