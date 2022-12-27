import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class MoviesImage extends StatelessWidget {
  final String imageUrl;
  final double? width;
  final double? height;

  const MoviesImage({
    Key? key,
    required this.imageUrl,
    this.width,
    this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      width: width,
      height: height,
      placeholder: (_, __) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
      errorWidget: (_, __, ___) {
        return const Icon(Icons.movie_creation_outlined);
      },
    );
  }
}
