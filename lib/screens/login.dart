import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'auth/login_card.dart';

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
  late AnimationController animController;
  bool isSignUpScreen = true;

  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()
      ..addListener(() {
        _onScroll();
      });
    animController = AnimationController(
        duration: const Duration(milliseconds: 9000), vsync: this)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          animController.reset();
          animController.forward();
        }
      });
    animController.forward();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    animController.dispose();
    super.dispose();
  }

  double _scrollOffset = 0.0;
  void _onScroll() {
    if (mounted) {
      setState(() {
        _scrollOffset = _scrollController.offset;
      });
    }
  }

  Map<String, String>? _nullCheckAttributes() {
    if (attributes == null) {
      return {};
    }
    return attributes;
  }

  final double _layer1Speed = 0.5;
  final double _layer2Speed = 0.75;
  final double _layer3Speed = 0.95;
  final double _layer4Speed = 0.65;

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var layoutHeight = screenSize.height * 2.5;
    return Scaffold(
      body: Container(
        alignment: Alignment.bottomCenter,
        decoration: const BoxDecoration(
          color: Color.fromRGBO(27, 26, 23, 1),
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
            Positioned(
              top: screenSize.height + (_layer4Speed * _scrollOffset * -1),
              right: 0,
              left: 0,
              height: screenSize.height,
              child: Container(
                decoration: const BoxDecoration(
                  color: Color.fromRGBO(27, 26, 23, 1),
                ),
              ),
              // child: Image.asset(
              //   "./assets/Images/semi_background(2).png",
              // color: Color.fromRGBO(137, 137, 137, 1),
              // ),
            ),
            Positioned(
              bottom: _layer1Speed * _scrollOffset - 150,
              right: 0,
              left: 0,
              child: Image.asset(
                "./assets/Images/trees(1).png",
                color: const Color.fromRGBO(228, 88, 38, 1),
              ),
            ),
            Positioned(
              // top: screenSize.height / 2 - (_layer1Speed - 0.3) * _scrollOffset,
              top: screenSize.height + (_layer4Speed * _scrollOffset * -1) + 50,
              child: Container(
                padding: EdgeInsets.only(
                  left: _nullCheckAttributes()!.isEmpty
                      ? fileMap!.isNotEmpty
                          ? screenSize.width / 2 -
                              (3 + fileMap!['email']!.split('@')[0].length * 12)
                          : screenSize.width / 2
                      : screenSize.width / 2 -
                          (3 + attributes!['email']!.split('@')[0].length * 12),
                ),
                child: Text(
                  attributes != null
                      ? "Hi ${attributes!['email']!.split('@')[0].substring(0, 14)}!"
                      // ? "Hi Vaibhav!"
                      : fileMap!.isNotEmpty
                          ? "Hi ${fileMap!['email']!.split('@')[0].substring(0, 14)}!"
                          // ? "Hi Vaibhav!"
                          : "Hi!",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.balooTamma(
                    textStyle: const TextStyle(
                      fontSize: 45,
                      color: Color.fromRGBO(240, 165, 0, 1),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top:
                  screenSize.height + (_layer1Speed * _scrollOffset * -1) + 150,
              right: 0,
              left: 0,
              height: screenSize.height + 60,
              child: Container(
                decoration: const BoxDecoration(
                  color: Color.fromRGBO(228, 88, 38, 1),
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
              bottom: _layer3Speed * _scrollOffset + 150,
              right: 0,
              top: 250,
              child: Text(
                "{Company Name}",
                textAlign: TextAlign.center,
                style: GoogleFonts.balooTamma(
                  textStyle: const TextStyle(
                    fontSize: 45,
                    wordSpacing: 0.0,
                    color: Color.fromRGBO(240, 165, 0, 1),
                  ),
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
                  color: const Color.fromRGBO(228, 88, 38, 1),
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
              top: screenSize.height + (_layer1Speed * _scrollOffset * -1) - 70,
              right: 0,
              left: 0,
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
    );
  }
}
