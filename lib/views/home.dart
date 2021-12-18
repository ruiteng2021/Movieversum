import 'package:flutter/material.dart';
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
    screens.add(new Movies(movieType: "now_playing"));

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
      // selectedFontSize: 20.0,
      // unselectedFontSize: 12.0,
      currentIndex: _selectedIndex,
      items: [
        BottomNavigationBarItem(
          // icon: Icon(Icons.favorite_rounded),
          icon: Image.asset(
            'assets/images/logo.png',
            height: 30,
            width: 30,
          ),
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
          icon: Icon(Icons.movie_filter),
          label: 'Now Playing',
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
