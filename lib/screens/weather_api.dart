import 'dart:convert';
import 'package:http/http.dart' as http;

class WeatherAPI {
  // Define the base URL of the API
  static const String _baseUrl =
      'https://api.openweathermap.org/data/2.5/weather';
  static const String _apiKey = 'fd2270fc2053dcc741179b870d8d664e';

  // Fetch weather data for a specific city
  static Future<Map<String, dynamic>> fetchWeather(String city) async {
    final Uri url = Uri.parse('$_baseUrl?q=$city&appid=$_apiKey&units=metric');

    try {
      // Send GET request
      final response = await http.get(url);

      // Check if the request was successful (status code 200)
      if (response.statusCode == 200) {
        // Parse the JSON data
        final data = jsonDecode(response.body);

        // Extract relevant data from the response
        return {
          'temperature': data['main']['temp'] ?? 0.0,
          'precipitation': data['rain'] != null
              ? data['rain']['1h']
              : 0.0, // Rain data (if available)
          'humidity': data['main']['humidity'] ?? 0,
          'windSpeed': data['wind']['speed'] ?? 0.0,
          'windDirection': _getWindDirection(data['wind']['deg']),
          'clouds': data['clouds']['all'] ?? 0,
          'pressure': data['main']['pressure'] ?? 0.0,
        };
      } else {
        throw Exception('Failed to load weather data');
      }
    } catch (e) {
      throw Exception('Failed to fetch weather data: $e');
    }
  }

  // Helper function to convert wind direction degrees to a cardinal direction
  static String _getWindDirection(int degree) {
    if (degree >= 0 && degree < 45) return 'N';
    if (degree >= 45 && degree < 90) return 'NE';
    if (degree >= 90 && degree < 135) return 'E';
    if (degree >= 135 && degree < 180) return 'SE';
    if (degree >= 180 && degree < 225) return 'S';
    if (degree >= 225 && degree < 270) return 'SW';
    if (degree >= 270 && degree < 315) return 'W';
    return 'NW';
  }
}
