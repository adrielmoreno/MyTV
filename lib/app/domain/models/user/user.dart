import 'package:freezed_annotation/freezed_annotation.dart';

import '../../typedefs.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
abstract class User with _$User {
  const factory User({
    final int? id,
    final String? iso6391,
    final String? iso31661,
    final String? name,
    final bool? includeAdult,
    final String? username,
    // Custom key
    @JsonKey(name: 'avatar', fromJson: avatarPathFromJson)
    final String? avatarPath,
  }) = _User;

  factory User.fromJson(Json json) => _$UserFromJson(json);
}

String? avatarPathFromJson(Json json) {
  return json['tmdb']?['avatar_path'] as String?;
}
