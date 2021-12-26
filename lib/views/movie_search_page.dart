import 'package:flutter/material.dart';
import 'package:movieversum/controllers/get_api_info.dart';
import 'package:movieversum/models/movie_data.dart';
import 'package:movieversum/views/find_movies.dart';
import 'package:movieversum/views/find_movies2.dart';

class MovieSearchPage extends SearchDelegate<String> {
  var result;

  @override
  ThemeData appBarTheme(BuildContext context) {
    ThemeData theme = Theme.of(context);
    // final ColorScheme colorScheme = theme.colorScheme;
    return theme.copyWith(
      appBarTheme: AppBarTheme(
        color: Colors.black,
        // backgroundColor: Colors.transparent,
        iconTheme: theme.primaryIconTheme.copyWith(color: Colors.white),
      ),
      inputDecorationTheme: searchFieldDecorationTheme ??
          InputDecorationTheme(
            hintStyle: TextStyle(color: Colors.white),
            // hintStyle: searchFieldStyle ?? theme.inputDecorationTheme.hintStyle,
            // border: InputBorder.none,
          ),
      textTheme: TextTheme(
        subtitle1: TextStyle(
          color: Colors.white,
          fontSize: 25.0,
          // decoration: TextDecoration.none,
          // decorationStyle: TextDecorationStyle.wavy,
          // decorationColor: Colors.red,
          // decorationThickness: 0.5,
        ),
      ),
    );
    // return themeData;
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    // ThemeData themeData = Theme.of(context);
    return [
      IconButton(
          icon: Icon(
            Icons.clear,
            color: Colors.white,
            // color: themeData.iconTheme.color,
          ),
          onPressed: () {
            query = '';
          }),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // ThemeData themeData = Theme.of(context);

    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
        color: Colors.white,
        // color: themeData.iconTheme.color,
      ),
      onPressed: () {
        close(context, " ");
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    ThemeData themeData = Theme.of(context);

    if (result != null && result.isNotEmpty) {
      // return VerticalMovieList(result, 'search');
    }

    return Container(
        decoration: new BoxDecoration(
          color: Colors.black,
        ),
        child: FutureBuilder(
          future: GetApiInfo.FindSearchMovies(query),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              Object? movies = snapshot.data;

              result = movies;

              if (movies == null) {
                return Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.block,
                      size: 55,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                        "Translations.of(context).trans(transKeyNotFoundMovieMessage)",
                        style: themeData.textTheme.bodyText1)
                  ],
                ));
              }
              return FindMovies2(result, query);
              // return Container();
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ));
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    ThemeData themeData = Theme.of(context);

    result = null;

    return Container(
      color: Colors.black,
      child: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.search,
            size: 55,
          ),
          SizedBox(
            height: 10,
          ),
          Text("Translations.of(context).trans(transKeySearchMovieMessage)",
              style: themeData.textTheme.bodyText1)
        ],
      )),
    );
  }
}
