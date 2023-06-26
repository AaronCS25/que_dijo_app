import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:que_dijo_app/services/file_picker_service.dart';
import 'package:que_dijo_app/views/camara_view.dart';
import 'package:que_dijo_app/views/recorder_view.dart';
import 'package:que_dijo_app/views/charging_view.dart';
import 'package:camera/camera.dart';

class UploadFilesView extends StatelessWidget {
  const UploadFilesView({super.key});

  @override
  Widget build(BuildContext context) {
    final FilePickerService filePickerService = FilePickerService();

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
                      await filePickerService.pickFile().then((value) {
                        if (value != null) {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => LoadingScreen(file: value),
                            ),
                          );
                        } else {
                          print('No file selected');
                        }
                      });
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
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const DisplayMicrophone()));
                        print('TapMic');
                      },
                      child: Image.asset('assets/images/mic.png',
                          width: 110, height: 110)),
                  GestureDetector(
                      onTap: () async {
                        // TODO: Navigator
                        PermissionStatus status =
                            await Permission.camera.request();
                        if (status.isGranted) {
                          await availableCameras().then(
                            (value) => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        DisplayCamera(cameras: value))),
                          );
                        } else {
                          openAppSettings();
                        }
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
