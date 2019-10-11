# flutter_weather_app

A simple front-end weather forecast client. It uses the OpenWeatherMap WeatherAPI to provide data. The client is written in Dart using the Flutter SDK framework.

It was developed for Android 9 and tested on an emulated Pixel XL.

## Dependencies:
Besides what comes included when executing `flutter create`, I've added a few more packages from [pub.dev](https://pub.dev/):
- [__http__](https://pub.dev/packages/http) - A Future-based library for making HTTP requests.
- [__intl__](https://pub.dev/packages/intl) - This package provides date/number formatting and parsing.
- [__location__](https://pub.dev/packages/location) - Handles getting location on Android and iOS.

## Usage
To run the application you need to have __Flutter__ and __Android Studio__ installed. To be able to receive data from the OpenWeatherMap WeatherAPI a API key is required. To get one head on over to [OpenWeatherMap](https://home.openweathermap.org/users/sign_up) and get your free API key.

### Steps for getting started:
1. Clone the repository.
2. Run `flutter pub get` from the command line.
3. Add your API key to `ApiKey.dart`.
    ```Dart
    class ApiKey {
    static const OPEN_WEATHER_MAP = 'INSERT_YOUR_API_KEY_HERE';
    }
    ```
4. Build and run the App.

## Goals for this project
- The user can see the weather information for the current day.
- The user can see a list of days containing the overall information of the day.
- The user can select any given day from the list to see more information about it.s
- The data should be cached no more than 12 hours locally but the user can request to refresh it.

## Project Structure
```
.
├── main.dart
├── models
│   ├── ApiKey.dart
│   ├── ForecastData.dart
│   └── WeatherData.dart
└── widgets
    ├── Forecast.dart
    ├── Search.dart
    ├── Weather.dart
    └── WeatherItem.dart

```
