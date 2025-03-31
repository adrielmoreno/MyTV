import 'package:freezed_annotation/freezed_annotation.dart';

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

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}

String? avatarPathFromJson(Map<String, dynamic> json) {
  return json['tmdb']?['avatar_path'] as String?;
}
