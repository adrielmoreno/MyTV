import 'dart:developer';

import '../../domain/common/result.dart';
import '../../domain/enums/signin_failure.dart';
import '../../domain/models/media/media_responses.dart';
import '../../domain/repositories/trending_repository.dart';
import '../services/remote/moviedb_service.dart';

class TrendingRepositoryImpl implements TrendingRepository {
  final MovieDBService _movieDBService;

  TrendingRepositoryImpl(this._movieDBService);
  @override
  Future<Result<SignInFailure, MediaResponses>> getMoviesAndSeries() async {
    try {
      return _movieDBService.getMoviesAndSeries();
    } catch (e) {
      log(e.toString());
      return Result.failure(SignInFailure.unknown);
    }
  }
}
