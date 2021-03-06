import 'dart:ffi';

import 'package:http/http.dart' as http;
import 'package:movieversum/models/actor_data.dart';
import 'package:movieversum/models/actor_images.dart';
import 'package:movieversum/models/credit_data.dart';
import 'package:movieversum/models/movie_data.dart';
import 'package:movieversum/models/similar_movies_data.dart';
// import 'package:movieversum/models/movie_data.dart';
import 'package:movieversum/models/single_movie_data.dart';
import 'package:movieversum/models/trailer_data.dart';

final String baseString =
    "api_key=d194eb72915bc79fac2eb1a70a71ddd3&language=en-US";

class GetApiInfo {
  Future<SingleMovieData?> getSingleMovieInfo(int id) async {
    Uri uri = Uri.parse(
        "https://api.themoviedb.org/3/movie/${id.toString()}?${baseString}");
    try {
      final response = await http.get(uri);
      print("Url: $uri");
      SingleMovieData result = singleMovieDataFromJson(response.body);
      return result;
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return null;
    }
  }

  Future<String?> getMovieTrailer(int id) async {
    List<Trailer> trailers = [];
    Uri uri = Uri.parse(
        "https://api.themoviedb.org/3/movie/${id.toString()}/videos?${baseString}");
    try {
      final response = await http.get(uri);
      print("Url: $uri");
      final result = trailerDataFromJson(response.body);
      trailers = result.results!;

      for (Trailer trailer in trailers) {
        if (trailer.key != null) return trailer.key;
      }
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return null;
    }
  }

  Future<CreditData?> getCreditInfo(int id) async {
    Uri uri = Uri.parse(
        "https://api.themoviedb.org/3/movie/${id.toString()}/credits?${baseString}");
    try {
      final response = await http.get(uri);
      print("Url: $uri");
      CreditData result = creditDataFromJson(response.body);
      return result;
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return null;
    }
  }

  Future<ActorData?> GetActorDetails(int id) async {
    Uri uri = Uri.parse(
        "https://api.themoviedb.org/3/person/${id.toString()}?${baseString}");
    try {
      final response = await http.get(uri);
      print("Url: $uri");
      ActorData result = actorDataFromJson(response.body);
      return result;
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return null;
    }
  }

  Future<ActorImages?> GetActorImages(int id) async {
    Uri uri = Uri.parse(
        "https://api.themoviedb.org/3/person/${id.toString()}/images?${baseString}");
    try {
      final response = await http.get(uri);
      print("Url: $uri");
      ActorImages result = actorImagesFromJson(response.body);
      return result;
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return null;
    }
  }

  Future<SimilarMovieData?> GetSimilarMovies(int id) async {
    Uri uri = Uri.parse(
        "https://api.themoviedb.org/3/movie/${id.toString()}/similar?${baseString}&page=1");
    try {
      final response = await http.get(uri);
      print("Url: $uri");
      SimilarMovieData result = similarMovieDataFromJson(response.body);
      return result;
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return null;
    }
  }

  Future<MovieData?> GetMoviesByActor(int castId) async {
    Uri uri = Uri.parse(
        "https://api.themoviedb.org/3/discover/movie?${baseString}&page=1&with_cast=${castId}");
    try {
      final response = await http.get(uri);
      print("Url: $uri");
      MovieData result = movieDataFromJson(response.body);
      return result;
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return null;
    }
  }

  static Future<List<Movie>?> FindSearchMovies(String search) async {
    Uri uri = Uri.parse(
        "https://api.themoviedb.org/3/search/movie?$baseString&page=1&query=$search");
    try {
      final response = await http.get(uri);
      print("Url: $uri");
      MovieData result = movieDataFromJson(response.body);
      return result.results;
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return null;
    }
  }

  static Future<List<Movie>?> FindRepeatSearchedMovies(List<Movie> movies,
      bool isRefresh, int currentPage, String query, total) async {
    // List<Movie> movies = [];
    Uri uri = Uri.parse(
        "https://api.themoviedb.org/3/search/movie?$baseString&language=en-US&page=$currentPage&query=${query}");

    try {
      final response = await http.get(uri);
      print("Url: $uri");
      MovieData result = movieDataFromJson(response.body);
      if (isRefresh) {
        movies = result.results;
      } else {
        // print(jsonEncode(result.results));
        movies.addAll(result.results);
        movies.removeWhere((item) => item.posterPath == null);
        // print(movies.length);
      }
      total["totalPages"] = result.totalPages;
      return movies;
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return null;
    }
  }
}
