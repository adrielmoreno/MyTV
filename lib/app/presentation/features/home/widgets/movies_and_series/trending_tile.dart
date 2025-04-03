import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:tmdb_api/tmdb_api.dart';

import '../../../../../domain/models/media/media.dart';
import '../../../../common/utils/images.dart';

class TrendingTile extends StatelessWidget {
  final Media media;
  final double width;
  final bool showData;

  const TrendingTile({
    super.key,
    required this.media,
    required this.width,
    this.showData = true,
  });

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
            if (showData)
              Positioned(
                right: 5,
                top: 5,
                child: Opacity(
                  opacity: 0.7,
                  child: Column(
                    spacing: 4,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Chip(
                        padding: EdgeInsets.zero,
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        label: Text(
                          media.voteAverage.toStringAsFixed(1),
                        ),
                      ),
                      Chip(
                        padding: EdgeInsets.zero,
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        label: Icon(
                          media.type == MediaType.movie
                              ? Icons.movie
                              : Icons.tv,
                          size: 15,
                        ),
                      ),
                    ],
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}
