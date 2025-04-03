import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../../domain/models/performer/performer.dart';
import '../../../../common/utils/images.dart';
import '../movies_and_series/trending_tile.dart';

class PerformerTile extends StatelessWidget {
  const PerformerTile({
    super.key,
    required this.perfomer,
  });

  final Performer perfomer;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Stack(
          children: [
            Positioned.fill(
              child: CachedNetworkImage(
                imageUrl: getImageUrl('${perfomer.profilePath}',
                    imageQuality: ImageQuality.original),
                fit: BoxFit.cover,
                placeholder: (context, url) => const Center(
                  child: CircularProgressIndicator(),
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
            Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: EdgeInsets.all(15).copyWith(bottom: 40),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black54,
                      ],
                    ),
                  ),
                  child: Column(
                    spacing: 10,
                    children: [
                      Text(
                        perfomer.name,
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 120,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: perfomer.knownFor.length,
                          itemBuilder: (_, index) {
                            final media = perfomer.knownFor[index];
                            return TrendingTile(
                              media: media,
                              width: 120 * 0.7,
                              showData: false,
                            );
                          },
                          separatorBuilder: (_, __) => SizedBox(
                            width: 10,
                          ),
                        ),
                      )
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
