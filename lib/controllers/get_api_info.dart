import 'dart:ffi';

import 'package:http/http.dart' as http;
import 'package:movieversum/models/credit_data.dart';
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
}
