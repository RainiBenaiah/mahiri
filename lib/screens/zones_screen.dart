import 'package:flutter/material.dart';

class ZonesScreen extends StatelessWidget {
  final List<Map<String, dynamic>> zones = [
    {
      'name': 'Zone 1',
      'status': true,
      'location': {
        'name': 'Farm Area A',
        'latitude': 40.7128,
        'longitude': -74.0060,
      },
    },
    {
      'name': 'Zone 2',
      'status': false,
      'location': {
        'name': 'Farm Area B',
        'latitude': 34.0522,
        'longitude': -118.2437,
      },
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Zones'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: zones.length,
                itemBuilder: (context, index) {
                  final zone = zones[index];
                  return Card(
                    elevation: 4.0,
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: ListTile(
                      leading: const Icon(Icons.grass, size: 40),
                      title: Text(zone['name']),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              'Status: ${zone['status'] ? 'Active' : 'Inactive'}'),
                          const SizedBox(height: 4),
                          Text('Location: ${zone['location']['name']}'),
                          Text(
                            'Lat: ${zone['location']['latitude']}, Lon: ${zone['location']['longitude']}',
                            style: const TextStyle(
                                fontSize: 12, color: Colors.black54),
                          ),
                        ],
                      ),
                      trailing: Switch(
                        value: zone['status'],
                        onChanged: (bool value) {
                          // Handle zone status toggle logic
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
            FloatingActionButton(
              onPressed: () {
                // Add Zone Logic
              },
              child: const Icon(Icons.add),
              backgroundColor: Colors.green,
            ),
          ],
        ),
      ),
    );
  }
}
