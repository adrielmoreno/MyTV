import '../common/result.dart';
import '../enums/signin_failure.dart';
import '../models/media/media_responses.dart';

abstract class TrendingRepository {
  Future<Result<SignInFailure, MediaResponses>> getMoviesAndSeries();
}
