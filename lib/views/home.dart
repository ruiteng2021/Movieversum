import 'package:flutter/material.dart';
import 'package:movieversum/models/movie_data.dart';
import 'package:movieversum/views/movie.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    List<Widget> screens = [];
    screens.add(new Movies(movieType: "popular"));
    screens.add(new Movies(movieType: "upcoming"));
    screens.add(new Movies(movieType: "top_rated"));
    screens.add(
      new Center(
        child: Text(
          "Search",
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
    return Scaffold(
      bottomNavigationBar: buildBottomBar(),
      body: buildPages(screens),
    );
  }

  Widget buildBottomBar() {
    return BottomNavigationBar(
      elevation: 0,
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.black,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.white70,
      currentIndex: _selectedIndex,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite_rounded),
          label: 'Popular',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.attractions),
          label: 'Upcoming',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.rate_review),
          label: 'Top Rated',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          label: 'Searching',
        ),
      ],
      onTap: (int index) => setState(() => this._selectedIndex = index),
    );
  }

  Widget buildPages(List<Widget> screens) {
    return IndexedStack(
      index: _selectedIndex,
      children: screens,
    );
  }
}
