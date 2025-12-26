import 'package:client/core/providers/current_user/current_user_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ImageContainer extends ConsumerWidget {
  final String imageURL;
  final BorderRadiusGeometry? borderRadius;
  final double? width;
  final double? height;

  const ImageContainer({
    super.key,
    required this.imageURL,
    this.borderRadius,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final token = ref.watch(currentUserProvider)?.token ?? '';

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: borderRadius ?? BorderRadius.circular(8),
        image: DecorationImage(
          image: NetworkImage(
            imageURL,
            headers: {'Authorization': 'Bearer $token'},
          ),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
