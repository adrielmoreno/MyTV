class User {
  final Avatar? avatar;
  final int? id;
  final String? iso6391;
  final String? iso31661;
  final String? name;
  final bool? includeAdult;
  final String? username;

  User({
    this.avatar,
    this.id,
    this.iso6391,
    this.iso31661,
    this.name,
    this.includeAdult,
    this.username,
  });

  User copyWith({
    Avatar? avatar,
    int? id,
    String? iso6391,
    String? iso31661,
    String? name,
    bool? includeAdult,
    String? username,
  }) =>
      User(
        avatar: avatar ?? this.avatar,
        id: id ?? this.id,
        iso6391: iso6391 ?? this.iso6391,
        iso31661: iso31661 ?? this.iso31661,
        name: name ?? this.name,
        includeAdult: includeAdult ?? this.includeAdult,
        username: username ?? this.username,
      );

  factory User.fromJson(Map<String, dynamic> json) => User(
        avatar: json["avatar"] == null ? null : Avatar.fromJson(json["avatar"]),
        id: json["id"],
        iso6391: json["iso_639_1"],
        iso31661: json["iso_3166_1"],
        name: json["name"],
        includeAdult: json["include_adult"],
        username: json["username"],
      );

  Map<String, dynamic> toJson() => {
        "avatar": avatar?.toJson(),
        "id": id,
        "iso_639_1": iso6391,
        "iso_3166_1": iso31661,
        "name": name,
        "include_adult": includeAdult,
        "username": username,
      };
}

class Avatar {
  final Gravatar? gravatar;
  final Tmdb? tmdb;

  Avatar({
    this.gravatar,
    this.tmdb,
  });

  Avatar copyWith({
    Gravatar? gravatar,
    Tmdb? tmdb,
  }) =>
      Avatar(
        gravatar: gravatar ?? this.gravatar,
        tmdb: tmdb ?? this.tmdb,
      );

  factory Avatar.fromJson(Map<String, dynamic> json) => Avatar(
        gravatar: json["gravatar"] == null
            ? null
            : Gravatar.fromJson(json["gravatar"]),
        tmdb: json["tmdb"] == null ? null : Tmdb.fromJson(json["tmdb"]),
      );

  Map<String, dynamic> toJson() => {
        "gravatar": gravatar?.toJson(),
        "tmdb": tmdb?.toJson(),
      };
}

class Gravatar {
  final String? hash;

  Gravatar({
    this.hash,
  });

  Gravatar copyWith({
    String? hash,
  }) =>
      Gravatar(
        hash: hash ?? this.hash,
      );

  factory Gravatar.fromJson(Map<String, dynamic> json) => Gravatar(
        hash: json["hash"],
      );

  Map<String, dynamic> toJson() => {
        "hash": hash,
      };
}

class Tmdb {
  final String? avatarPath;

  Tmdb({
    this.avatarPath,
  });

  Tmdb copyWith({
    String? avatarPath,
  }) =>
      Tmdb(
        avatarPath: avatarPath ?? this.avatarPath,
      );

  factory Tmdb.fromJson(Map<String, dynamic> json) => Tmdb(
        avatarPath: json["avatar_path"],
      );

  Map<String, dynamic> toJson() => {
        "avatar_path": avatarPath,
      };
}
