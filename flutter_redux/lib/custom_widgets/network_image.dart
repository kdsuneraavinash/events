import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';

/// Creates an Cached Network Image with default placeholder
/// Will have a fixed aspect ratio
class DefParameterNetworkImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: this.imageUrl,
      fit: isCover ? BoxFit.cover : BoxFit.contain,
      width: MediaQuery.of(context).size.width,
      height: isCover ? MediaQuery.of(context).size.width / aspectRatio : null,
    );
  }

  DefParameterNetworkImage({this.imageUrl, this.isCover = false});

  final String imageUrl;
  final bool isCover;
  final aspectRatio = 16 / 9;
}
