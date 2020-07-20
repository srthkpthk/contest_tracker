import 'package:competition_tracker/src/ui/screens/c_p_home.dart';
import 'package:flutter/material.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Competitive Tracker',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: Color.fromRGBO(7, 29, 52, 1),
          accentColor: Color.fromRGBO(30, 235, 179, 1)),
      home: CPHome(),
    );
  }
}
