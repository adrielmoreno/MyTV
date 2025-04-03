import 'package:flutter/material.dart';
import 'package:tmdb_api/tmdb_api.dart';

import '../../../../core/di/app_modules.dart';
import '../../../../domain/common/result.dart';
import '../../../../domain/enums/signin_failure.dart';
import '../../../../domain/models/performer/performer_responses.dart';
import '../../../../domain/repositories/trending_repository.dart';
import 'trending_time_window.dart';

typedef EitherListPerformers = Result<SignInFailure, PerformerResponses>;

class TrendingPerformers extends StatefulWidget {
  const TrendingPerformers({
    super.key,
  });

  @override
  State<TrendingPerformers> createState() => _TrendingPerformersState();
}

class _TrendingPerformersState extends State<TrendingPerformers> {
  final _repository = inject<TrendingRepository>();
  late Future<EitherListPerformers> _futre;
  TimeWindow _timeWindow = TimeWindow.day;

  @override
  void initState() {
    super.initState();
    _futre = _repository.getPerformers();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 10.0,
      children: [
        TrendingTimeWindow(
          timeWindow: _timeWindow,
          onChanged: (timeWindow) {
            _timeWindow = timeWindow;
            _futre = _repository.getPerformers();
            setState(() {});
          },
        ),
        AspectRatio(
          aspectRatio: 16 / 8,
          child: LayoutBuilder(builder: (_, constraint) {
            final width = constraint.maxHeight * 0.65;
            return Center(
              child: FutureBuilder<EitherListPerformers>(
                key: ValueKey(_futre),
                future: _futre,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  }

                  return snapshot.data!.when(
                      (failure) => Text('Error: ${snapshot.error}'), (success) {
                    final movies = success.results ?? [];

                    if (movies.isEmpty) {
                      return const Text('No movies found');
                    }

                    return ListView.separated(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: movies.length,
                      itemBuilder: (context, index) {
                        return Text(
                          movies[index].name,
                        );
                      },
                      separatorBuilder: (_, __) => SizedBox(width: 10),
                    );
                  });
                },
              ),
            );
          }),
        ),
      ],
    );
  }
}
