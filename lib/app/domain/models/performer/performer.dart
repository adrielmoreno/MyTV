import 'package:freezed_annotation/freezed_annotation.dart';

import '../../typedefs.dart';

part 'performer.freezed.dart';
part 'performer.g.dart';

@freezed
abstract class Performer with _$Performer {
  factory Performer({
    required int id,
    required String name,
    required double popularity,
    required bool adult,
    @JsonKey(name: 'original_name') required String originalName,
    @JsonKey(name: 'profile_path') String? profilePath,
    @JsonKey(name: 'known_for_department') String? knownsForDepartment,
  }) = _Performer;

  factory Performer.fromJson(Json json) => _$PerformerFromJson(json);
}

List<Performer> getPerformerList(List<Json> list) {
  return list
      .where(
        (e) =>
            e['media_type'] == 'person' &&
            e['known_for_department'] == 'Acting' &&
            e['profile_path'] != null,
      )
      .map(
        (x) => Performer.fromJson(x),
      )
      .toList();
}
