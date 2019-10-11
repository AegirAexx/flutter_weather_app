// Widget that renders the Forecast screen and list.

import 'package:flutter/material.dart';
import 'package:flutter_weather/widgets/WeatherItem.dart';
import 'package:flutter_weather/models/ForecastData.dart';

class Forecast extends StatelessWidget {
  final ForecastData weather;

  Forecast({Key key, @required this.weather}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const SizedBox(
          height: 30,
        ),
        Text(
          weather.getForecastData[0].name,
          style: new TextStyle(
              color: Colors.deepOrange,
              fontSize: 55.0,
              fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 20,
        ),
        Text(
          'The next few days:',
          style: new TextStyle(
            color: Colors.white,
            fontSize: 15.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 350.0,
              child: weather != null
                  ? ListView.builder(
                      // Listview from custom class getter.
                      itemCount: weather.getForecastData.length,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) => WeatherItem(
                          weather: weather.getForecastData.elementAt(index),
                      ),
                  )
                  : Container(),
            ),
          ),
        ),
      ],
    );
  }
}
