import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'components/file_read_write.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:location/location.dart' as locationService;

import './login.dart';
import 'Home/user_info.dart';
import '../theme_data.dart' as theme;

class Welcome extends StatefulWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  Map<String, String> map = {};
  var location = locationService.Location();

  @override
  void initState() {
    _enableLocationService();
    _checkUserStatus();
    _checkPermissions();
    super.initState();
  }

  Future<void> _checkPermissions() async {
    var status = await Permission.location.status;
    if (!status.isGranted) {
      var status = await Permission.location.request();
      if (status.isGranted) {
        var status = await Permission.sms.status;
        if (!status.isGranted) {
          var status = await Permission.sms.request();
          if (status.isGranted) {
            var status = await Permission.storage.status;
            if (!status.isGranted) {
              var status = await Permission.storage.request();
              if (status.isGranted) {
                log("all permissions granted");
              }
            }
          } else {
            return;
          }
        }
      } else {
        return;
      }
    }
  }

  Future<void> _enableLocationService() async {
    var _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }
  }

  // this function reads the file the app writes when the user signsout,
  // this enables me to lock the user into using the same account they signed up
  // with
  Map<String, String> _readToAMap() {
    Map<String, String> map = {};
    // the file contains the data in the form
    // email auth_provider
    readDetails().then((value) {
      var x = value.split(' ');
      if (x.length > 1) {
        map['email'] = x[0];
        map['identities'] = x[1];
      }
      log(map.toString());
      return map;
    });

    return map;
  }

  void _navigateToLogin() async {
    map = _readToAMap();
    await Future.delayed(const Duration(milliseconds: 2500), () {});
    log(map.toString());
    Navigator.push(
        context,
        PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 3000),
          pageBuilder: (_, __, ___) => Login(
            fileMap: map,
          ),
        ));
  }

  // if the user is signed in they are sent to the userform screen (for now)
  // else they are sent to the login screen
  Future<void> _checkUserStatus() async {
    try {
      AuthSession user = await Amplify.Auth.fetchAuthSession();
      if (user.isSignedIn) {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: ((context) => UserForm())));
      } else {
        _navigateToLogin();
      }
    } catch (e) {
      _navigateToLogin();
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Container(
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            color: theme.backgroundColor,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Hero(
                tag: "welcome-text",
                child: Text(
                  'Welcome !',
                  style: GoogleFonts.balooTamma(
                    textStyle: const TextStyle(
                      fontSize: 45,
                      color: theme.textColor,
                    ),
                  ),
                ),
              ),
              const Center(
                child: CircularProgressIndicator(color: theme.primaryColor),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
