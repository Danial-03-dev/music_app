import 'package:client/core/theme/app_pallete.dart';
import 'package:client/core/utils/utils.dart';
import 'package:client/core/widgets/custom_scroll_config.dart';
import 'package:client/features/home/view/widgets/app_bars/upload_audio_app_bar.dart';
import 'package:client/features/home/view/widgets/forms/upload_audio_form.dart';
import 'package:client/features/home/view_model/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UploadAudioPage extends ConsumerStatefulWidget {
  static PageRoute route() =>
      MaterialPageRoute(builder: (context) => const UploadAudioPage());

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

  void onColorChanged(Color color) {
    setState(() {
      selectedColor = color;
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
    ref.listen(homeViewModelProvider, (_, next) {
      next?.when(
        data: (_) {
          showSnackBar(context, 'Audio uploaded successfully!');
        },
        error: (error, st) {
          showSnackBar(context, error.toString());
        },
        loading: () {},
      );
    });

    return Scaffold(
      appBar: UploadAudioAppBar(onUpload: handleUploadAudio),
      body: CustomScrollConfig(
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 512),
                child: UploadAudioForm(
                  formKey: formKey,
                  songNameController: songNameController,
                  artistController: artistController,
                  selectedColor: selectedColor,
                  selectedImage: selectedImage,
                  selectedAudio: selectedAudio,
                  selectAudio: selectAudio,
                  selectImage: selectImage,
                  onColorChanged: onColorChanged,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
