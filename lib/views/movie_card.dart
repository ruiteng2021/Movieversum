import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movieversum/models/movie_data.dart';
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
        // Navigator.of(context).push(MaterialPageRoute(
        //     builder: (context) => VendorProduct(
        //           vendorSlug: vendor.slug,
        //           vendorImagePath: vendor.logoUrl,
        //           vendorDescription: vendor.description ?? "",
        //           vendorName: vendor.name,
        //           featured: vendor.isFeatured,
        //         )));
      },
      child: ClipRRect(
        child: CachedNetworkImage(
          imageUrl: 'https://image.tmdb.org/t/p/original/${movie.backdropPath}',
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
                image: AssetImage('assets/images/img_not_found.jpg'),
              ),
            ),
          ),
        ),
      ),
      // child: Container(
      //   decoration: BoxDecoration(
      //       borderRadius: BorderRadius.circular(15.0),
      //       boxShadow: [
      //         BoxShadow(
      //             color: Colors.grey.withOpacity(0.2),
      //             spreadRadius: 3.0,
      //             blurRadius: 5.0)
      //       ],
      //       color: Colors.white),
      //   child: Column(
      //     children: [
      //       Padding(
      //           padding: EdgeInsets.all(5.0),
      //           child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
      //             movie.voteCount > 0
      //                 ? Icon(Icons.favorite, color: Color(0xFFEF7532))
      //                 : Icon(Icons.favorite_border, color: Color(0xFFEF7532))
      //           ])),
      //       Hero(
      //         tag: movie.id,
      //         child: Container(
      //           height: 120.0,
      //           width: 80.0,
      //           decoration: BoxDecoration(
      //             image: DecorationImage(
      //               image: NetworkImage("https://image.tmdb.org/t/p/w500/" +
      //                   movie.backdropPath),
      //               fit: BoxFit.cover,
      //             ),
      //           ),
      //         ),
      //       ),
      //       SizedBox(height: 2.0),
      //       Padding(
      //         padding: const EdgeInsets.all(10.0),
      //         child: Text(
      //           movie.title,
      //           style: TextStyle(
      //             color: Color(0xFF575E67),
      //             fontFamily: 'Varela',
      //             fontSize: 14.0,
      //           ),
      //           textAlign: TextAlign.center,
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
    ),
  );
}
