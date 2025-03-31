import 'package:freezed_annotation/freezed_annotation.dart';

import '../../typedefs.dart';

part 'media.freezed.dart';
part 'media.g.dart';

@freezed
abstract class Media with _$Media {
  const factory Media({
    required int id,
    required String overview,
    String? title,
    String? name, // TV
    bool? adult,
    double? popularity,
    bool? video,
    @JsonKey(name: 'original_title') required String? originalTitle,
    @JsonKey(name: 'poster_path') required String posterPath,
    @JsonKey(name: 'backdrop_path') required String backdropPath,
    @JsonKey(name: 'vote_average') required double voteAverage,
    @JsonKey(name: 'media_type') required String type,
    @JsonKey(name: 'genre_ids') List<int>? genreIds,
    @JsonKey(name: 'original_language') String? originalLanguage,
    @JsonKey(name: 'release_date') DateTime? releaseDate,
    @JsonKey(name: 'vote_count') int? voteCount,
  }) = _Media;

  factory Media.fromJson(Json json) => _$MediaFromJson(json);
}
