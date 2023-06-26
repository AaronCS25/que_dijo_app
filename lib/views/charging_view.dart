import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;
import 'package:que_dijo_app/services/auth_service.dart';
import 'package:que_dijo_app/services/crypto_name_service.dart';
import 'package:que_dijo_app/services/generate_summary_service.dart';
import 'package:que_dijo_app/services/s3_service.dart';
import 'package:que_dijo_app/views/home_view.dart';
import 'dart:io';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key, required this.file});
  final File file;

  Future<String> uploadFile() async {
    final S3UploadService s3uploadService = S3UploadService();
    final CryptoNameService cryptoNameService = CryptoNameService();
    final GenerateSummary generateSummary = GenerateSummary();
    try {
      //falta
      String userId = await Auth.getUserId();
      String fileName = path.basename(file.path);
      String fileExtension = path.extension(file.path);
      String fileNameCrypto =
          cryptoNameService.encryptName(fileName, fileExtension, userId);
      await s3uploadService.uploadFile(file, fileNameCrypto);
      await generateSummary.generateFullSummary(fileNameCrypto, fileExtension);
      // After file upload operation finishes, return 'Success'
      return 'Success';
    } catch (e) {
      // If any error occurs during the file upload operation, return 'Failure'
      print(e);
      return 'Failure';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder<String>(
        future: uploadFile(),
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CircularProgressIndicator(),
                  SizedBox(height: 20),
                  Text(
                    'Subiendo...',
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text(
                'Error durante la subida',
                style: TextStyle(fontSize: 20),
              ),
            );
          } else {
            if (snapshot.data == 'Success') {
              Future.delayed(const Duration(seconds: 1), () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HomeView()),
                );
              });
              return const Center(
                child: Text(
                  'Subida exitosa!',
                  style: TextStyle(fontSize: 20, color: Colors.green),
                ),
              );
            } else {
              return const Center(
                child: Text(
                  'Subida fallida',
                  style: TextStyle(fontSize: 20, color: Colors.red),
                ),
              );
            }
          }
        },
      ),
    );
  }
}
