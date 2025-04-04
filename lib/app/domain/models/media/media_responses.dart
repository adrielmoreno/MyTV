import '../../typedefs.dart';
import 'media.dart';

class MediaResponses {
  final int? page;
  final List<Media>? results;
  final int? totalPages;
  final int? totalResults;

  MediaResponses({
    this.page,
    this.results,
    this.totalPages,
    this.totalResults,
  });

  MediaResponses copyWith({
    int? page,
    List<Media>? results,
    int? totalPages,
    int? totalResults,
  }) =>
      MediaResponses(
        page: page ?? this.page,
        results: results ?? this.results,
        totalPages: totalPages ?? this.totalPages,
        totalResults: totalResults ?? this.totalResults,
      );

  factory MediaResponses.fromJson(Json json) => MediaResponses(
        page: json["page"],
        results: json["results"] == null
            ? []
            : getMediaList(List<Json>.from(json["results"]!)),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
      );
}
