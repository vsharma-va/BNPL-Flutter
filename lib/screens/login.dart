import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

import 'auth/login_card.dart';
import './components/animate_stack.dart';
import './auth/signup.dart';

class Login extends StatefulWidget {
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> with TickerProviderStateMixin {
  bool isSignUpScreen = true;

  late AnimationController animController;
  late AnimationController animController2;
  int _stackIndex = 0;

  @override
  void initState() {
    super.initState();
    animController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    )..addListener(() {
        if (animController.value.toStringAsFixed(1) == '0.3') {
          setState(() {
            _stackIndex = 1;
          });
        }
      });

    animController2 = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    )..addListener(() {
        if (animController2.value.toStringAsFixed(1) == '0.3') {
          setState(() {
            _stackIndex = 0;
          });
        }
      });
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            width: screenSize.width,
            height: screenSize.height,
            decoration: const BoxDecoration(
              color: Color.fromRGBO(53, 56, 57, 1),
            ),
            child: const RiveAnimation.asset(
              "assets/animations/login_background_animation.riv",
              fit: BoxFit.cover,
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 70),
            child: Container(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 20.0,
                  top: 50,
                ),
                child: Column(
                  children: [
                    Hero(
                      tag: "Welcome Text",
                      child: RichText(
                        text: const TextSpan(
                          text: "Welcome!",
                          style: TextStyle(
                            fontSize: 35,
                            letterSpacing: 2,
                            color: Color.fromARGB(255, 0, 255, 213),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          AnimatedIndexedStack(
            index: _stackIndex,
            children: [
              LoginScreen(
                animController: animController,
                screenSize: screenSize,
                globalKey: GlobalKey(),
              ),
              SignUp(
                animController: animController2,
                screenSize: screenSize,
                globalKey: GlobalKey(),
              ),
            ],
          ),
        ],
      ),
    );
  }

// Positioned(
//             top: (screenSize.height / 2) - (screenSize.height * 0.5) / 2,
//             child: Container(
//               height: screenSize.height * 0.5,
//               padding: EdgeInsets.all(20),
//               width: screenSize.width - 40,
//               margin: const EdgeInsets.symmetric(horizontal: 20),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: const BorderRadius.all(
//                   Radius.circular(15),
//                 ),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black.withOpacity(0.3),
//                     blurRadius: 15,
//                     spreadRadius: 5,
//                   ),
//                 ],
//               ),
}
