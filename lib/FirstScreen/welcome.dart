import 'package:flutter/material.dart';

import './login.dart';

class Welcome extends StatefulWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  void initState() {
    super.initState();
    _navigateToLogin();
  }

  _navigateToLogin() async {
    await Future.delayed(Duration(milliseconds: 4000), () {});
    Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => Login.main(
            transitionAnimation: animation,
          ),
          transitionDuration: const Duration(seconds: 1),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            colors: [
              Color.fromRGBO(53, 56, 57, 1),
              Color.fromRGBO(53, 56, 57, 1)
            ],
          ),
        ),
        child: Hero(
          transitionOnUserGestures: true,
          tag: "Welcome Text",
          child: RichText(
            text: const TextSpan(
              text: "Welcome!",
              style: TextStyle(
                fontSize: 55,
                letterSpacing: 2,
                color: Color.fromARGB(255, 0, 255, 213),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
