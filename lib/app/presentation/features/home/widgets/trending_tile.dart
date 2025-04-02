import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../domain/models/media/media.dart';
import '../../../common/utils/images.dart';

class TrendingTile extends StatelessWidget {
  final Media media;
  final double width;

  const TrendingTile({super.key, required this.media, required this.width});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: SizedBox(
        width: width,
        child: Stack(
          children: [
            Positioned.fill(
              child: CachedNetworkImage(
                imageUrl: getImageUrl(media.posterPath),
                fit: BoxFit.cover,
                placeholder: (context, url) => const Center(
                  child: CircularProgressIndicator(),
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
            Positioned(
                right: 5,
                top: 5,
                child: Chip(
                  padding: EdgeInsets.zero,
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  label: Text(
                    media.voteAverage.toStringAsFixed(1),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
