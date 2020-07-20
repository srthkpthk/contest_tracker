import 'package:competition_tracker/src/ui/screens/splash_screen.dart';
import 'package:flutter/material.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Competitive Tracker',
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
