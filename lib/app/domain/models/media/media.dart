import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tmdb_api/tmdb_api.dart';

import '../../typedefs.dart';

part 'media.freezed.dart';
part 'media.g.dart';

@freezed
abstract class Media with _$Media {
  const factory Media({
    required int id,
    required String overview,
    @JsonKey(readValue: readTitleOrName) required String title,
    bool? adult,
    double? popularity,
    bool? video,
    @JsonKey(readValue: readOriginalTitleOrOriginalName)
    required String originalTitle,
    @JsonKey(name: 'poster_path') required String posterPath,
    @JsonKey(name: 'backdrop_path') required String backdropPath,
    @JsonKey(name: 'vote_average') required double voteAverage,
    @JsonKey(name: 'media_type') required MediaType type,
    @JsonKey(name: 'genre_ids') List<int>? genreIds,
    @JsonKey(name: 'original_language') String? originalLanguage,
    @JsonKey(name: 'release_date') DateTime? releaseDate,
    @JsonKey(name: 'vote_count') int? voteCount,
  }) = _Media;

  factory Media.fromJson(Json json) => _$MediaFromJson(json);
}

Object? readTitleOrName(Map map, String _) {
  return map['title'] ?? map['name'];
}

Object? readOriginalTitleOrOriginalName(Map map, String _) {
  return map['original_title'] ?? map['original_name'];
}
