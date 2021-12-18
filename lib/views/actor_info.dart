import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movieversum/controllers/get_api_info.dart';
import 'package:movieversum/models/actor_images.dart';
import 'package:movieversum/models/movie_data.dart';
import 'package:movieversum/views/movie_info.dart';

class ActorInfo extends StatefulWidget {
  const ActorInfo({Key? key, required this.id}) : super(key: key);
  final int id;

  @override
  _ActorInfoState createState() => _ActorInfoState();
}

class _ActorInfoState extends State<ActorInfo> {
  late GetApiInfo getApiInfo = new GetApiInfo();
  Map<String, String> dispayData = {};
  List<Profile> profiles = [];
  List<Movie> movies = [];
  MovieData movieData =
      new MovieData(page: 0, results: [], totalPages: 0, totalResults: 0);

  @override
  void initState() {
    super.initState();
    getActorInfo(super.widget.id);
    getActorImages(super.widget.id);
    getMoviesByActor(super.widget.id);
  }

  void getActorInfo(int castId) async {
    final result = await getApiInfo.GetActorDetails(super.widget.id);
    dispayData["biography"] = result!.biography;
    dispayData["birthday"] = result.birthday!.year.toString() +
        "-" +
        result.birthday!.month.toString() +
        "-" +
        result.birthday!.day.toString();
    dispayData["homepage"] = result.homepage;
    dispayData["imdb_id"] = result.imdbId;
    dispayData["known_for_department"] = result.knownForDepartment;
    dispayData["place_of_birth"] = result.placeOfBirth;
    dispayData["popularity"] = result.popularity.toString();
    dispayData["profile_path"] = result.profilePath;
    dispayData["also_known_as"] = result.alsoKnownAs!.join(",");
    dispayData["id"] = result.id.toString();
    dispayData["name"] = result.name.toString();
    switch (result.gender) {
      case 1:
        dispayData["gender"] = "Female";
        break;
      case 2:
        dispayData["gender"] = "Male";
        break;
      default:
        dispayData["gender"] = "Not Specified";
    }
    if (this.mounted) {
      setState(() {
        // Your state change code goes here
      });
    }
  }

  void getActorImages(int castId) async {
    final result = await getApiInfo.GetActorImages(super.widget.id);
    profiles = result!.profiles!;
    if (this.mounted) {
      setState(() {
        // Your state change code goes here
      });
    }
  }

  void getMoviesByActor(int castId) async {
    final result = await getApiInfo.GetMoviesByActor(castId);
    movies = result!.results;
    movieData = result;
    if (this.mounted) {
      setState(() {
        // Your state change code goes here
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: this.dispayData["profile_path"] == null
            ? DecorationImage(
                image: AssetImage("assets/images/img_not_found.png"),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  Colors.white.withOpacity(0.6),
                  BlendMode.srcOver,
                ),
              )
            : DecorationImage(
                image: NetworkImage(
                    'https://image.tmdb.org/t/p/w500/${this.dispayData["profile_path"]}'),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  Colors.grey.withOpacity(0.8),
                  BlendMode.srcOver,
                ),
              ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          toolbarHeight: 50.0,
          // title: Text("Title"),
        ),
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 50.0),
              child: Column(
                children: <Widget>[
                  this.dispayData["profile_path"] == null
                      ? Hero(
                          tag: this.dispayData["id"].toString(),
                          child: Container(
                            width: 150.0,
                            height: 150.0,
                            decoration: new BoxDecoration(
                                shape: BoxShape.circle, color: Colors.white70),
                            child: Icon(
                              FontAwesomeIcons.userAlt,
                              color: Colors.brown,
                            ),
                          ),
                        )
                      : Hero(
                          tag: this.dispayData["id"].toString(),
                          child: Container(
                            width: 150.0,
                            height: 150.0,
                            decoration: new BoxDecoration(
                              shape: BoxShape.circle,
                              image: new DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                    'https://image.tmdb.org/t/p/w500/${this.dispayData["profile_path"]}'),
                              ),
                            ),
                          ),
                        ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    this.dispayData["name"].toString(),
                    maxLines: 2,
                    style: TextStyle(
                        height: 1.4,
                        color: Colors.black,
                        fontWeight: FontWeight.w900,
                        fontSize: 10.0),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0, top: 20.0),
              child: Text(
                "BIOGRAHPY",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 20.0),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0, top: 5.0),
              child: Text(
                this.dispayData["biography"].toString(),
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 12.0),
              ),
            ),
            SizedBox(
              height: 5.0,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0, top: 20.0),
              child: Text(
                "PERSONAL INFO",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 20.0),
              ),
            ),
            SizedBox(
              height: 5.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Expanded(
                    child: Text(
                      'Known For',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w900,
                        fontSize: 10,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      'Gender',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w900,
                        fontSize: 10,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      'Birthday',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w900,
                        fontSize: 10,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      'Place of Birth',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w900,
                        fontSize: 10,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 2.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Expanded(
                    child: Text(
                      dispayData["known_for_department"].toString(),
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w900,
                        fontSize: 10,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      dispayData["gender"].toString(),
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w900,
                        fontSize: 10,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      dispayData["birthday"].toString(),
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w900,
                        fontSize: 10,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      dispayData["place_of_birth"].toString(),
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w900,
                        fontSize: 10,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 5.0,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0, top: 5.0),
              child: Text(
                "Also Known As : ${dispayData["also_known_as"].toString()}",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w900,
                    fontSize: 10.0),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0, top: 20.0),
              child: Text(
                "PHOTO GALLERY",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 20.0),
              ),
            ),
            Container(
              height: 200.0,
              padding: EdgeInsets.only(left: 10.0),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: profiles.length,
                itemBuilder: (context, index) {
                  final profile = profiles[index];
                  return Container(
                    padding:
                        EdgeInsets.only(top: 10.0, bottom: 10.0, right: 15.0),
                    child: GestureDetector(
                      onTap: () {
                        // Navigator.of(context).push(
                        //   MaterialPageRoute(
                        //     builder: (context) =>
                        //         ActorInfo(id: super.widget.credits[index].id),
                        //   ),
                        // );
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Hero(
                            tag: profile.filePath,
                            child: Container(
                              width: 120.0,
                              height: 180.0,
                              decoration: new BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12.0)),
                                shape: BoxShape.rectangle,
                                image: new DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(
                                        "https://image.tmdb.org/t/p/w200/" +
                                            profile.filePath)),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0, top: 20.0),
              child: Text(
                "MOVIES ABOUT ACTOR",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 20.0),
              ),
            ),
            _buildMovieCard(movieData, context),
          ],
        ),
      ),
    );
  }
}

Widget _buildMovieCard(MovieData movies, context) {
  return Container(
    height: 200.0,
    padding: EdgeInsets.only(left: 10.0),
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: movies.results.length,
      itemBuilder: (context, index) {
        final movie = movies.results[index];
        return Container(
          padding: EdgeInsets.only(top: 10.0, bottom: 10.0, right: 15.0),
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => MovieInfo(movie: movie),
                ),
              );
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Hero(
                  tag: movie.id,
                  child: Container(
                    width: 120.0,
                    height: 180.0,
                    decoration: new BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(12.0)),
                      shape: BoxShape.rectangle,
                      image: movie.posterPath == null
                          ? DecorationImage(
                              image:
                                  AssetImage("assets/images/img_not_found.png"),
                              fit: BoxFit.cover,
                            )
                          : DecorationImage(
                              image: NetworkImage(
                                  'https://image.tmdb.org/t/p/w200/${movie.posterPath}'),
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    ),
  );
}
