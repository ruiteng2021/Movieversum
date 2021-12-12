import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movieversum/models/trending_data.dart';
import 'package:movieversum/views/trending_card.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class Trendings extends StatefulWidget {
  final trendingType;
  Trendings({
    this.trendingType,
  });
  @override
  _TrendingsState createState() => _TrendingsState();
}

class _TrendingsState extends State<Trendings> {
  int currentPage = 1;

  late int totalPages = 0;

  List<Trending> trendings = [];

  final RefreshController refreshController =
      RefreshController(initialRefresh: true);

  @override
  void initState() {
    super.initState();
    // selection = super.widget.selection;
    // selectedCity = super.widget.selectedCity;
    // print(selectedCity['city']);
  }

  Future<bool> getTrendingData({bool isRefresh = false}) async {
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

    print("Trending type : ${super.widget.trendingType}");
    Uri uri = Uri.parse(
        "https://api.themoviedb.org/3/${super.widget.trendingType}/all/week?api_key=d194eb72915bc79fac2eb1a70a71ddd3&language=en-US&page=$currentPage");

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      print("Url: $uri");
      print(response.body);
      final result = trendingDataFromJson(response.body);
      print(jsonEncode(result.results));
      if (isRefresh) {
        trendings = result.results;
      } else {
        print(jsonEncode(result.results));
        trendings.addAll(result.results);
        print("passengers Length: ");
        print(trendings.length);
      }

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
          final result = await getTrendingData(isRefresh: true);
          if (result) {
            refreshController.refreshCompleted();
          } else {
            refreshController.refreshFailed();
          }
        },
        onLoading: () async {
          final result = await getTrendingData();
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
            final trending = trendings[index];
            return TrendingCard(
              trending: trending,
            );
          },
          // separatorBuilder: (contex, indexc) => Divider(),
          itemCount: trendings.length,
        ),
      ),
    );
  }
}
