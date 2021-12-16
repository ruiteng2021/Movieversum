import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movieversum/controllers/get_api_info.dart';

class ActorInfo extends StatefulWidget {
  const ActorInfo({Key? key, required this.id}) : super(key: key);
  final int id;

  @override
  _ActorInfoState createState() => _ActorInfoState();
}

class _ActorInfoState extends State<ActorInfo> {
  late GetApiInfo getApiInfo = new GetApiInfo();
  Map<String, String> dispayData = {};

  @override
  void initState() {
    super.initState();
    getActorInfo(super.widget.id);
  }

  void getActorInfo(int castId) async {
    final result = await getApiInfo.GetActorDetails(super.widget.id);
    dispayData["biography"] = result!.biography;
    dispayData["birthday"] = result.birthday.toString();
    dispayData["homepage"] = result.homepage;
    dispayData["imdb_id"] = result.imdbId;
    dispayData["known_for_department"] = result.knownForDepartment;
    dispayData["place_of_birth"] = result.placeOfBirth;
    dispayData["popularity"] = result.popularity.toString();
    dispayData["profile_path"] = result.profilePath;
    dispayData["also_known_as"] = result.alsoKnownAs.toString();
    dispayData["id"] = result.id.toString();
    dispayData["name"] = result.name.toString();
    setState(() {
      // Your state change code goes here
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              // shape: BoxShape.rectangle,
              image: this.dispayData["profile_path"] == null
                  ? DecorationImage(
                      image: AssetImage(
                          "assets/images/defaultBackgroundImage.jpg"),
                      fit: BoxFit.cover,
                    )
                  : DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                          'https://image.tmdb.org/t/p/w500/${this.dispayData["profile_path"]}'),
                    ),
            ),
            child: Container(
              decoration: BoxDecoration(color: Colors.black.withOpacity(0.7)),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 50.0),
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.center,
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
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 9.0),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 10.0,
            child: Padding(
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
                        fontSize: 10,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      'Revenue',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      'Run Time',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
