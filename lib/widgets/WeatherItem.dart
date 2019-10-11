import 'package:flutter/material.dart';
import 'package:flutter_weather/models/WeatherData.dart';

class WeatherItem extends StatelessWidget {
  final WeatherData weather;

  WeatherItem({Key key, @required this.weather}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.lime,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Image.network('https://openweathermap.org/img/w/${weather.icon}.png'),
            Text(weather.getWeekdayName, style: new TextStyle(
                color: Colors.indigo,
                fontSize: 30.0,
                fontWeight: FontWeight.bold),
            ),
            Text(weather.getTemp, style: new TextStyle(color: Colors.indigo, fontSize: 24.0, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}