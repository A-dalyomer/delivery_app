import 'dart:async';

import 'package:bloomdeliveyapp/ui/views/map_screen/map_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:bloomdeliveyapp/ui/views/auth_screen/login_screen.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  Widget build(BuildContext context) {
    Timer(Duration(seconds: 1), () {
      _onSplashEnd();
    });

    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Image.asset("assets/img/logo.png", fit: BoxFit.contain),
      ),
    );
  }

  _onSplashEnd() async {
    await SharedPreferences.getInstance().then((prefs) {
      if (prefs.getString('token') != null &&
          prefs.getString('token')!.isNotEmpty) {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => DeliveryMapScreen()));
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (BuildContext context) => const Login()),
        );
      }
    });
  }
}
