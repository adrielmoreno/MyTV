import 'package:flutter/material.dart';
import 'package:tmdb_api/tmdb_api.dart';

import '../../../../../core/di/app_modules.dart';
import '../../../../../domain/common/result.dart';
import '../../../../../domain/enums/signin_failure.dart';
import '../../../../../domain/models/media/media_responses.dart';
import '../../../../../domain/repositories/trending_repository.dart';
import '../../../../common/widgets/request_failed.dart';
import 'trending_tile.dart';
import 'trending_time_window.dart';

typedef EitherListMedia = Result<SignInFailure, MediaResponses>;

class TrendingList extends StatefulWidget {
  const TrendingList({
    super.key,
  });

  @override
  State<TrendingList> createState() => _TrendingListState();
}

class _TrendingListState extends State<TrendingList> {
  final _repository = inject<TrendingRepository>();
  late Future<EitherListMedia> _futre;
  TimeWindow _timeWindow = TimeWindow.day;

  @override
  void initState() {
    super.initState();
    _updateFuture(_timeWindow);
  }

  void _updateFuture(TimeWindow timeWindow) {
    _timeWindow = timeWindow;
    _futre = _repository.getMoviesAndSeries(_timeWindow);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 10.0,
      children: [
        TrendingTimeWindow(
          timeWindow: _timeWindow,
          onChanged: _updateFuture,
        ),
        AspectRatio(
          aspectRatio: 16 / 8,
          child: LayoutBuilder(
            builder: (_, constraint) {
              final width = constraint.maxHeight * 0.65;
              return Center(
                child: FutureBuilder<EitherListMedia>(
                    key: ValueKey(_futre),
                    future: _futre,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      }

                      if (snapshot.hasError) {
                        return RequestFailed(
                          text: 'Error: ${snapshot.error}',
                          onRetry: () {
                            _updateFuture(_timeWindow);
                          },
                        );
                      }

                      return snapshot.data!.when(
                        (failure) => RequestFailed(
                          text: 'Error: ${failure.message}',
                          onRetry: () {
                            _updateFuture(_timeWindow);
                          },
                        ),
                        (success) {
                          final movies = success.results ?? [];

                          return ListView.separated(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            physics: const BouncingScrollPhysics(),
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: movies.length,
                            itemBuilder: (context, index) {
                              return TrendingTile(
                                  media: movies[index], width: width);
                            },
                            separatorBuilder: (_, __) => SizedBox(width: 10),
                          );
                        },
                      );
                    }),
              );
            },
          ),
        ),
      ],
    );
  }
}
