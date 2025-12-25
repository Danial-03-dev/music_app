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
  final String? name;

  const PickedImage({this.file, this.bytes, this.name});
}

Future<PickedImage?> pickImage() async {
  try {
    final filePickerResult = await FilePicker.platform.pickFiles(
      type: FileType.image,
      withData: true,
    );

    if (filePickerResult == null) return null;

    final file = filePickerResult.files.first;

    return PickedImage(
      file: File(file.xFile.path),
      bytes: file.bytes,
      name: file.name,
    );
  } catch (e) {
    return null;
  }
}

String colorToHex(Color color) {
  final hexRadix = 16;
  final totalCharacters = 2;
  final spacing = '0';
  final rgbCode = 255;

  final rInt = (color.r * rgbCode).round();
  final gInt = (color.g * rgbCode).round();
  final bInt = (color.b * rgbCode).round();

  final r = rInt
      .round()
      .toRadixString(hexRadix)
      .padLeft(totalCharacters, spacing);
  final g = gInt
      .round()
      .toRadixString(hexRadix)
      .padLeft(totalCharacters, spacing);
  final b = bInt
      .round()
      .toRadixString(hexRadix)
      .padLeft(totalCharacters, spacing);

  return '#$r$g$b'.toUpperCase();
}

Color hexToColor(String hex) {
  hex = hex.replaceFirst('#', '');

  if (hex.length == 6) {
    hex = 'FF$hex'; // add full opacity
  }

  return Color(int.parse(hex, radix: 16));
}
