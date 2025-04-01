import 'package:flutter/material.dart';

import '../../../../core/di/app_modules.dart';
import '../../../../domain/repositories/trending_repository.dart';
import 'movie_card.dart';

class TrendingList extends StatelessWidget {
  const TrendingList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: inject<TrendingRepository>().getMoviesAndSeries(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }

        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        if (snapshot.hasData) {
          final moviesResponse = snapshot.data!;
          final movies = moviesResponse.success?.results ?? [];

          if (movies.isEmpty) {
            return const Text('No movies found');
          }

          return ListView.builder(
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            itemCount: movies.length,
            itemBuilder: (context, index) {
              return MovieCard(media: movies[index]);
            },
          );
        }

        return const Text('No data');
      },
    );
  }
}
