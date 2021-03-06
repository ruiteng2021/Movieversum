import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movieversum/models/movie_data.dart';
import 'package:movieversum/views/movie_card.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class FindMovies extends StatefulWidget {
  final query;
  final List<Movie> movies;
  FindMovies(
    this.movies,
    this.query,
  );

  @override
  _FindMoviesState createState() => _FindMoviesState();
}

class _FindMoviesState extends State<FindMovies> {
  List<Movie> moviesWithPosters = [];
  // int currentPage = 1;

  // late int totalPages = 0;

  // List<Movie> movies = [];

  // final RefreshController refreshController =
  //     RefreshController(initialRefresh: true);

  @override
  void initState() {
    super.initState();
    moviesWithPosters = super.widget.movies;
    moviesWithPosters.removeWhere((item) => item.posterPath == null);
  }

  // Future<bool> getMovieData({bool isRefresh = false}) async {
  // print("currentPage: $currentPage");
  // print("totalPages: $totalPages");
  // print("isRefresh: $isRefresh");
  // if (isRefresh) {
  //   currentPage = 1;
  // } else {
  //   if (currentPage >= totalPages) {
  //     refreshController.loadNoData();
  //     return false;
  //   }
  // }

  // print("Movie type : ${super.widget.query}");
  // Uri uri = Uri.parse(
  //     "https://api.themoviedb.org/3/search/movie?api_key=d194eb72915bc79fac2eb1a70a71ddd3&language=en-US&page=$currentPage&query=${super.widget.query}");
  // // "https://api.themoviedb.org/3/movie/${super.widget.movieType}?api_key=d194eb72915bc79fac2eb1a70a71ddd3&language=en-US&page=$currentPage");

  // final response = await http.get(uri);

  // if (response.statusCode == 200) {
  //   print("Url: $uri");
  //   final result = movieDataFromJson(response.body);
  //   if (isRefresh) {
  //     movies = result.results;
  //   } else {
  //     // print(jsonEncode(result.results));
  //     movies.addAll(result.results);
  //     print("passengers Length: ");
  //     print(movies.length);
  //   }

  //   currentPage++;

  //   totalPages = result.totalPages;

  // if (this.mounted) {
  //   setState(() {
  //     // Your state change code goes here
  //   });
  // }
  // print(response.body);
  // setState(() {});
  //   return true;
  // } else {
  //   return false;
  // }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: GridView.builder(
        padding: EdgeInsets.all(20.0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount:
              MediaQuery.of(context).orientation == Orientation.portrait
                  ? 2
                  : 3,
          childAspectRatio:
              MediaQuery.of(context).orientation == Orientation.portrait
                  ? 0.8
                  : 0.9,
        ),
        itemBuilder: (context, index) {
          final movie = moviesWithPosters[index];
          return MovieCard(
            movie: movie,
          );
        },
        // separatorBuilder: (contex, indexc) => Divider(),
        itemCount: moviesWithPosters.length,
      ),
    );
  }
}
