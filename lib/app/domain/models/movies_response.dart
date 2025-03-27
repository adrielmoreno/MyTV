import 'movie.dart';

class MoviesResponse {
  final int? page;
  final List<Movie>? results;
  final int? totalPages;
  final int? totalResults;

  MoviesResponse({
    this.page,
    this.results,
    this.totalPages,
    this.totalResults,
  });

  MoviesResponse copyWith({
    int? page,
    List<Movie>? results,
    int? totalPages,
    int? totalResults,
  }) =>
      MoviesResponse(
        page: page ?? this.page,
        results: results ?? this.results,
        totalPages: totalPages ?? this.totalPages,
        totalResults: totalResults ?? this.totalResults,
      );

  factory MoviesResponse.fromJson(Map<String, dynamic> json) => MoviesResponse(
        page: json["page"],
        results: json["results"] == null
            ? []
            : List<Movie>.from(json["results"]!.map((x) => Movie.fromJson(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
      );

  Map<String, dynamic> toJson() => {
        "page": page,
        "results": results == null
            ? []
            : List<dynamic>.from(results!.map((x) => x.toJson())),
        "total_pages": totalPages,
        "total_results": totalResults,
      };
}
