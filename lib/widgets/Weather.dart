import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:flutter_weather/models/WeatherData.dart';

class Weather extends StatelessWidget {
  final WeatherData weather;

  Weather({Key key, @required this.weather}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(weather.name, style: new TextStyle(color: Colors.yellow, fontSize: 60.0, fontWeight: FontWeight.bold),),
        const SizedBox(height: 30,),
        Text(weather.main, style: new TextStyle(color: Colors.white, fontSize: 40.0)),
        Text(weather.description, style: new TextStyle(color: Colors.white, fontSize: 20.0)),
        const SizedBox(height: 30,),
        Text('${weather.temp.floor().toString()}°C',  style: new TextStyle(color: Colors.white, fontSize: 50.0)),
        const SizedBox(height: 30,),
        Image.network('https://openweathermap.org/img/w/${weather.icon}.png'),
        const SizedBox(height: 30,),
        Text(new DateFormat.yMMMd().format(weather.date), style: new TextStyle(color: Colors.white)),
        Text('Last updated: ${new DateFormat.Hm().format(weather.date)}', style: new TextStyle(color: Colors.red)),

      ],
    );
  }
}