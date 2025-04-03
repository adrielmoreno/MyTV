import 'dart:developer';

import 'package:tmdb_api/tmdb_api.dart';

import '../../domain/common/result.dart';
import '../../domain/enums/signin_failure.dart';
import '../../domain/models/media/media_responses.dart';
import '../../domain/models/performer/performer_responses.dart';
import '../../domain/repositories/trending_repository.dart';
import '../services/remote/moviedb_service.dart';

class TrendingRepositoryImpl implements TrendingRepository {
  final MovieDBService _movieDBService;

  TrendingRepositoryImpl(this._movieDBService);

  @override
  Future<Result<SignInFailure, MediaResponses>> getMoviesAndSeries(
      TimeWindow timeWindow) async {
    try {
      return _movieDBService.getMoviesAndSeries(timeWindow: timeWindow);
    } catch (e) {
      log(e.toString());
      return Result.failure(SignInFailure.unknown);
    }
  }

  @override
  Future<Result<SignInFailure, PerformerResponses>> getPerformers() async {
    try {
      return _movieDBService.getPerformers();
    } catch (e) {
      log(e.toString());
      return Result.failure(SignInFailure.unknown);
    }
  }
}
