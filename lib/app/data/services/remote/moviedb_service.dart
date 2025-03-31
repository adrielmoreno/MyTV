import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:tmdb_api/tmdb_api.dart';

import '../../../domain/common/result.dart';
import '../../../domain/enums/signin_failure.dart';
import '../../../domain/models/movies_response.dart';
import '../../../domain/models/user/user.dart';
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

  Future<String?> createRequestToken() async {
    try {
      final response = await _tmdb.v3.auth.createRequestToken(
        asMap: true,
      );
      return response['request_token'] as String;
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  Future<Result<SignInFailure, String>> createSessionWithLogin(
      String username, String password) async {
    try {
      final response = await _tmdb.v3.auth.createSessionWithLogin(
        username,
        password,
      );
      // Success
      return Result.success(response as String);
    } on DioException catch (e) {
      // Error
      switch (e.response?.statusCode) {
        case 401:
          return Result.failure(SignInFailure.unauthorized);
        case 404:
          return Result.failure(SignInFailure.notFound);
        default:
          return Result.failure(SignInFailure.unknown);
      }
    } on SocketException {
      return Result.failure(SignInFailure.network);
    }
  }

  Future<Result<SignInFailure, String>> createSession(
      String requesToken) async {
    try {
      final response = await _tmdb.v3.auth.createSession(
        requesToken,
      );
      // Success
      return Result.success(response as String);
    } on DioException catch (e) {
      // Error
      switch (e.response?.statusCode) {
        case 401:
          return Result.failure(SignInFailure.unauthorized);
        case 404:
          return Result.failure(SignInFailure.notFound);
        default:
          return Result.failure(SignInFailure.unknown);
      }
    } on SocketException {
      return Result.failure(SignInFailure.network);
    }
  }

  Future<void> singOut(String sessionId) async {
    await _tmdb.v3.auth.deleteSession(sessionId);
  }

  Future<User?> getAccountDetails(String sessionId) async {
    try {
      final respose = await _tmdb.v3.account.getDetails(sessionId);
      return User.fromJson(respose as Map<String, dynamic>);
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  Future<MoviesResponse> getPopularMovies() async {
    final response = await _tmdb.v3.movies.getPopular();
    return MoviesResponse.fromJson(response as Map<String, dynamic>);
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
