import 'package:flutter/material.dart';
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
    setState(() {
      // Your state change code goes here
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        // colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.2), BlendMode.dstATop),
        image: this.dispayData["profile_path"] == null
            ? DecorationImage(
                image: AssetImage("assets/images/defaultBackgroundImage.jpg"),
                fit: BoxFit.cover,
              )
            : DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(
                    'https://image.tmdb.org/t/p/w500/${this.dispayData["profile_path"]}'),
              ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
            // child: Card(
            //   elevation: 10,
            //   color: Colors.white,
            //   child: Container(
            //     width: 300,
            //     height: 300,
            //     alignment: Alignment.center,
            //     child: Text('www.kindacode.com', style: TextStyle(fontSize: 24)),
            //   ),
            // ),
            ),
      ),
    );
  }
}
