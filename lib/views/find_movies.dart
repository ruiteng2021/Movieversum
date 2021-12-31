import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movieversum/controllers/get_api_info.dart';
import 'package:movieversum/models/movie_data.dart';
import 'package:movieversum/views/movie_card.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class FindMovies3 extends StatefulWidget {
  final query;
  final List<Movie> movies;
  FindMovies3(
    this.movies,
    this.query,
  );

  @override
  _FindMovies3State createState() => _FindMovies3State();
}

class _FindMovies3State extends State<FindMovies3> {
  List<Movie> moviesWithPosters = [];
  int currentPage = 1;

  late int totalPages = 0;

  List<Movie> movies = [];

  final RefreshController refreshController =
      RefreshController(initialRefresh: true);

  @override
  void initState() {
    super.initState();
    moviesWithPosters = super.widget.movies;
    moviesWithPosters.removeWhere((item) => item.posterPath == null);
  }

  Future<bool> getMovieData({bool isRefresh = false}) async {
    print("currentPage: $currentPage");
    print("totalPages: $totalPages");
    print("isRefresh: $isRefresh");
    if (isRefresh) {
      currentPage = 1;
    } else {
      if (currentPage > totalPages) {
        refreshController.loadNoData();
        return true;
      }
    }

    print("Search key find_movies: ${super.widget.query}");
    var total = {"totalPages": 0};
    movies = (await GetApiInfo.FindRepeatSearchedMovies(
        movies, isRefresh, currentPage, super.widget.query, total))!;
    if (movies.length > 0) {
      currentPage++;
      totalPages = total["totalPages"]!.toInt();

      if (this.mounted) {
        setState(() {
          // Your state change code goes here
        });
      }
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SmartRefresher(
        controller: refreshController,
        enablePullUp: true,
        onRefresh: () async {
          final result = await getMovieData(isRefresh: true);
          if (result) {
            refreshController.refreshCompleted();
          } else {
            refreshController.refreshFailed();
          }
        },
        onLoading: () async {
          final result = await getMovieData();
          if (result) {
            refreshController.loadComplete();
          } else {
            refreshController.loadFailed();
          }
        },
        header: WaterDropMaterialHeader(),
        footer: ClassicFooter(
          loadStyle: LoadStyle.HideAlways,
        ),
        physics: BouncingScrollPhysics(),
        child: GridView.builder(
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
            final movie = movies[index];
            return MovieCard(
              movie: movie,
            );
          },
          // separatorBuilder: (contex, indexc) => Divider(),
          itemCount: movies.length,
        ),
      ),
    );
  }
}
