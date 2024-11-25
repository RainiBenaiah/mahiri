import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../state/app_state.dart';
import 'weather_sensors_screen.dart';
import 'zones_screen.dart';
import 'settings_notifications_screen.dart';

class IntroScreen extends StatefulWidget {
  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
    _controller.repeat(reverse: true);

    final appState = Provider.of<AppState>(context, listen: false);
    appState.fetchWeatherData();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome to Mahiri Your Weather Combanion'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FadeTransition(
              opacity: _animation,
              child: Text(
                'Mahiri Smart App',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Guidelines:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            Text('1. Monitor soil moisture and weather data.'),
            Text('2. Manage zones independently.'),
            Text('3. Receive notifications and alerts.'),
            Text('4. Settings.'),
            SizedBox(height: 16),
            Divider(),
            Text(
              'Dashboard',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Card(
              child: ListTile(
                leading: Icon(Icons.thermostat, size: 40, color: Colors.orange),
                title: Text(
                  appState.isLoading
                      ? 'Loading...'
                      : 'Weather: ${appState.temperature}°C\nCondition: ${appState.weatherDescription}',
                ),
              ),
            ),
            Card(
              child: ListTile(
                leading: Icon(Icons.water_drop, size: 40, color: Colors.blue),
                title: Text('Soil Moisture (Zone 1): 40%'),
              ),
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => WeatherSensorsScreen()),
                    );
                  },
                  child: Text('Weather & Sensors'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ZonesScreen()),
                    );
                  },
                  child: Text('Manage Zones'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SettingsNotificationsScreen()),
                    );
                  },
                  child: Text('Settings & Alerts'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
