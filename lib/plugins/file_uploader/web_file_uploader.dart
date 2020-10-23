/*
 * This software and associated documentation files are
 *
 * Copyright © 2020-2020 Koninklijke Philips N.V.
 *
 * and is made available for use within Philips and/or within Philips products.
 *
 * All Rights Reserved
 */

import 'dart:async';
import 'dart:convert';
import 'dart:html'; // ignore: avoid_web_libraries_in_flutter
import 'dart:typed_data';

import 'package:http/http.dart';

class FileUploader {
  FileUploader(this.uri, {this.field = 'file'});

  final Uri uri;
  final String field;

  /// Picks a single file and uploads it as multipart POST to the indicated [Uri].
  Future<void> upload() async {
    final file = await _pickFile();
    if (file == null) return;

    final content = await _getFileContent(file);
    await _uploadDataToServer(field, content, file.name);
  }

  Future<File> _pickFile() async {
    final uploadInput = FileUploadInputElement()
      ..multiple = false
      ..draggable = true
      ..click();
    document.body.append(uploadInput);

    final completer = Completer<File>();
    uploadInput.onChange.listen((e) {
      uploadInput.remove();
      final files = uploadInput.files;
      completer.complete(files.isNotEmpty ? files.first : null);
    });

    return completer.future;
  }

  Future<Uint8List> _getFileContent(File file) {
    final completer = Completer<Uint8List>();

    final reader = FileReader();
    reader.onLoadEnd.listen((event) {
      try {
        var data =
            Base64Decoder().convert(reader.result.toString().split(",").last);
        completer.complete(data);
      } catch (e) {
        completer.completeError(e);
      }
    });
    reader.readAsDataUrl(file);

    return completer.future;
  }

  Future<void> _uploadDataToServer(
      String param, Uint8List data, String filename) async {
    final request = MultipartRequest('POST', uri)
      ..files.add(MultipartFile.fromBytes(param, data, filename: filename));
    final response = await request.send();

    if (response.statusCode != 200) {
      throw Exception('File upload failed with status ${response.statusCode}');
    }
  }
}
