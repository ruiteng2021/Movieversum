// To parse this JSON data, do
//
//     final trailerData = trailerDataFromJson(jsonString);

import 'dart:convert';

TrailerData trailerDataFromJson(String str) =>
    TrailerData.fromJson(json.decode(str));

String trailerDataToJson(TrailerData data) => json.encode(data.toJson());

class TrailerData {
  TrailerData({
    required this.id,
    required this.results,
  });

  int id;
  List<Trailer>? results;

  factory TrailerData.fromJson(Map<String, dynamic> json) => TrailerData(
        id: json["id"] == null ? null : json["id"],
        results: json["results"] == null
            ? null
            : List<Trailer>.from(
                json["results"].map((x) => Trailer.fromJson(x))),
        // results: List<Trailer>.from(json["results"].map((x) => Trailer.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "results": results == null
            ? null
            : List<dynamic>.from(results!.map((x) => x.toJson())),
      };
}

class Trailer {
  Trailer({
    required this.iso6391,
    required this.iso31661,
    required this.name,
    required this.key,
    required this.site,
    required this.size,
    required this.type,
    required this.official,
    required this.publishedAt,
    required this.id,
  });

  String iso6391;
  String iso31661;
  String name;
  String key;
  String site;
  int size;
  String type;
  bool official;
  String publishedAt;
  String id;

  factory Trailer.fromJson(Map<String, dynamic> json) => Trailer(
        iso6391: json["iso_639_1"] == null ? null : json["iso_639_1"],
        iso31661: json["iso_3166_1"] == null ? null : json["iso_3166_1"],
        name: json["name"] == null ? null : json["name"],
        key: json["key"] == null ? null : json["key"],
        site: json["site"] == null ? null : json["site"],
        size: json["size"] == null ? null : json["size"],
        type: json["type"] == null ? null : json["type"],
        official: json["official"] == null ? null : json["official"],
        publishedAt: json["published_at"] == null ? null : json["published_at"],
        id: json["id"] == null ? null : json["id"],
      );

  Map<String, dynamic> toJson() => {
        "iso_639_1": iso6391 == null ? null : iso6391,
        "iso_3166_1": iso31661 == null ? null : iso31661,
        "name": name == null ? null : name,
        "key": key == null ? null : key,
        "site": site == null ? null : site,
        "size": size == null ? null : size,
        "type": type == null ? null : type,
        "official": official == null ? null : official,
        "published_at": publishedAt == null ? null : publishedAt,
        "id": id == null ? null : id,
      };
}
