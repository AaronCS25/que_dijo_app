import 'dart:io';

import 'package:flutter/material.dart';
import 'package:que_dijo_app/services/file_picker_service.dart';
import 'package:que_dijo_app/services/s3_service.dart';
import 'package:path/path.dart' as path;

class UploadFilesView extends StatelessWidget {
  const UploadFilesView({super.key});

  @override
  Widget build(BuildContext context) {
    final FilePickerService filePickerService = FilePickerService();
    final S3UploadService s3uploadService = S3UploadService();

    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            iconSize: 30,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Column(
          children: [
            const Divider(
              color: Colors.grey,
              thickness: 1,
            ),
            Expanded(
              flex: 15,
              child: Center(
                child: GestureDetector(
                    onTap: () async {
                      File? file = await filePickerService.pickFile();
                      if (file != null) {
                        //TODO: Actualizas S3UploadServices.
                        String fileName = path.basename(file.path);
                        await s3uploadService.uploadFile(file, fileName);
                      } else {
                        //TODO: Que hacer si no se escoge archivo.
                        print('No se escogio un archivo!');
                      }
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/multimedia.png',
                          width: 200,
                          height: 200,
                        ),
                        const Text('Upload Files'),
                      ],
                    )),
              ),
            ),
            const Divider(
              color: Colors.grey,
              thickness: 1,
            ),
            Expanded(
              flex: 3,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                      onTap: () {
                        // TODO: Navigator
                        print('TapMic');
                      },
                      child: Image.asset('assets/images/mic.png',
                          width: 110, height: 110)),
                  GestureDetector(
                      onTap: () {
                        // TODO: Navigator
                        print('TapImage');
                      },
                      child: Image.asset('assets/images/photo.png',
                          width: 110, height: 110))
                ],
              ),
            )
          ],
        ));
  }
}
