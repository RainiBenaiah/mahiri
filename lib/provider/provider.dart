import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AppState extends ChangeNotifier {
  // Properties
  String city = "Nairobi";
  String weatherDescription = "Loading...";
  double temperature = 0.0;
  int humidity = 0;
  String errorMessage = "";
  bool notificationsEnabled = true;
  bool isLoading = false;

  // OpenWeatherMap API Key
  static const String apiKey =
      "fd2270fc2053dcc741179b870d8d664e"; .

  // Fetch Weather Data
  Future<void> fetchWeather() async {
    final url = Uri.parse(
        "https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey&units=metric");

    // Set loading state
    isLoading = true;
    notifyListeners();

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        weatherDescription = data["weather"][0]["description"];
        temperature = data["main"]["temp"];
        humidity = data["main"]["humidity"];
        errorMessage = "";
      } else {
        errorMessage = "Failed to load weather data. (${response.statusCode})";
      }
    } catch (e) {
      errorMessage = "An error occurred: $e";
    }

    // Reset loading state
    isLoading = false;
    notifyListeners();
  }

  // Update City and Fetch Data
  void changeCity(String newCity) {
    city = newCity;
    fetchWeather();
  }

  // Toggle Notifications
  void toggleNotifications() {
    notificationsEnabled = !notificationsEnabled;
    notifyListeners();
  }
}
