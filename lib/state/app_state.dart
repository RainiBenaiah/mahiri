import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AppState extends ChangeNotifier {
  // Weather data
  double temperature = 0.0;
  double precipitation = 0.0; // Rainfall data
  int humidity = 0; // Humidity percentage
  double windSpeed = 0.0; // Wind speed in m/s
  String windDirection = ''; // Cardinal wind direction
  String weatherDescription = ''; // General weather description
  String city = 'Nairobi'; // Default city
  bool isLoading = false;

  // Notification settings
  bool notificationsEnabled = true;

  final String apiKey = 'fd2270fc2053dcc741179b870d8d664e';

  Future<void> fetchWeatherData() async {
    // Indicate loading state
    WidgetsBinding.instance.addPostFrameCallback((_) {
      isLoading = true;
      notifyListeners();
    });

    final url =
        'https://api.openweathermap.org/data/2.5/weather?q=$city&units=metric&appid=$apiKey';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        // Parsing weather data
        temperature = data['main']['temp'];
        humidity = data['main']['humidity'];
        precipitation = (data['rain']?['1h'] ?? 0.0); // Rainfall in mm
        windSpeed = data['wind']['speed'];
        windDirection = _convertWindDegreeToDirection(data['wind']['deg']);
        weatherDescription = data['weather'][0]['description'];
      } else {
        weatherDescription = 'Error fetching weather data';
      }
    } catch (e) {
      weatherDescription = 'Error: $e';
    } finally {
      // Reset loading state
      isLoading = false;
      notifyListeners();
    }
  }

  // Converts wind degrees to cardinal direction
  String _convertWindDegreeToDirection(int degree) {
    const directions = [
      'N',
      'NNE',
      'NE',
      'ENE',
      'E',
      'ESE',
      'SE',
      'SSE',
      'S',
      'SSW',
      'SW',
      'WSW',
      'W',
      'WNW',
      'NW',
      'NNW'
    ];
    final index = ((degree / 22.5) + 0.5).floor() % 16;
    return directions[index];
  }

  // Toggle notifications
  void toggleNotifications() {
    notificationsEnabled = !notificationsEnabled;
    notifyListeners();
  }

  // Change city
  void changeCity(String newCity) {
    city = newCity;
    fetchWeatherData(); // Refresh weather data for the new city
  }
}
