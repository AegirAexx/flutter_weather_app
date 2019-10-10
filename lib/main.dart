import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:location/location.dart';
import 'package:flutter/services.dart';

import 'package:flutter_weather/widgets/Weather.dart';
import 'package:flutter_weather/widgets/Forecast.dart';
import 'package:flutter_weather/models/ApiKey.dart';
import 'package:flutter_weather/models/WeatherData.dart';
import 'package:flutter_weather/models/ForecastData.dart';

void main() => runApp(new MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  PageController _pageController;
  bool isLoading = false;
  WeatherData weatherData;
  ForecastData forecastData;
  Location _location = new Location();
  String error;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    loadWeather();
  }

    @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: Scaffold(
        backgroundColor: Colors.indigo,
        appBar: AppBar(
          title: Text('Weather App', style: new TextStyle(color: Colors.yellow, fontWeight: FontWeight.bold),),
        ),
        body: PageView(
          controller: _pageController,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: weatherData != null ? Weather(weather: weatherData) : Container(),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: forecastData != null ? Forecast(weather: forecastData) : Container(),
            ),
            Container(
              child: Center(
                child: Text('SEARCH!', style: new TextStyle(color: Colors.yellow, fontSize: 60.0, fontWeight: FontWeight.bold), ),
              ),
            )
          ],
        )
      )
    );
  }



  loadWeather() async {
    setState(() {
      isLoading = true;
    });

    // Location version bugs that kept me down!
    // LocationData location;
    Map<String, double> location;
    // var location;

    try {
      error = null;
      location = await _location.getLocation();
    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        error = 'Permission denied';
      } else if (e.code == 'PERMISSION_DENIED_NEVER_ASK') {
        error = 'Please ask the user to enable it from the app settings';
      }
      location = null;
    }

    if (location != null) {
      final lat = location['latitude'];
      final lon = location['longitude'];

      final apiKey = ApiKey.OPEN_WEATHER_MAP;
      final baseUrl = 'https://api.openweathermap.org';
      final weatherUrl = '$baseUrl/data/2.5/weather?lat=$lat&lon=$lon&units=metric&appid=$apiKey';
      final forecastUrl = '$baseUrl/data/2.5/forecast?lat=$lat&lon=$lon&units=metric&appid=$apiKey';

      final weatherResponse = await http.get(weatherUrl);
      final forecastResponse = await http.get(forecastUrl);

      if (weatherResponse.statusCode == 200 &&
          forecastResponse.statusCode == 200) {
        return setState(() {
          weatherData =
          new WeatherData.fromJson(jsonDecode(weatherResponse.body));
          forecastData =
          new ForecastData.fromJson(jsonDecode(forecastResponse.body));
          isLoading = false;
        });
      }
    }

    setState(() {
      isLoading = false;
    });
  }
}

