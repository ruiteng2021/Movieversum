// ignore_for_file: unnecessary_null_comparison

import 'dart:convert';
import 'dart:core';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movieversum/models/credit_data.dart';
import 'package:movieversum/models/movie_data.dart';
import 'package:movieversum/controllers/get_api_info.dart';
import 'package:movieversum/models/similar_movies_data.dart';
import 'package:movieversum/views/widgets/credits.dart';
import 'package:movieversum/views/widgets/similar_movies.dart';
import 'package:movieversum/views/widgets/video_player.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class MovieInfo extends StatefulWidget {
  final Movie movie;
  MovieInfo({
    required this.movie,
  });

  @override
  _MovieInfoState createState() => _MovieInfoState();
}

class _MovieInfoState extends State<MovieInfo> {
  late GetApiInfo getApiInfo = new GetApiInfo();
  Map<String, String> dispayData = {};
  Map<String, dynamic> creditData = {};
  List<Cast> casts = [];
  List<Cast> crews = [];
  List<SimilarMovie> similarMovie = [];
  late String? trailer;
  @override
  void initState() {
    super.initState();
    getSingleMovieData(super.widget.movie.id);
    getCreditInfo(super.widget.movie.id);
    getSimilarMovies(super.widget.movie.id);
    getMovieTrailer(super.widget.movie.id);
  }

  void getSingleMovieData(int movieId) async {
    final result = await getApiInfo.getSingleMovieInfo(movieId);
    dispayData["homepage"] = result!.homepage;
    dispayData["release date"] = result.releaseDate!.year.toString() +
        '-' +
        result.releaseDate!.month.toString() +
        '-' +
        result.releaseDate!.day.toString();
    dispayData["revenue"] = result.revenue.toString();
    dispayData["runtime"] = result.runtime.toString();
    dispayData["id"] = result.id.toString();
    print(dispayData.toString());
    setState(() {
      // Your state change code goes here
    });
  }

  void getCreditInfo(int movieId) async {
    final result = await getApiInfo.getCreditInfo(movieId);
    casts = result!.cast!;
    crews = result.crew!;
    // remove duplicate name in crew list;
    final ids = crews.map((e) => e.name).toSet();
    crews.retainWhere((x) => ids.remove(x.name));
    // sort non null item to end of the list
    // crews.sort((a, b) => a.profilePath == null ? 1 : 0);
    crews.sort((a, b) => a.profilePath == null
        ? 1
        : b.profilePath == null
            ? -1
            : a.profilePath.compareTo(b.profilePath));
    // print("casts: ${jsonEncode(casts)}");
    // print("crews: ${jsonEncode(crews)}");
    setState(() {
      // Your state change code goes here
    });
  }

  void getSimilarMovies(int movieId) async {
    final result = await getApiInfo.GetSimilarMovies(movieId);
    similarMovie = result!.results!;
    setState(() {
      // Your state change code goes here
    });
  }

  void getMovieTrailer(int movieId) async {
    trailer = await getApiInfo.getMovieTrailer(movieId);
  }

  @override
  Widget build(BuildContext context) {
    print("Backdrop: ${super.widget.movie.backdropPath}");
    return Scaffold(
      backgroundColor: Colors.black,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.white10,
            expandedHeight: 300,
            floating: true,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                super.widget.movie.title.length > 40
                    ? super.widget.movie.title.substring(0, 37) + "..."
                    : super.widget.movie.title,
                style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.normal),
              ),
              background: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => VideoPlayerScreen(
                        controller: YoutubePlayerController(
                          initialVideoId: this.trailer!,
                          flags: YoutubePlayerFlags(
                            autoPlay: true,
                            mute: false,
                          ),
                        ),
                      ),
                    ),
                  );
                  // String? result =
                  //     await getApiInfo.getMovieTrailer(super.widget.movie.id);
                  // // print("XXXX: $result");
                  // final youtubeUrl = "https://www.youtube.com/embed/${result}";
                  // if (await canLaunch(youtubeUrl)) {
                  //   await launch(youtubeUrl);
                  // }
                },
                child: Stack(
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: super.widget.movie.backdropPath == null
                              ? NetworkImage("https://via.placeholder.com/500")
                              : NetworkImage(
                                  "https://image.tmdb.org/t/p/w500/" +
                                      super.widget.movie.backdropPath),
                        ),
                      ),
                      child: Container(
                        decoration:
                            BoxDecoration(color: Colors.black.withOpacity(0.1)),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            stops: [
                              0.1,
                              0.9
                            ],
                            colors: [
                              Colors.black.withOpacity(0.9),
                              Colors.black.withOpacity(0.0)
                            ]),
                      ),
                    ),
                    Positioned(
                      bottom: 0.0,
                      // top: 0.0,
                      // left: 0.0,
                      right: 0.0,
                      child: Icon(
                        FontAwesomeIcons.playCircle,
                        color: Colors.white30,
                        size: 40.0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          buildContens(),
        ],
      ),
    );
  }

  Widget buildContens() => Container(
        child: SliverPadding(
          padding: EdgeInsets.all(0.0),
          sliver: SliverList(
            delegate: SliverChildListDelegate(
              [
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, top: 20.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Average Rating: ${super.widget.movie.voteAverage.toString()}",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 5.0,
                      ),
                      RatingBar(
                        itemSize: 10.0,
                        initialRating: super.widget.movie.voteAverage,
                        ratingWidget: RatingWidget(
                          empty: Icon(
                            EvaIcons.star,
                            color: Color(0xFFf4C10F),
                          ),
                          full: Icon(
                            EvaIcons.star,
                            color: Color(0xFFf4C10F),
                          ),
                          half: Icon(
                            EvaIcons.star,
                            color: Color(0xFFf4C10F),
                          ),
                        ),
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemPadding: EdgeInsets.symmetric(horizontal: 2.0),
                        onRatingUpdate: (rating) {
                          print(rating);
                        },
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, top: 20.0),
                  child: Text(
                    "OVERVIEW",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 12.0),
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 10.0),
                  child: Text(
                    super.widget.movie.overview,
                    style: TextStyle(
                        color: Colors.white, fontSize: 12.0, height: 1.5),
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          'Release Date',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          'Revenue',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          'Run Time',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          this.dispayData["release date"].toString(),
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          '\$${this.dispayData["revenue"].toString()}',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          this.dispayData["runtime"].toString(),
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(12.0, 8.0, 12.0, 8.0),
                  child: Text(
                    "CASTS",
                    style: TextStyle(
                        color: Colors.white70,
                        fontWeight: FontWeight.w500,
                        fontSize: 12.0),
                  ),
                ),
                Credits(
                  credits: casts,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(12.0, 8.0, 12.0, 8.0),
                  child: Text(
                    "CREWS",
                    style: TextStyle(
                        color: Colors.white70,
                        fontWeight: FontWeight.w500,
                        fontSize: 12.0),
                  ),
                ),
                Credits(
                  credits: crews,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(12.0, 8.0, 12.0, 8.0),
                  child: Text(
                    "SIMILAR MOVIES",
                    style: TextStyle(
                        color: Colors.white70,
                        fontWeight: FontWeight.w500,
                        fontSize: 12.0),
                  ),
                ),
                SimilarMovies(similarMovies: this.similarMovie),
              ],
            ),
          ),
        ),
      );
}
