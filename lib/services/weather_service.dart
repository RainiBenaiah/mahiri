import 'dart:convert';
import 'package:http/http.dart' as http;

class WeatherService {
  static const String _apiKey = 'your_openweathermap_api_key';
  static const String _baseUrl = 'https://api.openweathermap.org/data/2.5';

  Future<Map<String, dynamic>> getCurrentWeather(String location) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/weather?q=$location&units=metric&appid=$_apiKey'),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load weather data');
    }
  }
}