import 'package:flutter/material.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';

import './login.dart';
import 'Home/temp.dart';

class Welcome extends StatefulWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  void initState() {
    super.initState();
    _checkUserStatus();
  }

  _navigateToLogin() async {
    await Future.delayed(const Duration(milliseconds: 2000), () {});

    Navigator.push(
        context,
        PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 1500),
          pageBuilder: (_, __, ___) => Login(),
        ));
  }

  Future<void> _checkUserStatus() async {
    try {
      final user = await Amplify.Auth.getCurrentUser();
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: ((context) => Temp())));
    } on AuthException catch (e) {
      _navigateToLogin();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            colors: [
              Color.fromRGBO(53, 56, 57, 1),
              Color.fromRGBO(53, 56, 57, 1)
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Hero(
              tag: "Welcome Text",
              child: RichText(
                text: const TextSpan(
                  text: "Welcome!",
                  style: TextStyle(
                    fontSize: 55,
                    letterSpacing: 2,
                    color: Color.fromARGB(255, 0, 255, 213),
                  ),
                ),
              ),
            ),
            const Center(child: CircularProgressIndicator()),
          ],
        ),
      ),
    );
  }
}
