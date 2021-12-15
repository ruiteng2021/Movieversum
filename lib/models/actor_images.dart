// To parse this JSON data, do
//
//     final actorImages = actorImagesFromJson(jsonString);

import 'dart:convert';

ActorImages actorImagesFromJson(String str) =>
    ActorImages.fromJson(json.decode(str));

String actorImagesToJson(ActorImages data) => json.encode(data.toJson());

class ActorImages {
  ActorImages({
    required this.id,
    required this.profiles,
  });

  int id;
  List<Profile>? profiles;

  factory ActorImages.fromJson(Map<String, dynamic> json) => ActorImages(
        id: json["id"] == null ? null : json["id"],
        profiles: json["profiles"] == null
            ? null
            : List<Profile>.from(
                json["profiles"].map((x) => Profile.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "profiles": profiles == null
            ? null
            : List<dynamic>.from(profiles!.map((x) => x.toJson())),
      };
}

class Profile {
  Profile({
    required this.aspectRatio,
    required this.height,
    required this.iso6391,
    required this.filePath,
    required this.voteAverage,
    required this.voteCount,
    required this.width,
  });

  double aspectRatio;
  int height;
  dynamic iso6391;
  String filePath;
  double voteAverage;
  int voteCount;
  int width;

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
        aspectRatio: json["aspect_ratio"] == null
            ? null
            : json["aspect_ratio"].toDouble(),
        height: json["height"] == null ? null : json["height"],
        iso6391: json["iso_639_1"],
        filePath: json["file_path"] == null ? null : json["file_path"],
        voteAverage: json["vote_average"] == null
            ? null
            : json["vote_average"].toDouble(),
        voteCount: json["vote_count"] == null ? null : json["vote_count"],
        width: json["width"] == null ? null : json["width"],
      );

  Map<String, dynamic> toJson() => {
        "aspect_ratio": aspectRatio == null ? null : aspectRatio,
        "height": height == null ? null : height,
        "iso_639_1": iso6391,
        "file_path": filePath == null ? null : filePath,
        "vote_average": voteAverage == null ? null : voteAverage,
        "vote_count": voteCount == null ? null : voteCount,
        "width": width == null ? null : width,
      };
}
