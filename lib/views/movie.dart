import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movieversum/models/movie_data.dart';
import 'package:movieversum/views/movie_card.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class Movies extends StatefulWidget {
  final movieType;
  Movies({
    this.movieType,
  });
  @override
  _MoviesState createState() => _MoviesState();
}

class _MoviesState extends State<Movies> {
  String selection = 'dispensaries';
  Map selectedCity = {
    'city': 'London',
    'city_slug': 'london',
    'state': 'ON',
    'country': 'Canada',
  };
  int currentPage = 1;

  late int totalPages = 0;

  List<Movie> movies = [];

  final RefreshController refreshController =
      RefreshController(initialRefresh: true);

  @override
  void initState() {
    super.initState();
    // selection = super.widget.selection;
    // selectedCity = super.widget.selectedCity;
    // print(selectedCity['city']);
  }

  Future<bool> getMovieData({bool isRefresh = false}) async {
    print("currentPage: $currentPage");
    print("totalPages: $totalPages");
    print("isRefresh: $isRefresh");
    if (isRefresh) {
      currentPage = 1;
    } else {
      if (currentPage >= totalPages) {
        refreshController.loadNoData();
        return false;
      }
    }

    print("Movie type : ${super.widget.movieType}");
    Uri uri = Uri.parse(
        "https://api.themoviedb.org/3/movie/${super.widget.movieType}?api_key=d194eb72915bc79fac2eb1a70a71ddd3&language=en-US&page=$currentPage");

    // if (super.widget.movieType.compareTo('trending') == 0) {
    //   print("selection : ${super.widget.movieType}");
    //   uri = Uri.parse(
    //       "https://api.themoviedb.org/3/${super.widget.movieType}/all/day?api_key=d194eb72915bc79fac2eb1a70a71ddd3&language=en-US&page=$currentPage");
    // }

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      print("Url: $uri");
      final result = movieDataFromJson(response.body);

      if (isRefresh) {
        movies = result.results;
      } else {
        // print(jsonEncode(result.data));
        movies.addAll(result.results);
        print("passengers Length: ");
        print(movies.length);
      }

      // print("passengers: ");
      // print(jsonEncode(result.data));

      currentPage++;

      totalPages = result.totalPages;

      if (this.mounted) {
        setState(() {
          // Your state change code goes here
        });
      }
      // print(response.body);
      // setState(() {});
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      // appBar: AppBar(
      //   title: Text("Vendors near your location"),
      // ),
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
