import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String content) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(SnackBar(content: Text(content)));
}

class PickedMedia {
  final File? file;
  final Uint8List? bytes;
  final String? name;

  const PickedMedia({this.file, this.bytes, this.name});
}

Future<PickedMedia?> pickAudio() async {
  try {
    final filePickerResult = await FilePicker.platform.pickFiles(
      type: FileType.audio,
      withData: true,
    );

    if (filePickerResult == null) return null;

    final file = filePickerResult.files.first;

    return PickedMedia(
      file: File(file.xFile.path),
      bytes: file.bytes,
      name: file.name,
    );
  } catch (e) {
    return null;
  }
}

class PickedImage {
  final File? file;
  final Uint8List? bytes;

  const PickedImage({this.file, this.bytes});
}

Future<PickedImage?> pickImage() async {
  try {
    final filePickerResult = await FilePicker.platform.pickFiles(
      type: FileType.image,
      withData: true,
    );

    if (filePickerResult == null) return null;

    final file = filePickerResult.files.first;

    return PickedImage(file: File(file.xFile.path), bytes: file.bytes);
  } catch (e) {
    return null;
  }
}
