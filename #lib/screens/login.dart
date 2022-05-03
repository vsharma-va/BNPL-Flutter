import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_sms_inbox/flutter_sms_inbox.dart';

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
  final List<String> keywordsForSms = [
    'transaction',
    'credited',
    'debited',
    'account',
    'OTP',
    'payment'
  ];
  double maxScrollOffset = 0.0;
  bool isSignUpScreen = true;

  late ScrollController _scrollController;

  Future<void> _getAllSms() async {
    var query = SmsQuery();
    List<SmsMessage> messages = await query.getAllSms;
    for (int i = 0; i < messages.length; i++) {
      if (keywordsForSms.any(
          (item) => messages[i].body.toString().toLowerCase().contains(item))) {
        log(messages[i].body.toString());
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _getAllSms();
    _scrollController = ScrollController()
      ..addListener(() {
        maxScrollOffset = _scrollController.position.maxScrollExtent;
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
    }
  }

  Map<String, String>? _nullCheckAttributes() {
    if (attributes == null) {
      return {};
    }
    return attributes;
  }

  final double _layer0Speed = 0.35;
  final double _layer1Speed = 0.5;
  final double _layer2Speed = 0.75;
  final double _layer3Speed = 0.95;
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

          // ClipRect(child: BackdropFilter(
          //     filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
          child: Column(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: const [
                    BoxShadow(
                      spreadRadius: -9,
                      color: Colors.grey,
                      blurRadius: 1,
                      blurStyle: BlurStyle.normal,
                    ),
                  ],
                ),
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: Image.asset(
                      './assets/Images/borrowing.png',
                    ),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(
                  top: 45,
                  left: 65,
                  right: 65,
                ),
                child: Text(
                  'Borrowing Made Easier!',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.bebasNeue(
                    textStyle: const TextStyle(
                      fontSize: 40,
                      color: theme.textColor,
                    ),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(
                  top: 10,
                  left: 35,
                  right: 35,
                ),
                child: Text(
                  'A Carefully crafted experience to remove all the pain points which generally come with borrowing money',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.bebasNeue(
                    textStyle: TextStyle(
                      fontSize: 25,
                      color: theme.textColor.withOpacity(0.5),
                    ),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(
                  top: 15,
                  left: 25,
                  right: 25,
                ),
                width: screenSize.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: theme.backgroundColor,
                        onPrimary: theme.secondaryColor,
                        minimumSize: Size(screenSize.width / 2 - 50, 55),
                        shadowColor: Colors.black,
                        enableFeedback: true,
                        elevation: 15,
                        // shape: RoundedRectangleBorder(
                        //   borderRadius: BorderRadius.circular(25),
                        // ),
                      ),
                      child: Text(
                        'Register',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.bebasNeue(
                          textStyle: const TextStyle(
                            fontSize: 20,
                            color: theme.primaryColor,
                          ),
                        ),
                      ),
                      onPressed: () {},
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: theme.backgroundColor,
                        onPrimary: theme.secondaryColor,
                        minimumSize: Size(screenSize.width / 2 - 50, 55),
                        shadowColor: Colors.black,
                        enableFeedback: true,
                        elevation: 15,
                        // shape: RoundedRectangleBorder(
                        //   borderRadius: BorderRadius.circular(25),
                        // ),
                      ),
                      onPressed: null,
                      child: Text(
                        'Login',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.bebasNeue(
                          textStyle: const TextStyle(
                            fontSize: 20,
                            color: theme.backgroundColor,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),

              // Positioned(
              //   top: screenSize.height + (_layer1Speed * _scrollOffset * -1),
              //   right: 0,
              //   left:
              //       (_offscreenLayerSpeed * (maxScrollOffset - _scrollOffset)),
              //   height: screenSize.height * 0.9,
              //   child: Stack(
              //     children: [
              //       // CarAnim(
              //       //   animController: animController,
              //       //   width: screenSize.width,
              //       // ),
              //       LoginScreen(
              //         attributes: attributes ?? fileMap,
              //         screenSize: screenSize,
              //         globalKey: GlobalKey(),
              //       ),
              //       // Positioned(
              //       //   top: 300,
              //       //   left: 0,
              //       //   right: 0,
              //       //   child: Center(
              //       //     child: Container(
              //       //       height: 500,
              //       //       width: 250,
              //       //       child: rive.RiveAnimation.asset(
              //       //         "assets/animations/logo_Animation.riv",
              //       //         fit: BoxFit.contain,
              //       //       ),
              //       //     ),
              //       //   ),
              //       // ),
              //     ],
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
