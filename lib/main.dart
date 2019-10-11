import 'dart:convert'; // Package to concert JSON data.
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; // Future based HTTP requests.
import 'package:location/location.dart'; // Getting location from device.
import 'package:flutter/services.dart'; // Exception services.

import 'package:flutter_weather/widgets/Weather.dart';
import 'package:flutter_weather/widgets/Search.dart';
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
  // State variables
  final searchController = TextEditingController();
  final Location _location = new Location();
  PageController _pageController;
  bool isLoading = false;
  WeatherData weatherData;
  ForecastData forecastData;
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
            body: PageView(
              controller: _pageController,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: weatherData != null
                          ? Weather(
                              weather: weatherData,
                            )
                          : Container(),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    IconButton(
                      iconSize: 50,
                      color: Colors.white,
                      icon: Icon(
                        Icons.refresh,
                      ),
                      onPressed: () {
                        loadWeather();
                      },
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: forecastData != null
                      ? Forecast(
                          weather: forecastData,
                        )
                      : Container(),
                ),
                Search(
                  searchWeather: searchWeather,
                  pageController: _pageController,
                  searchController: searchController,
                ),
              ],
            )));
  }

  // Function that refreshes the state with search string data.
  searchWeather(String city) async {
    setState(() {
      isLoading = true;
    });

    // Setting up the URLs.
    final baseUrl = 'https://api.openweathermap.org';
    final weatherUrl =
        '$baseUrl/data/2.5/weather?q=$city&units=metric&appid=${ApiKey.OPEN_WEATHER_MAP}';
    final forecastUrl =
        '$baseUrl/data/2.5/forecast?q=$city&units=metric&appid=${ApiKey.OPEN_WEATHER_MAP}';

    // Make the HTTP request.
    final weatherResponse = await http.get(weatherUrl);
    final forecastResponse = await http.get(forecastUrl);

    // Look for a statuscode of 200.
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

    setState(() {
      isLoading = false;
    });
  }

  // Main loading API data.
  loadWeather() async {
    setState(() {
      isLoading = true;
    });

    // Location version bugs that kept me down!
    
    // LocationData location;
    Map<String, double> location;
    // var location;

    // Get the location from device.
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

    final baseUrl = 'https://api.openweathermap.org';

    // If there is location data from device?
    if (location != null) {
      final lat = location['latitude'];
      final lon = location['longitude'];

      final weatherUrl =
          '$baseUrl/data/2.5/weather?lat=$lat&lon=$lon&units=metric&appid=${ApiKey.OPEN_WEATHER_MAP}';
      final forecastUrl =
          '$baseUrl/data/2.5/forecast?lat=$lat&lon=$lon&units=metric&appid=${ApiKey.OPEN_WEATHER_MAP}';

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
    } else { // Else just load default data... Berlin.
      final weatherUrl =
          '$baseUrl/data/2.5/weather?q=Berlin&units=metric&appid=${ApiKey.OPEN_WEATHER_MAP}';
      final forecastUrl =
          '$baseUrl/data/2.5/forecast?q=Berlin&units=metric&appid=${ApiKey.OPEN_WEATHER_MAP}';

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
