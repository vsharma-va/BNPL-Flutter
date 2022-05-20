import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../theme_data.dart' as theme;
import '../auth/auth_functions.dart' as auth;
import '../helper/page_transitions/back_forward_transition.dart';
import '../landing_page/landing_page.dart';

class RegisterLogin extends StatelessWidget {
  RegisterLogin({required this.isRegister});

  final double servProviderUpperPadding = 55.0;
  final double servProviderLowerPadding = 0.0;
  final bool isRegister;

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return SafeArea(
      child: WillPopScope(
        onWillPop: () async {
          Navigator.pushReplacement(context,
              ForwardOrBackwardTransition(child: Landing_Page(), back: true));
          return true;
        },
        child: Scaffold(
          body: Column(
            children: [
              Container(
                alignment: Alignment.topLeft,
                child: BackButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        ForwardOrBackwardTransition(
                            child: Landing_Page(), back: true));
                  },
                ),
              ),
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
                      './assets/Images/register_login.png',
                    ),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(
                  top: 55,
                  left: 25,
                  right: 25,
                ),
                child: Text(
                  isRegister ? "Let's Get You Set Up!" : "Hello Again !",
                  style: GoogleFonts.bebasNeue(
                    textStyle: const TextStyle(
                      fontSize: 40,
                      color: theme.textColor,
                    ),
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.only(
                      top: servProviderUpperPadding,
                      left: 25,
                      right: 25,
                    ),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: const Color.fromRGBO(66, 133, 244, 1),
                        onPrimary: theme.secondaryColor,
                        shadowColor: Colors.black,
                        enableFeedback: true,
                        elevation: 15,
                        minimumSize: Size(screenSize.width, 50),
                        // shape: RoundedRectangleBorder(
                        //   borderRadius: BorderRadius.circular(25),
                        // ),
                      ),
                      child: Stack(
                        alignment: Alignment.centerLeft,
                        children: [
                          Image.asset(
                            './assets/Images/google_logo_small.png',
                            scale: 1.25,
                          ),
                          Container(
                            alignment: Alignment.center,
                            child: Text(
                              'Continue with Google',
                              style: GoogleFonts.bebasNeue(
                                textStyle: const TextStyle(
                                  fontSize: 25,
                                  color: theme.textColor,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      onPressed: () {
                        auth.AuthFunc.googleSignIn(context: context);
                      },
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(
                      top: 15,
                      left: 25,
                      right: 25,
                    ),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: const Color.fromRGBO(24, 119, 242, 1),
                        onPrimary: theme.secondaryColor,
                        shadowColor: Colors.black,
                        enableFeedback: true,
                        elevation: 15,
                        minimumSize: Size(screenSize.width, 50),
                        // shape: RoundedRectangleBorder(
                        //   borderRadius: BorderRadius.circular(25),
                        // ),
                      ),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Image.asset(
                              './assets/Images/face_logo_white.png',
                              scale: 3.75,
                            ),
                          ),
                          Container(
                            alignment: Alignment.center,
                            child: Text(
                              'Continue with Facebook',
                              style: GoogleFonts.bebasNeue(
                                textStyle: const TextStyle(
                                  fontSize: 25,
                                  color: theme.textColor,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      onPressed: () {
                        auth.AuthFunc.facebookSignIn(context: context);
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
