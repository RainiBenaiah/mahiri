import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'zones_screen.dart';
import '../state/app_state.dart'; // Import the AppState class

class WeatherSensorsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context); // Access AppState

    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather Details'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // City Selection Input
              TextField(
                decoration: InputDecoration(
                  labelText: 'Enter City',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: () {
                      // Trigger fetchWeatherData
                      appState.fetchWeatherData();
                    },
                  ),
                ),
                onChanged: (value) {
                  appState.changeCity(value); // Update city dynamically
                },
              ),
              const SizedBox(height: 16),
              if (appState.isLoading)
                const Center(child: CircularProgressIndicator())
              else ...[
                // Temperature Section
                WeatherCard(
                  icon: Icons.thermostat,
                  title: 'Temperature',
                  value: '${appState.temperature.toStringAsFixed(1)}°C',
                  color: Colors.orange,
                ),
                const SizedBox(height: 16),
                // Humidity Section
                WeatherCard(
                  icon: Icons.water_drop,
                  title: 'Humidity',
                  value: '${appState.humidity}%',
                  color: Colors.lightBlueAccent,
                ),
                const SizedBox(height: 16),
                // Precipitation Section
                WeatherCard(
                  icon: Icons.opacity,
                  title: 'Precipitation',
                  value: '${appState.precipitation.toStringAsFixed(1)} mm',
                  color: Colors.blue,
                ),
                const SizedBox(height: 16),
                // Wind Speed Section
                WeatherCard(
                  icon: Icons.air,
                  title: 'Wind Speed',
                  value: '${appState.windSpeed.toStringAsFixed(1)} m/s',
                  color: Colors.green,
                ),
                const SizedBox(height: 16),
                // Wind Direction Section
                WeatherCard(
                  icon: Icons.navigation,
                  title: 'Wind Direction',
                  value: appState.windDirection,
                  color: Colors.blueGrey,
                ),
                const SizedBox(height: 16),
                // Weather Description Section
                WeatherCard(
                  icon: Icons.cloud,
                  title: 'Description',
                  value: appState.weatherDescription,
                  color: Colors.grey,
                ),
              ],
              const SizedBox(height: 32),
              // Navigation Button
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                      vertical: 12.0, horizontal: 24.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ZonesScreen()),
                  );
                },
                child: const Text(
                  'Manage Zones',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class WeatherCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final Color color;

  const WeatherCard({
    Key? key,
    required this.icon,
    required this.title,
    required this.value,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundColor: color.withOpacity(0.2),
              child: Icon(icon, size: 36, color: color),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    value,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
