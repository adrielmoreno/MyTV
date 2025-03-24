import 'package:envied/envied.dart';

part 'env.g.dart';

/// Using after add field
/// -> dart run build_runner build

@Envied(path: '.env', obfuscate: true)
abstract class Env {
  //  MovieDB
  @EnviedField(varName: 'MOVIEDB_API_KEY')
  static final String movieDBApiKey = _Env.movieDBApiKey;

  @EnviedField(varName: 'MOVIEDB_ACCESS_TOKEN')
  static final String movieDBAccessToken = _Env.movieDBAccessToken;
}
