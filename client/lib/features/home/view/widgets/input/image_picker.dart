import 'package:client/core/theme/app_pallete.dart';
import 'package:client/core/utils/utils.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class ImagePicker extends StatelessWidget {
  final PickedImage? selectedImage;
  final VoidCallback? selectImage;
  const ImagePicker({super.key, this.selectedImage, this.selectImage});

  @override
  Widget build(BuildContext context) {
    final double radius = 12;

    return Semantics(
      label: 'Pick Image',
      button: true,
      child: InkWell(
        borderRadius: BorderRadius.circular(radius),
        onTap: selectImage,
        child: DottedBorder(
          options: RoundedRectDottedBorderOptions(
            color: Pallete.borderColor,
            dashPattern: [12, 4],
            radius: Radius.circular(radius),
            strokeCap: StrokeCap.round,
          ),
          child: SizedBox(
            height: 152,
            width: double.infinity,
            child: selectedImage != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(radius),
                    child: Image.memory(
                      selectedImage!.bytes!,
                      fit: BoxFit.cover,
                    ),
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: 16,
                    children: [
                      Icon(Icons.folder_open, size: 40),
                      Text(
                        'Select the thumbnail for your song',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Pallete.greyColor,
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
