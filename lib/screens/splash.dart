import 'package:flutter/material.dart';

import 'package:rive/rive.dart' as rive;
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
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Container(
          width: screenSize.width,
          height: screenSize.height,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              colors: [
                Color.fromRGBO(205, 205, 205, 1),
                Color.fromRGBO(67, 67, 67, 1),
              ],
            ),
          ),
          child: const Center(
            child: rive.RiveAnimation.asset(
              "assets/animations/splash_animation.riv",
              fit: BoxFit.fill,
            ),
          ),
        ),
      ),
    );
  }
}
