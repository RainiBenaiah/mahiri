import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../state/app_state.dart';

class SettingsNotificationsScreen extends StatefulWidget {
  @override
  _SettingsNotificationsScreenState createState() =>
      _SettingsNotificationsScreenState();
}

class _SettingsNotificationsScreenState
    extends State<SettingsNotificationsScreen> {
  double moistureThreshold = 30.0; // Default value
  String notificationFrequency = 'Daily'; // Default notification frequency

  final List<String> frequencies = ['Hourly', 'Daily', 'Weekly'];

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings & Notifications'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Notification Settings
            SectionHeader(title: 'Notification Settings'),
            SwitchListTile(
              title: const Text('Enable Notifications'),
              secondary: Icon(
                appState.notificationsEnabled
                    ? Icons.notifications_active
                    : Icons.notifications_off,
                color:
                appState.notificationsEnabled ? Colors.green : Colors.red,
              ),
              value: appState.notificationsEnabled,
              onChanged: (value) => appState.toggleNotifications(),
            ),
            const SizedBox(height: 16),
            ListTile(
              leading: const Icon(Icons.alarm),
              title: const Text('Notification Frequency'),
              trailing: DropdownButton<String>(
                value: notificationFrequency,
                items: frequencies
                    .map((freq) =>
                    DropdownMenuItem(value: freq, child: Text(freq)))
                    .toList(),
                onChanged: (newValue) {
                  setState(() {
                    notificationFrequency = newValue!;
                  });
                },
              ),
            ),
            const Divider(),

            // Change City
            SectionHeader(title: 'Change City'),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Enter city name',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.location_city),
              ),
              onSubmitted: (newCity) {
                appState.changeCity(newCity);
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text('City updated to $newCity'),
                  duration: const Duration(seconds: 2),
                ));
              },
            ),
            const SizedBox(height: 16),

            // Moisture Threshold
            SectionHeader(title: 'Moisture Threshold (%)'),
            Slider(
              value: moistureThreshold,
              min: 0,
              max: 100,
              divisions: 20,
              label: '${moistureThreshold.toInt()}%',
              onChanged: (value) {
                setState(() {
                  moistureThreshold = value;
                });
              },
            ),
            Center(
              child: Text(
                'Current Threshold: ${moistureThreshold.toInt()}%',
                style: const TextStyle(fontSize: 16),
              ),
            ),
            const Divider(),

            // Theme Selection
            SectionHeader(title: 'Theme'),
            SwitchListTile(
              title: const Text('Enable Dark Mode'),
              secondary: Icon(
                appState.notificationsEnabled
                    ? Icons.dark_mode
                    : Icons.light_mode,
              ),
              value: Theme.of(context).brightness == Brightness.dark,
              onChanged: (value) {
                // Toggle theme logic here (if managed globally)
              },
            ),
            const SizedBox(height: 16),

            // Save Button
            Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  // Save settings logic here
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Settings saved successfully!'),
                    duration: Duration(seconds: 2),
                  ));
                },
                icon: const Icon(Icons.save),
                label: const Text('Save Settings'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                      vertical: 12.0, horizontal: 20.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SectionHeader extends StatelessWidget {
  final String title;

  const SectionHeader({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
