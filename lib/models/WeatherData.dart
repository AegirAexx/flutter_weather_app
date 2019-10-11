// The main data model, holds the information about the weather.
// It contains a Factory function that creates data from JSON.

class WeatherData {

  // Member data.
  final DateTime date;
  final String name;
  final double temp;
  final double tempMin;
  final double tempMax;
  final String main;
  final String description;
  final String icon;
  final double windSpeed;
  final double windDeg;

  // Custom class getters.
  String get getWeekdayName {
    return {1: 'Monday', 2: 'Tuesday', 3: 'Wednesday', 4: 'Thursday', 5: 'Friday', 6: 'Saturday', 7: 'Sunday'}[this.date.weekday];
  }

  String get getTemp {
    return this.temp.toStringAsFixed(1) + '°C';
  }

  // Class constructor.
  WeatherData({this.date, this.name, this.temp, this.tempMin, this.tempMax, this.main, this.description, this.icon, this.windSpeed, this.windDeg});

  // JSON factory constructor.
  factory WeatherData.fromJson(Map<String, dynamic> json) {
    return WeatherData(
      date: new DateTime.fromMillisecondsSinceEpoch(json['dt'] * 1000, isUtc: false),
      name: json['name'],
      temp: json['main']['temp'].toDouble(),
      tempMin: json['main']['temp_min'].toDouble(),
      tempMax: json['main']['temp_max'].toDouble(),
      main: json['weather'][0]['main'],
      description: json['weather'][0]['description'],
      icon: json['weather'][0]['icon'],
      windSpeed: json['wind']['speed'].toDouble(),
      windDeg: json['wind']['deg'].toDouble(),
    );
  }
}