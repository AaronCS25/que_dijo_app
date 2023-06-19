import 'dart:io';

import 'package:flutter/material.dart';
import 'package:que_dijo_app/services/file_picker_service.dart';
//import 'package:path/path.dart' as path;

class UploadFilesView extends StatelessWidget {
  const UploadFilesView({super.key});

  @override
  Widget build(BuildContext context) {
    final FilePickerService filePickerService = FilePickerService();

    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () async {
                File? file = await filePickerService.pickFile();
                if (file != null) {
                } else {}
              },
              child: Image.asset(
                'assets/images/multimedia.png',
                width: 200,
                height: 200,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
