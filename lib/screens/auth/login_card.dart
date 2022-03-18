import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import '../auth/components/auth_functions.dart';

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
      left: screenSize.width / 2 - 168,
      height: screenSize.height * 0.5,
      width: screenSize.width - 40,
      child: Center(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: Column(
                children: [
                  if (_nullCheckAttributes()!.isNotEmpty)
                    if (attributes!['identities']!.contains('Google'))
                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          primary: const Color.fromRGBO(27, 26, 23, 1),
                          onPrimary: const Color.fromRGBO(240, 165, 0, 1),
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
                              color: Color.fromRGBO(240, 165, 0, 1),
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
                                color: Color.fromRGBO(240, 165, 0, 1),
                              ),
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            primary: const Color.fromRGBO(27, 26, 23, 1),
                            onPrimary: const Color.fromRGBO(240, 165, 0, 1),
                          ),
                          onPressed: () {
                            AuthFunc.facebookSignIn(context);
                          },
                        ),
                      ),
                  if (_nullCheckAttributes()!.isEmpty)
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        primary: const Color.fromRGBO(27, 26, 23, 1),
                        onPrimary: const Color.fromRGBO(240, 165, 0, 1),
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
                            color: Color.fromRGBO(240, 165, 0, 1),
                          ),
                        ),
                      ),
                      onPressed: () {
                        AuthFunc.googleSignIn(context: context);
                      },
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
                              color: Color.fromRGBO(240, 165, 0, 1),
                            ),
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: const Color.fromRGBO(27, 26, 23, 1),
                          onPrimary: const Color.fromRGBO(240, 165, 0, 1),
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
