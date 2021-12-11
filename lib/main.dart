import 'dart:io';
import 'package:flutter/material.dart';
// import 'package:movieversum/screens/home_screen.dart';
import 'package:movieversum/views/home.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() {
  HttpOverrides.global = MyHttpOverrides();
  runApp(Movieversum());
}

class Movieversum extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // title: 'Flutter Travel UI',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          // primaryColor: Colors.black,
          // accentColor: Color(0xFFD8ECF1),
          // scaffoldBackgroundColor: Color(0xFFF3F5F7),
          ),
      initialRoute: '/home',
      routes: {
        // '/': (context) => Loading(),
        '/home': (context) => Home(),
        // '/test': (context) => TabViewTest(),
        // '/test2': (context) => TabViewTest2(),
      },
      // home: HomeScreen(),
    );
  }
}
