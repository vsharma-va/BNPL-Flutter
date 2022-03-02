import 'package:flutter/material.dart';

import 'package:rive/rive.dart';
import './welcome.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    _navigateToLogin();
  }

  _navigateToLogin() async {
    await Future.delayed(Duration(milliseconds: 2350), () {});
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => Welcome()));
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color.fromRGBO(53, 56, 57, 1),
      body: Container(
        width: screenSize.width,
        height: screenSize.height,
        child: const Center(
          child: RiveAnimation.asset(
            "assets/animations/splash_animation.riv",
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}
