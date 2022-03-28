import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'auth/login_card.dart';
import 'components/user_greeting@login.dart';
import '../theme_data.dart' as theme;

class Login extends StatefulWidget {
  Login({this.attributes, this.fileMap});
  final Map<String, String>? attributes;
  final Map<String, String>? fileMap;
  @override
  State<Login> createState() =>
      _LoginState(attributes: attributes, fileMap: fileMap);
}

class _LoginState extends State<Login> with SingleTickerProviderStateMixin {
  _LoginState({this.attributes, this.fileMap});
  final Map<String, String>? attributes;
  final Map<String, String>? fileMap;
  late AnimationController animGreetingController;
  double _maxScrollOffset = 0.0;
  bool isSignUpScreen = true;
  var _greetingVisibilePercentage = 0.0;

  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()
      ..addListener(() {
        _onScroll();
      });
    animGreetingController = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          if (_scrollOffset.clamp(0, 500) == 500) {
            animGreetingController.reset();
            animGreetingController.forward();
          }
        }
      });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    animGreetingController.dispose();
    super.dispose();
  }

  double _scrollOffset = 0.0;
  void _onScroll() {
    if (mounted) {
      setState(() {
        _scrollOffset = _scrollController.offset;
      });
      _maxScrollOffset = _scrollController.position.maxScrollExtent;
    }
  }

  Map<String, String>? _nullCheckAttributes() {
    if (attributes == null) {
      return {};
    }
    return attributes;
  }

  final double _layer5Speed = 0.45;
  final double _layer0Speed = 0.35;
  final double _layer1Speed = 0.5;
  final double _layer2Speed = 0.75;
  final double _layer3Speed = 0.95;
  final double _layer4Speed = 0.65;
  final double _offscreenLayerSpeed = 0.45;

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var layoutHeight = screenSize.height * 2.5;
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Container(
          alignment: Alignment.bottomCenter,
          decoration: const BoxDecoration(
            color: theme.backgroundColor,
            // gradient: LinearGradient(
            //   begin: Alignment.topCenter,
            //   colors: [
            //     Colors.white,
            //     Colors.black,
            //   ],
            // ),
          ),
          child: Stack(
            children: <Widget>[
              // Positioned(
              //   child: Image.asset("./assets/Images/s(1).png"),
              //   top: screenSize.height / 2 - 100,
              //   right: screenSize.width - 200,
              //   left: 0,
              // ),
              // Positioned.fill(
              //   child: Image.asset(
              //     "./assets/Images/test_background.jpg",
              //     fit: BoxFit.fill,
              //   ),
              // ),

              // Positioned(
              //   bottom: _layer1Speed * _scrollOffset - 150,
              //   right: 0,
              //   left: 0,
              //   child: Image.asset(
              //     "./assets/Images/trees(1).png",
              //     color: theme.primaryColor,
              //   ),
              // ),
              UserGreetingAnim(
                // animController: animGreetingController,
                screenSize: screenSize,
                attributes: attributes,
                fileMap: fileMap,
                layer5Speed: _offscreenLayerSpeed,
                scrollOffset: _scrollOffset,
                maxScrollOffset: _maxScrollOffset,
              ),
              // Positioned(
              //   top: 0,
              //   left: _maxScrollOffset - _scrollOffset,
              //   right: 0,
              //   height: 150,
              //   child: Container(
              //     decoration: const BoxDecoration(
              //       color: Colors.white,
              //       borderRadius: BorderRadius.only(
              //         bottomLeft: Radius.circular(175),
              //       ),
              //     ),
              //   ),
              // ),
              Positioned(
                top: screenSize.height +
                    (_layer1Speed * _scrollOffset * -1) +
                    150,
                right: 100,
                left: _layer1Speed * (_maxScrollOffset - _scrollOffset),
                height: screenSize.height + 60,
                child: Container(
                  decoration: const BoxDecoration(
                    color: theme.primaryColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: theme.secondaryColor,
                        blurRadius: 5,
                        blurStyle: BlurStyle.solid,
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: screenSize.height +
                    (_layer1Speed * _scrollOffset * -1) +
                    150,
                right: _layer0Speed * (_maxScrollOffset - _scrollOffset),
                left: screenSize.width - 100,
                height: screenSize.height + 60,
                child: Container(
                  decoration: const BoxDecoration(
                    color: theme.secondaryColor,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(25),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: theme.primaryColor,
                        blurRadius: 6,
                        blurStyle: BlurStyle.solid,
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: screenSize.height + (_layer1Speed * _scrollOffset * -1),
                height: screenSize.height + 60,
                right: _layer0Speed * (_maxScrollOffset - _scrollOffset),
                width: 400,
                child: Container(
                  transform: Matrix4.translationValues(
                    -100,
                    200,
                    0.0,
                  ),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: theme.primaryColor.withOpacity(0.75),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black,
                        spreadRadius: -5,
                        offset: const Offset(-5, -5),
                        blurRadius: 30,
                      ),
                      BoxShadow(
                        color: Colors.blue[900]!.withOpacity(.2),
                        spreadRadius: 2,
                        offset: const Offset(7, 7),
                        blurRadius: 20,
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: screenSize.height + (_layer1Speed * _scrollOffset * -1),
                height: screenSize.height + 60,
                right: _layer0Speed * (_maxScrollOffset - _scrollOffset),
                width: 400,
                child: Container(
                  transform: Matrix4.translationValues(
                    -150,
                    -50.0,
                    0.0,
                  ),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: theme.primaryColor.withOpacity(0.75),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black,
                        spreadRadius: -5,
                        offset: const Offset(-5, -5),
                        blurRadius: 30,
                      ),
                      BoxShadow(
                        color: Colors.blue[900]!.withOpacity(.2),
                        spreadRadius: 2,
                        offset: const Offset(7, 7),
                        blurRadius: 20,
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                top: 0,
                left: (_offscreenLayerSpeed * (_scrollOffset)),
                right: 0,
                child: OverflowBox(
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Image.asset("./assets/Images/sideImg.png"),
                  ),
                ),
              ),
              Positioned(
                top: screenSize.height + (.75 * _scrollOffset * -1),
                // bottom:
                //     (_offscreenLayerSpeed * (_maxScrollOffset - _scrollOffset)),
                right: 0,
                left: 0,
                child: Align(
                  alignment: Alignment.topRight,
                  child: Image.asset(
                    './assets/Images/light-1.png',
                    color: theme.secondaryColor,
                  ),
                ),
              ),

              Positioned(
                top: screenSize.height + (.75 * _scrollOffset * -1),
                // bottom:
                //     (_offscreenLayerSpeed * (_maxScrollOffset - _scrollOffset)),
                right: 0,
                left: 200,
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Image.asset(
                    './assets/Images/light-2.png',
                    color: theme.secondaryColor,
                  ),
                ),
              ),

              Positioned(
                bottom: _layer2Speed * _scrollOffset,
                child: Container(
                  decoration: const BoxDecoration(
                    color: Color.fromRGBO(27, 26, 23, 1),
                  ),
                ),
              ),
              Positioned.fill(
                bottom: _layer3Speed * _scrollOffset + 200,
                right: 0,
                left: 0,
                top: -300,
                child: Hero(
                  tag: "Welcome Text",
                  child: Image.asset(
                    "./assets/Images/up_arrow.png",
                    color: theme.primaryColor,
                  ),
                ),
              ),
              Positioned.fill(
                left: (_offscreenLayerSpeed * (_scrollOffset)),
                right: 0,
                top: 500,
                child: Text(
                  "{Company Name}",
                  softWrap: false,
                  maxLines: 1,
                  overflow: TextOverflow.fade,
                  textAlign: TextAlign.right,
                  style: GoogleFonts.balooTamma(
                    textStyle: const TextStyle(
                      fontSize: 34,
                      wordSpacing: 0.0,
                      color: theme.textColor,
                    ),
                  ),
                ),
              ),
              // Positioned(
              //   top: screenSize.height - 175,
              //   right: 0,
              //   left: 0,
              //   child: Image.asset("./assets/Images/layer-1.png"),
              // ),

              // Positioned(
              //   bottom: _layer1Speed * _scrollOffset - 20,
              //   right: 0,
              //   left: 0,
              //   child: Image.asset(
              //     "./assets/Images/grass.png",
              //     color: Color.fromRGBO(61, 61, 61, 1),
              //   ),
              // ),

              // Positioned(
              //   bottom: _layer2Speed * _scrollOffset,
              //   right: 0,
              //   top: 10,
              //   left: screenSize.width - 200,
              //   child: Image.asset(
              //     "./assets/Images/sun.png",
              //     // scale: 10.0,
              //     color: Colors.yellowAccent,
              //   ),
              // ),
              // Positioned.fill(
              //   top:
              //       screenSize.height + (_layer1Speed * _scrollOffset * -1) + 350,
              //   right: 0,
              //   left: 0,
              //   bottom: 0,
              //   // height: screenSize.height * 0.9,
              //   child: Image.asset(
              //     "./assets/Images/background(4).png",
              //   ),
              // ),

              Positioned.fill(
                child: SingleChildScrollView(
                  controller: _scrollController,
                  child: SizedBox(
                    height: layoutHeight,
                  ),
                ),
              ),

              Positioned(
                top: screenSize.height + (_layer1Speed * _scrollOffset * -1),
                right: 0,
                left:
                    (_offscreenLayerSpeed * (_maxScrollOffset - _scrollOffset)),
                height: screenSize.height * 0.9,
                child: Stack(
                  children: [
                    // CarAnim(
                    //   animController: animController,
                    //   width: screenSize.width,
                    // ),
                    LoginScreen(
                      attributes: attributes ?? fileMap,
                      screenSize: screenSize,
                      globalKey: GlobalKey(),
                    ),
                    // Positioned(
                    //   top: 300,
                    //   left: 0,
                    //   right: 0,
                    //   child: Center(
                    //     child: Container(
                    //       height: 500,
                    //       width: 250,
                    //       child: rive.RiveAnimation.asset(
                    //         "assets/animations/logo_Animation.riv",
                    //         fit: BoxFit.contain,
                    //       ),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
