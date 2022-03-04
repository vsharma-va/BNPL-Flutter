import 'package:flutter/material.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'components/file_read_write.dart';
import 'package:google_fonts/google_fonts.dart';

import './login.dart';
import 'Home/temp.dart';

class Welcome extends StatefulWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  Map<String, String> map = {};
  @override
  void initState() {
    super.initState();
    _checkUserStatus();
  }

  Map<String, String> _readToAMap() {
    Map<String, String> map = {};

    readDetails().then((value) {
      var x = value.split(' ');
      if (x.length > 1) {
        map['email'] = x[0];
        map['identities'] = x[1];
      }
      print(map);
      return map;
    });

    return map;
  }

  _navigateToLogin() async {
    map = _readToAMap();
    await Future.delayed(const Duration(milliseconds: 6000), () {});
    print(map);
    Navigator.push(
        context,
        PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 1500),
          pageBuilder: (_, __, ___) => Login(
            fileMap: map,
          ),
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
              Color.fromRGBO(34, 0, 50, 1),
              Color.fromRGBO(228, 173, 58, 1),
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Hero(
              tag: "Welcome Text",
              child: Text(
                'Welcome !',
                style: GoogleFonts.balooTamma(
                  textStyle: const TextStyle(
                    fontSize: 45,
                    color: Colors.white,
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
