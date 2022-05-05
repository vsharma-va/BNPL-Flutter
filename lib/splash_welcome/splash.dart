import 'package:flutter/material.dart';

import '../helper/animations/out_of_screen_right.dart';
import './welcome.dart';
import '../helper/page_transitions/back_forward_transition.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> with SingleTickerProviderStateMixin {
  late AnimationController animController;

  @override
  void initState() {
    animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );
    _navigateToLogin();
    super.initState();
  }

  @override
  void dispose() {
    animController.dispose();
    super.dispose();
  }

  // 2350 milliseconds is the length of the animation => after 2350 milliseconds
  // the page is changed
  Future<void> _navigateToLogin() async {
    await Future.delayed(Duration(milliseconds: 1000), () {});
    // Welcome page contains the code for requresting permission and some initialization
    animController.forward();
    await Future.delayed(Duration(milliseconds: 1000), () {});
    Navigator.pushReplacement(
        context, ForwardOrBackwardTransition(child: Welcome()));
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    // WillPopScope disables the back button
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Center(
          child: Stack(
            clipBehavior: Clip.hardEdge,
            children: [
              RightOutAnim(
                animController: animController,
                width: screenSize.width,
                child1: Image.asset(
                  './assets/Images/logo.png',
                  scale: 5,
                  fit: BoxFit.fill,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
