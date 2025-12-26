// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:client/core/utils/utils.dart';
import 'package:client/core/widgets/inputs/custom_field.dart';
import 'package:client/features/home/view/widgets/audio_wave.dart';
import 'package:client/features/home/view/widgets/input/image_picker.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class UploadAudioForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController songNameController;
  final TextEditingController artistController;
  final Color selectedColor;
  final PickedImage? selectedImage;
  final PickedMedia? selectedAudio;
  final VoidCallback? selectAudio;
  final VoidCallback? selectImage;
  final void Function(Color) onColorChanged;

  const UploadAudioForm({
    super.key,
    required this.formKey,
    required this.songNameController,
    required this.artistController,
    required this.selectedColor,
    required this.selectedImage,
    required this.selectedAudio,
    required this.selectAudio,
    required this.selectImage,
    required this.onColorChanged,
  });

  @override
  Widget build(BuildContext context) {
    final isNotMobile = kIsWeb || !(Platform.isAndroid || Platform.isIOS);

    return Form(
      key: formKey,
      child: Column(
        spacing: 40,
        children: [
          ImagePicker(selectImage: selectImage, selectedImage: selectedImage),
          Column(
            spacing: 20,
            children: [
              selectedAudio != null && !isNotMobile
                  ? AudioWave(path: selectedAudio!.file!.path)
                  : Customfield(
                      hintText: selectedAudio?.name ?? 'Pick Song',
                      readOnly: true,
                      onTap: selectAudio,
                    ),
              Customfield(
                hintText: 'Song Name',
                controller: songNameController,
              ),
              Customfield(hintText: 'Artist', controller: artistController),
              ColorPicker(
                pickersEnabled: {ColorPickerType.wheel: true},
                color: selectedColor,
                onColorChanged: onColorChanged,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
