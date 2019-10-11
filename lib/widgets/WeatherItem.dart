import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:flutter_weather/models/WeatherData.dart';

class WeatherItem extends StatelessWidget {
  final WeatherData weather;

  WeatherItem({Key key, @required this.weather}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Image.network('https://openweathermap.org/img/w/${weather.icon}.png'),
            Text(weather.getWeekdayName, style: new TextStyle(color: Colors.black, fontSize: 24.0)),
            Text('${weather.getTemp}°C', style: new TextStyle(color: Colors.black, fontSize: 24.0)),
            Text('  Hi   -    Lo\n${weather.getTempHiLo}', style: new TextStyle(color: Colors.black, fontSize: 10.0)),
          ],
        ),
      ),
    );
  }
  // @override
  // Widget build(BuildContext context) {
  //   return Card(
  //     child: Padding(
  //       padding: const EdgeInsets.all(8.0),
  //       child: Column(
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         children: <Widget>[
  //           Text(weather.name, style: new TextStyle(color: Colors.black)),
  //           Text(weather.main, style: new TextStyle(color: Colors.black, fontSize: 24.0)),
  //           Text(weather.description, style: new TextStyle(color: Colors.black, fontSize: 12.0)),
  //           Text('${weather.temp.floor().toString()}°C',  style: new TextStyle(color: Colors.black)),
  //           Image.network('https://openweathermap.org/img/w/${weather.icon}.png'),
  //           Text(new DateFormat.yMMMd().format(weather.date), style: new TextStyle(color: Colors.black)),
  //           Text(new DateFormat.Hm().format(weather.date), style: new TextStyle(color: Colors.black)),
  //         ],
  //       ),
  //     ),
  //   );
  // }
}