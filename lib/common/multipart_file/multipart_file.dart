import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class MultipartFile {

  static Future<void> addFileToRequest(http.MultipartRequest request, File file, String imageKey) async {
    String fileName = file.path.split('/').last;
    String fileType = fileName.split('.').last.toLowerCase();

    if (fileType == 'png') {
      request.files.add(http.MultipartFile.fromBytes(
        imageKey,
        await file.readAsBytes(),
        filename: fileName,
        contentType: MediaType('image', 'png'),
      ));
      debugPrint("Media type png ==== $fileName");
    }
    if (fileType == 'jpg' || fileType == 'jpeg') {
      request.files.add(http.MultipartFile.fromBytes(
        imageKey,
        await file.readAsBytes(),
        filename: fileName,
        contentType: MediaType('image', fileType),
        ),
      );
      debugPrint("Media type $fileType ==== $fileName");
    } else {
      debugPrint("Unsupported media type: $fileName");
      throw Exception('Unsupported file type');
    }
  }
}