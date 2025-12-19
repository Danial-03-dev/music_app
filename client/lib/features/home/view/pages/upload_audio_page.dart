import 'dart:io';

import 'package:client/core/theme/app_pallete.dart';
import 'package:client/core/utils/utils.dart';
import 'package:client/core/widgets/inputs/custom_field.dart';
import 'package:client/core/widgets/loader.dart';
import 'package:client/features/home/view/widgets/audio_wave.dart';
import 'package:client/features/home/view_model/home_view_model.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UploadAudioPage extends ConsumerStatefulWidget {
  const UploadAudioPage({super.key});

  @override
  ConsumerState<UploadAudioPage> createState() => _UploadAudioPageState();
}

class _UploadAudioPageState extends ConsumerState<UploadAudioPage> {
  final formKey = GlobalKey<FormState>();
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

  void handleUploadAudio() async {
    if (!formKey.currentState!.validate()) return;

    if (selectedAudio == null) {
      showSnackBar(context, 'Missing audio!');
      return;
    }
    if (selectedImage == null) {
      showSnackBar(context, 'Missing image!');
      return;
    }

    final audioName = songNameController.text.trim();
    final artist = artistController.text.trim();

    await ref
        .read(homeViewModelProvider.notifier)
        .uploadAudio(
          image: selectedImage!,
          audio: selectedAudio!,
          audioName: audioName,
          artist: artist,
          color: selectedColor,
        );
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
    final bool isLoading = ref.watch(
      homeViewModelProvider.select((value) => value?.isLoading == true),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Upload Song'),
        actions: [
          isLoading
              ? Loader()
              : IconButton(
                  onPressed: handleUploadAudio,
                  icon: Icon(Icons.check),
                ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: formKey,
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
                    Customfield(
                      hintText: 'Artist',
                      controller: artistController,
                    ),
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
      ),
    );
  }
}
