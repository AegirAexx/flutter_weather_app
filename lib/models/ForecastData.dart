// Data type that holds a collection of the WeatherData.

import 'package:flutter_weather/models/WeatherData.dart';

class ForecastData {

  // List to hold the data.
  final List list;

  // Custom class getter.
  List get getForecastData {
    List ws = new List();
    for(WeatherData w in this.list) {
      if(DateTime.now().weekday != w.date.weekday){
        if(w.date.hour == 12){
          ws.add(w);
        }
      }
    }
    return ws;
  }

  // Class constructor.
  ForecastData({this.list});

  // JSON factory constructor.
  factory ForecastData.fromJson(Map<String, dynamic> json) {
    List list = new List();
    for (dynamic element in json['list']) {
      WeatherData w = new WeatherData(
        date: new DateTime.fromMillisecondsSinceEpoch(element['dt'] * 1000, isUtc: false),
        name: json['city']['name'],
        temp: element['main']['temp'].toDouble(),
        tempMin: element['main']['temp_min'].toDouble(),
        tempMax: element['main']['temp_max'].toDouble(),
        main: element['weather'][0]['main'],
        description: element['weather'][0]['description'],
        icon: element['weather'][0]['icon'],
        windSpeed: element['wind']['speed'].toDouble(),
        windDeg: element['wind']['deg'].toDouble(),
      );
      list.add(w);
    }

    return ForecastData(
      list: list,
    );
  }
}
