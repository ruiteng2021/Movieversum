// To parse this JSON data, do
//
//     final trendingData = trendingDataFromJson(jsonString);
import 'dart:convert';

TrendingData trendingDataFromJson(String str) =>
    TrendingData.fromJson(json.decode(str));

String trendingDataToJson(TrendingData data) => json.encode(data.toJson());

class TrendingData {
  TrendingData({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  int page;
  List<Trending> results;
  int totalPages;
  int totalResults;

  factory TrendingData.fromJson(Map<String, dynamic> json) => TrendingData(
        page: json["page"],
        results: List<Trending>.from(
            json["results"].map((x) => Trending.fromJson(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
      );

  Map<String, dynamic> toJson() => {
        "page": page,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
        "total_pages": totalPages,
        "total_results": totalResults,
      };
}

class Trending {
  Trending({
    required this.backdropPath,
    required this.firstAirDate,
    required this.genreIds,
    required this.originalLanguage,
    required this.originalName,
    required this.originCountry,
    required this.voteAverage,
    required this.id,
    required this.voteCount,
    required this.posterPath,
    required this.overview,
    required this.name,
    required this.popularity,
    required this.mediaType,
    required this.originalTitle,
    required this.video,
    required this.releaseDate,
    required this.title,
    required this.adult,
  });

  String backdropPath;
  String firstAirDate;
  List<int> genreIds;
  String originalLanguage;
  String originalName;
  List<dynamic> originCountry;
  double voteAverage;
  int id;
  int voteCount;
  String posterPath;
  String overview;
  String name;
  double popularity;
  String mediaType;
  String originalTitle;
  bool video;
  String releaseDate;
  String title;
  bool adult;

  factory Trending.fromJson(Map<String, dynamic> json) => Trending(
        backdropPath: json["backdrop_path"],
        firstAirDate:
            json["first_air_date"] == null ? null : json["first_air_date"],
        genreIds: List<int>.from(json["genre_ids"].map((x) => x)),
        originalLanguage: json["original_language"],
        originalName:
            json["original_name"] == null ? null : json["original_name"],
        originCountry: List<dynamic>.from(json["origin_country"].map((x) => x)),
        // originCountry: json["origin_country"] == null
        //     ? null
        //     : List<dynamic>.from(json["origin_country"].map((x) => x)),
        voteAverage: json["vote_average"].toDouble(),
        id: json["id"],
        voteCount: json["vote_count"],
        posterPath: json["poster_path"],
        overview: json["overview"],
        name: json["name"] == null ? null : json["name"],
        popularity: json["popularity"].toDouble(),
        mediaType: json["media_type"],
        originalTitle:
            json["original_title"] == null ? null : json["original_title"],
        video: json["video"] == null ? null : json["video"],
        releaseDate: json["release_date"] == null ? null : json["release_date"],
        title: json["title"] == null ? null : json["title"],
        adult: json["adult"] == null ? null : json["adult"],
      );

  Map<String, dynamic> toJson() => {
        "backdrop_path": backdropPath,
        "first_air_date": firstAirDate == null ? null : firstAirDate,
        "genre_ids": List<dynamic>.from(genreIds.map((x) => x)),
        "original_language": originalLanguage,
        "original_name": originalName == null ? null : originalName,
        "origin_country": originCountry == null
            ? null
            : List<dynamic>.from(originCountry.map((x) => x)),
        "vote_average": voteAverage,
        "id": id,
        "vote_count": voteCount,
        "poster_path": posterPath,
        "overview": overview,
        "name": name == null ? null : name,
        "popularity": popularity,
        "media_type": mediaType,
        "original_title": originalTitle == null ? null : originalTitle,
        "video": video == null ? null : video,
        "release_date": releaseDate == null ? null : releaseDate,
        "title": title == null ? null : title,
        "adult": adult == null ? null : adult,
      };
}
