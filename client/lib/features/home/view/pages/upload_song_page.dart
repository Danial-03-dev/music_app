import 'dart:io';

import 'package:client/core/theme/app_pallete.dart';
import 'package:client/core/utils/utils.dart';
import 'package:client/core/widgets/inputs/custom_field.dart';
import 'package:client/features/home/view/widgets/audio_wave.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UploadSongPage extends ConsumerStatefulWidget {
  const UploadSongPage({super.key});

  @override
  ConsumerState<UploadSongPage> createState() => _UploadSongPageState();
}

class _UploadSongPageState extends ConsumerState<UploadSongPage> {
  final TextEditingController songNameController = TextEditingController();
  final TextEditingController artistController = TextEditingController();

  Color selectedColor = Pallete.cardColor;
  PickedImage? selectedImage;
  PickedMedia? selectedAudio;

  void selectAudio() async {
    final pickedAudio = await pickAudio();

    setState(() {
      selectedAudio = pickedAudio;
    });
  }

  void selectImage() async {
    final pickedImage = await pickImage();

    setState(() {
      selectedImage = pickedImage;
    });
  }

  @override
  void dispose() {
    songNameController.dispose();
    artistController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isNotMobile = kIsWeb || !(Platform.isAndroid || Platform.isIOS);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Upload Song'),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.check))],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            spacing: 40,
            children: [
              GestureDetector(
                onTap: selectImage,
                child: DottedBorder(
                  options: RoundedRectDottedBorderOptions(
                    color: Pallete.borderColor,
                    dashPattern: [12, 4],
                    radius: Radius.circular(12),
                    strokeCap: StrokeCap.round,
                  ),
                  child: SizedBox(
                    height: 152,
                    width: double.infinity,
                    child: selectedImage != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.memory(
                              selectedImage!.bytes!,
                              fit: BoxFit.cover,
                            ),
                          )
                        : const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            spacing: 16,
                            children: [
                              Icon(Icons.folder_open, size: 40),
                              Text(
                                'Select the thumbnail for your song',
                                style: TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                  ),
                ),
              ),
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
                    onColorChanged: (color) {
                      setState(() {
                        selectedColor = color;
                      });
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
