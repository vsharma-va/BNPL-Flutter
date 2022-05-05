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
                      fontSize: 30,
                      color: theme.textColor,
                    ),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 1),
                child: Text(
                  "Continue With: ",
                  style: GoogleFonts.bebasNeue(
                    textStyle: TextStyle(
                      fontSize: 25,
                      color: theme.textColor.withOpacity(0.5),
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.only(
                      top: servProviderUpperPadding,
                      left: 25,
                      right: 10,
                    ),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: theme.backgroundColor,
                        onPrimary: theme.secondaryColor,
                        minimumSize: Size(50, 50),
                        shadowColor: Colors.black,
                        enableFeedback: true,
                        elevation: 15,
                        // shape: RoundedRectangleBorder(
                        //   borderRadius: BorderRadius.circular(25),
                        // ),
                      ),
                      child: Image.asset(
                        './assets/Images/google_logo_small.png',
                      ),
                      onPressed: () {
                        auth.AuthFunc.googleSignIn(context: context);
                      },
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(
                      top: servProviderUpperPadding,
                      left: 10,
                      right: 10,
                    ),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: theme.backgroundColor,
                        onPrimary: theme.secondaryColor,
                        minimumSize: Size(50, 50),
                        shadowColor: Colors.black,
                        enableFeedback: true,
                        elevation: 15,
                        // shape: RoundedRectangleBorder(
                        //   borderRadius: BorderRadius.circular(25),
                        // ),
                      ),
                      child: Image.asset(
                        './assets/Images/facebook_logo_small.png',
                      ),
                      onPressed: () {
                        auth.AuthFunc.facebookSignIn(context: context);
                      },
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(
                      top: servProviderUpperPadding,
                      left: 10,
                      right: 25,
                    ),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: theme.backgroundColor,
                        onPrimary: theme.secondaryColor,
                        minimumSize: Size(50, 50),
                        shadowColor: Colors.black,
                        enableFeedback: true,
                        elevation: 15,
                        // shape: RoundedRectangleBorder(
                        //   borderRadius: BorderRadius.circular(25),
                        // ),
                      ),
                      child: Image.asset(
                        './assets/Images/coming_soon.png',
                      ),
                      onPressed: () {},
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
