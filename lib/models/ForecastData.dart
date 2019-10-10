import 'package:flutter_weather/models/WeatherData.dart';

class ForecastData {
  final List list;

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

  ForecastData({this.list});

  factory ForecastData.fromJson(Map<String, dynamic> json) {
    List list = new List();

    for (dynamic e in json['list']) {
      WeatherData w = new WeatherData(
        date: new DateTime.fromMillisecondsSinceEpoch(e['dt'] * 1000, isUtc: false),
        name: json['city']['name'],
        temp: e['main']['temp'].toDouble(),
        tempMin: e['main']['temp_min'].toDouble(),
        tempMax: e['main']['temp_max'].toDouble(),
        main: e['weather'][0]['main'],
        description: e['weather'][0]['description'],
        icon: e['weather'][0]['icon'],
        windSpeed: e['wind']['speed'].toDouble(),
        windDeg: e['wind']['deg'].toDouble(),
      );
      list.add(w);
    }

    return ForecastData(
      list: list,
    );
  }
}
