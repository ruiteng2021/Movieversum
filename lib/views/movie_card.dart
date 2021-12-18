import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movieversum/models/movie_data.dart';
import 'package:movieversum/views/movie_info.dart';
// import 'package:MovieCard/views/vendor_product.dart';

class MovieCard extends StatelessWidget {
  final Movie movie;
  MovieCard({
    required this.movie,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      // width: MediaQuery.of(context).size.width - 30.0,
      // height: MediaQuery.of(context).size.height - 20.0,

      child: _buildCard(movie, context),
    );
  }
}

Widget _buildCard(Movie movie, context) {
  return Padding(
    padding: EdgeInsets.only(top: 5.0, bottom: 5.0, left: 5.0, right: 5.0),
    child: InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => MovieInfo(movie: movie),
          ),
        );
      },
      child: ClipRRect(
        child: CachedNetworkImage(
          imageUrl: 'https://image.tmdb.org/t/p/original/${movie.posterPath}',
          imageBuilder: (context, imageProvider) {
            return Container(
              width: 180,
              height: 250,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(12),
                ),
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.cover,
                ),
              ),
            );
          },
          placeholder: (context, url) => Container(
            width: 180,
            height: 250,
            child: Center(
              child: Platform.isAndroid
                  ? CircularProgressIndicator()
                  : CupertinoActivityIndicator(),
            ),
          ),
          errorWidget: (context, url, error) => Container(
            width: 180,
            height: 250,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/img_not_found.png'),
              ),
            ),
          ),
        ),
      ),
    ),
  );
}
