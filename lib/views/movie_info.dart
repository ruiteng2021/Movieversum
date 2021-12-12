import 'package:flutter/material.dart';
import 'package:movieversum/models/movie_data.dart';

class MovieInfo extends StatefulWidget {
  final Movie movie;
  MovieInfo({
    required this.movie,
  });

  @override
  _MovieInfoState createState() => _MovieInfoState();
}

class _MovieInfoState extends State<MovieInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.white10,
            expandedHeight: 200,
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
                  print("XXXX");
                },
                child: Stack(
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image:
                              NetworkImage("https://image.tmdb.org/t/p/w500/" +
                                  // "https://image.tmdb.org/t/p/original/" +
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
                  ],
                ),
              ),
            ),
          ),
          buildImages(),
        ],
      ),
    );
  }

  Widget buildImages() => Container(
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
                        "Publish Date: " + super.widget.movie.releaseDate,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 5.0,
                      ),
                      // RatingBar(
                      //   itemSize: 10.0,
                      //   initialRating: movie.rating / 2,
                      //   ratingWidget: RatingWidget(
                      //     empty: Icon(
                      //       EvaIcons.star,
                      //       color: Style.Colors.secondColor,
                      //     ),
                      //     full: Icon(
                      //       EvaIcons.star,
                      //       color: Style.Colors.secondColor,
                      //     ),
                      //     half: Icon(
                      //       EvaIcons.star,
                      //       color: Style.Colors.secondColor,
                      //     ),
                      //   ),
                      //   minRating: 1,
                      //   direction: Axis.horizontal,
                      //   allowHalfRating: true,
                      //   itemCount: 5,
                      //   itemPadding: EdgeInsets.symmetric(horizontal: 2.0),
                      //   onRatingUpdate: (rating) {
                      //     print(rating);
                      //   },
                      // )
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
                // MovieInfo(
                //   id: movie.id,
                // ),
                // Casts(
                //   id: movie.id,
                // ),
                // SimilarMovies(id: movie.id)
              ],
            ),
          ),
        ),
      );
}
