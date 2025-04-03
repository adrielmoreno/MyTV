import '../../typedefs.dart';
import 'performer.dart';

class PerformerResponses {
  final int? page;
  final List<Performer>? results;
  final int? totalPages;
  final int? totalResults;

  PerformerResponses({
    this.page,
    this.results,
    this.totalPages,
    this.totalResults,
  });

  PerformerResponses copyWith({
    int? page,
    List<Performer>? results,
    int? totalPages,
    int? totalResults,
  }) =>
      PerformerResponses(
        page: page ?? this.page,
        results: results ?? this.results,
        totalPages: totalPages ?? this.totalPages,
        totalResults: totalResults ?? this.totalResults,
      );

  factory PerformerResponses.fromJson(Json json) => PerformerResponses(
        page: json["page"],
        results: json["results"] == null
            ? []
            : getPerformerList(List<Json>.from(json["results"]!)),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
      );
}
