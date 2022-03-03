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

class _LoginState extends State<Login> {
  _LoginState({this.attributes, this.fileMap});
  final Map<String, String>? attributes;
  final Map<String, String>? fileMap;
  bool isSignUpScreen = true;

  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()
      ..addListener(() {
        _onScroll();
      });
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
  final double _layer2Speed = 0.4;

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var layoutHeight = screenSize.height * 2.5;
    return Scaffold(
      body: Container(
        alignment: Alignment.bottomCenter,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            colors: [
              Color.fromRGBO(34, 0, 50, 1),
              Color.fromRGBO(228, 173, 58, 1),
            ],
          ),
        ),
        child: Stack(
          children: <Widget>[
            Positioned(
              bottom: _layer2Speed * _scrollOffset + 120,
              right: 0,
              left: screenSize.width - 100,
              child: Image.asset(
                "./assets/Images/sun.png",
                scale: 10.0,
              ),
            ),
            Positioned(
              bottom: _layer1Speed * _scrollOffset + 50,
              right: 0,
              left: 0,
              child: Image.asset("./assets/Images/buildings (1).png"),
            ),
            Positioned(
              top: screenSize.height + (_layer1Speed * _scrollOffset * -1) - 60,
              right: 0,
              left: 0,
              height: screenSize.height + 60,
              child: Container(
                decoration: const BoxDecoration(
                  color: Color.fromRGBO(34, 0, 50, 1),
                ),
              ),
            ),
            Positioned(
              top: screenSize.height / 2 - (_layer1Speed - 0.3) * _scrollOffset,
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
                      ? "Hi ${attributes!['email']!.split('@')[0]}!"
                      // : "Hi ${fileMap['email']!.split('@')[0]};",
                      : fileMap!.isNotEmpty
                          ? "Hi ${fileMap!['email']!.split('@')[0]}!"
                          : "Hi!",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.balooTamma(
                    textStyle: const TextStyle(
                      fontSize: 45,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
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
                  LoginScreen(
                    attributes: attributes ?? fileMap,
                    screenSize: screenSize,
                    globalKey: GlobalKey(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
