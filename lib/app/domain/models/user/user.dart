import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User extends Equatable {
  final int? id;
  final String? iso6391;
  final String? iso31661;
  final String? name;
  final bool? includeAdult;
  final String? username;

  @JsonKey(name: 'avatar', fromJson: avatarPathFromJson)
  final String? avatarPath;

  const User({
    this.id,
    this.iso6391,
    this.iso31661,
    this.name,
    this.includeAdult,
    this.username,
    this.avatarPath,
  });

  User copyWith({
    int? id,
    String? iso6391,
    String? iso31661,
    String? name,
    bool? includeAdult,
    String? username,
  }) =>
      User(
        id: id ?? this.id,
        iso6391: iso6391 ?? this.iso6391,
        iso31661: iso31661 ?? this.iso31661,
        name: name ?? this.name,
        includeAdult: includeAdult ?? this.includeAdult,
        username: username ?? this.username,
      );

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);

  @override
  List<Object?> get props => [
        id,
        iso6391,
        iso31661,
        name,
        includeAdult,
        username,
      ];
}

String? avatarPathFromJson(Map<String, dynamic> json) {
  return json['tmdb']?['avatar_path'] as String?;
}
