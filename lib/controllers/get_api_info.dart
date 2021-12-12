import 'package:http/http.dart' as http;
import 'package:movieversum/models/movie_data.dart';

class GetApiInfo {
  Future<MovieData?> getMovieInfo(int id, int currentPage) async {
    MovieData result;
    Uri uri = Uri.parse(
        "https://api.themoviedb.org/3/movie/${id.toString()}?api_key=d194eb72915bc79fac2eb1a70a71ddd3&language=en-US&page=${currentPage.toString()}");
    try {
      final response = await http.get(uri);
      print("Url: $uri");
      result = movieDataFromJson(response.body);
      return result;
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return null;
    }
  }

  Future<MovieData?> getMovietrailer(int id) async {
    MovieData result;
    Uri uri = Uri.parse(
        "https://api.themoviedb.org/3/movie/${id.toString()}/videos?api_key=d194eb72915bc79fac2eb1a70a71ddd3&language=en-US");
    try {
      final response = await http.get(uri);
      print("Url: $uri");
      result = movieDataFromJson(response.body);
      return result;
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return null;
    }
  }
}
