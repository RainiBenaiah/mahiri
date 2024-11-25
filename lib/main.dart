import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'state/app_state.dart';
import 'screens/intro_screen.dart';

void main() {
  runApp(SmartIrrigationApp());
}

class SmartIrrigationApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppState(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Smart Irrigation',
        theme: ThemeData(
          primarySwatch: Colors.green,
          scaffoldBackgroundColor: const Color.fromARGB(255, 80, 247, 47),
        ),
        home: IntroScreen(),
      ),
    );
  }
}
