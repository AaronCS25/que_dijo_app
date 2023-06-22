import 'dart:io';

import 'package:aws_s3_upload/aws_s3_upload.dart';

class S3UploadService {
  Future<void> uploadFile(File file, String uploadFileName) async {
    await AwsS3.uploadFile(
      accessKey: 'AKIAZSDU63RF2ZHGP57Y',
      secretKey: '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',
      file: File(file.path),
      bucket: 'recursos-no-procesados',
      region: 'us-east-1',
      key: uploadFileName,
    );
  }
}
