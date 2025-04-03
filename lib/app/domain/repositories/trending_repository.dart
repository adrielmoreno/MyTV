import 'package:tmdb_api/tmdb_api.dart';

import '../common/result.dart';
import '../enums/signin_failure.dart';
import '../models/media/media_responses.dart';
import '../models/performer/performer_responses.dart';

abstract class TrendingRepository {
  Future<Result<SignInFailure, MediaResponses>> getMoviesAndSeries(
    TimeWindow timeWindow,
  );
  Future<Result<SignInFailure, PerformerResponses>> getPerformers();
}
