import 'package:competition_tracker/res.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'c_p_home.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 2), () => goToHome(context));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Image.asset(
          Res.logo,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
        ),
      ),
    );
  }

  void goToHome(BuildContext context) =>
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => CPHome()));
}
