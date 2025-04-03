import 'package:freezed_annotation/freezed_annotation.dart';

import '../../typedefs.dart';
import '../media/media.dart';

part 'performer.freezed.dart';
part 'performer.g.dart';

@freezed
abstract class Performer with _$Performer {
  const factory Performer({
    required int id,
    required String name,
    required double popularity,
    required bool adult,
    @JsonKey(name: 'original_name') required String originalName,
    @JsonKey(name: 'known_for') required List<Media> knownFor,
    @JsonKey(name: 'profile_path') String? profilePath,
    @JsonKey(name: 'known_for_department') String? knownsForDepartment,
  }) = _Performer;

  factory Performer.fromJson(Json json) => _$PerformerFromJson(json);
}

List<Performer> getPerformerList(List<Json> list) {
  return list
      .where(
        (e) =>
            e['known_for_department'] == 'Acting' && e['profile_path'] != null,
      )
      .map(
        (x) => Performer.fromJson(x),
      )
      .toList();
}
