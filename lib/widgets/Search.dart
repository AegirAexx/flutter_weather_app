// Widget that renders the Search screen and sends user input back up the tree.

import 'package:flutter/material.dart';

class Search extends StatelessWidget {
  final Function searchWeather; // Functor to change weather data.
  final PageController pageController; // Pointer to the PageViewController.
  final TextEditingController searchController; // Pointer to the input buffer.

  Search(
      {Key key,
      @required this.searchWeather,
      this.pageController,
      this.searchController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          const SizedBox(
            height: 80,
          ),
          Text(
            'Search',
            style: new TextStyle(
              color: Colors.deepOrange,
              fontSize: 60.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          Container(
            margin: EdgeInsets.symmetric(
              horizontal: 50,
            ),
            child: Container(
              width: 300,
              child: Card(
                color: Colors.lime,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  alignment: Alignment.center,
                  child: TextField(
                    controller: searchController,
                    onSubmitted: (value) {
                      searchController.clear();
                      searchWeather(value);
                      pageController.jumpToPage(pageController.initialPage);
                    },
                    decoration: InputDecoration(
                      labelText: 'City',
                      labelStyle: new TextStyle(
                        color: Colors.grey,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
