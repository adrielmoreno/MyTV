import 'dart:developer';

import 'package:tmdb_api/tmdb_api.dart';

import '../../../domain/models/movies_response.dart';
import '../../../env/env.dart';

class MovieDBService {
  late TMDB _tmdb;

  Future<void> init() async {
    try {
      _tmdb = TMDB(
        ApiKeys(
          Env.movieDBApiKey,
          Env.movieDBAccessToken,
        ),
        defaultLanguage: 'es-ES',
      );
    } catch (e) {
      log(e.toString());
    }
  }

  Future<MoviesResponse> getPopularMovies() async {
    final response = await _tmdb.v3.movies.getPopular();
    return MoviesResponse.fromJson(response);
  }

  Future<Map> getTrending({
    MediaType mediaType = MediaType.all,
    TimeWindow timeWindow = TimeWindow.day,
  }) async {
    return await _tmdb.v3.trending.getTrending(
      mediaType: mediaType,
      timeWindow: timeWindow,
    );
  }

  Future<Map> getMovieDetails(int movieId) async {
    return await _tmdb.v3.movies.getDetails(movieId);
  }

  Future<Map> searchMovies(String query) async {
    return await _tmdb.v3.search.queryMovies(query);
  }
}
