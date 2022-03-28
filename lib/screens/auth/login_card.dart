import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import '../auth/components/auth_functions.dart';
import '../../theme_data.dart' as theme;

class LoginScreen extends StatefulWidget {
  final Size screenSize;
  final GlobalKey globalKey;
  final Map<String, String>? attributes;
  LoginScreen({
    required this.screenSize,
    required this.globalKey,
    required this.attributes,
  });

  @override
  State<LoginScreen> createState() => _LoginScreenState(
      screenSize: screenSize, globalKey: globalKey, attributes: attributes);
}

class _LoginScreenState extends State<LoginScreen> {
  _LoginScreenState({
    required this.screenSize,
    required this.globalKey,
    required this.attributes,
  });

  bool isSignUpScreen = false;
  final Size screenSize;
  final Map<String, String>? attributes;
  final GlobalKey globalKey;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  late bool isLoading;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Map<String, String>? _nullCheckAttributes() {
    if (attributes == null) {
      return {};
    }
    return attributes;
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: (screenSize.height / 2) - (screenSize.height * 0.5) / 2,
      left: 20,
      height: screenSize.height * 0.5,
      width: screenSize.width - 40,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.bottomLeft,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (_nullCheckAttributes()!.isNotEmpty)
                    if (attributes!['identities']!.contains('Google'))
                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          // primary: theme.backgroundColor,
                          primary: theme.backgroundColor,
                          onPrimary: theme.secondaryColor,
                          minimumSize: Size(screenSize.width - 10, 55),
                          // shadowColor: theme.secondaryColor,
                          shadowColor: Colors.black,
                          enableFeedback: true,
                          elevation: 15,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                        icon: const FaIcon(
                          FontAwesomeIcons.google,
                          color: Colors.red,
                        ),
                        label: Text(
                          'Continue With Google',
                          style: GoogleFonts.balooTamma(
                            textStyle: const TextStyle(
                              fontSize: 20,
                              color: theme.textColor,
                            ),
                          ),
                        ),
                        onPressed: () {
                          AuthFunc.googleSignIn(context: context);
                        },
                      ),
                  if (_nullCheckAttributes()!.isNotEmpty)
                    if (attributes!['identities']!.contains('Facebook'))
                      Container(
                        alignment: Alignment.bottomCenter,
                        child: ElevatedButton.icon(
                          icon: const FaIcon(
                            FontAwesomeIcons.facebook,
                            color: Colors.blue,
                          ),
                          label: Text(
                            'Continue With Facebook',
                            style: GoogleFonts.balooTamma(
                              textStyle: const TextStyle(
                                fontSize: 20,
                                color: theme.textColor,
                              ),
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            primary: theme.backgroundColor,
                            onPrimary: theme.secondaryColor,
                            minimumSize: Size(screenSize.width - 10, 55),
                            shadowColor: Colors.black,
                            enableFeedback: true,
                            elevation: 15,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                          ),
                          onPressed: () {
                            AuthFunc.facebookSignIn(context);
                          },
                        ),
                      ),
                  if (_nullCheckAttributes()!.isEmpty)
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        primary: theme.backgroundColor,
                        onPrimary: theme.secondaryColor,
                        minimumSize: Size(screenSize.width - 10, 55),
                        shadowColor: Colors.black,
                        enableFeedback: true,
                        elevation: 15,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                      icon: const FaIcon(
                        FontAwesomeIcons.google,
                        color: Colors.red,
                      ),
                      label: Text(
                        'Continue With Google',
                        style: GoogleFonts.balooTamma(
                          textStyle: const TextStyle(
                            fontSize: 20,
                            color: theme.textColor,
                          ),
                        ),
                      ),
                      onPressed: () {
                        AuthFunc.googleSignIn(context: context);
                      },
                    ),
                  SizedBox(
                    height: 12,
                  ),
                  if (_nullCheckAttributes()!.isEmpty)
                    Container(
                      alignment: Alignment.bottomCenter,
                      child: ElevatedButton.icon(
                        icon: const FaIcon(
                          FontAwesomeIcons.facebook,
                          color: Colors.blue,
                        ),
                        label: Text(
                          'Continue With Facebook',
                          style: GoogleFonts.balooTamma(
                            textStyle: const TextStyle(
                              fontSize: 20,
                              color: theme.textColor,
                            ),
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: theme.backgroundColor,
                          onPrimary: theme.secondaryColor,
                          minimumSize: Size(screenSize.width - 10, 55),
                          shadowColor: Colors.black,
                          enableFeedback: true,
                          elevation: 15,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                        onPressed: () {
                          AuthFunc.facebookSignIn(context);
                        },
                      ),
                    ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
