import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movieversum/models/credit_data.dart';
import 'package:movieversum/views/actor_info.dart';

class Credits extends StatefulWidget {
  const Credits({Key? key, required this.credits}) : super(key: key);
  final List<Cast> credits;
  @override
  _CreditsState createState() => _CreditsState();
}

class _CreditsState extends State<Credits> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140.0,
      padding: EdgeInsets.only(left: 10.0),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: super.widget.credits.length,
        itemBuilder: (context, index) {
          return Container(
            padding: EdgeInsets.only(top: 10.0, right: 8.0),
            width: 100.0,
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) =>
                        ActorInfo(id: super.widget.credits[index].id),
                  ),
                );
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  super.widget.credits[index].profilePath == null
                      ? Hero(
                          tag: super.widget.credits[index].creditId,
                          child: Container(
                            width: 70.0,
                            height: 70.0,
                            decoration: new BoxDecoration(
                                shape: BoxShape.circle, color: Colors.white70),
                            child: Icon(
                              FontAwesomeIcons.userAlt,
                              color: Colors.brown,
                            ),
                          ),
                        )
                      : Hero(
                          tag: super.widget.credits[index].creditId,
                          child: Container(
                            width: 70.0,
                            height: 70.0,
                            decoration: new BoxDecoration(
                              shape: BoxShape.circle,
                              image: new DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                  "https://image.tmdb.org/t/p/w300/" +
                                      super.widget.credits[index].profilePath,
                                ),
                              ),
                            ),
                          ),
                        ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    super.widget.credits[index].name,
                    maxLines: 2,
                    style: TextStyle(
                        height: 1.4,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 9.0),
                  ),
                  SizedBox(
                    height: 3.0,
                  ),
                  super.widget.credits[index].character == null
                      ? Text(
                          super.widget.credits[index].job,
                          maxLines: 2,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              height: 1.4,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 7.0),
                        )
                      : Text(
                          super.widget.credits[index].character,
                          maxLines: 2,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              height: 1.4,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 7.0),
                        ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
