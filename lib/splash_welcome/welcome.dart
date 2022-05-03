import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:location/location.dart' as locationService;

import '../landing_page/landing_page.dart';
import '../helper/page_transitions/left_right_transition.dart';
import '../forms/user_info.dart';
import '../main/theme_data.dart' as theme;
import '../helper/animations/out_of_screen_right.dart';

class Welcome extends StatefulWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> with SingleTickerProviderStateMixin {
  Map<String, String> map = {};
  late AnimationController animController;
  var location = locationService.Location();

  @override
  void initState() {
    _enableLocationService();
    _checkUserStatus();
    _checkPermissions();
    animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );
    super.initState();
  }

  @override
  void dispose() {
    animController.dispose();
    super.dispose();
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

  void _navigateToLogin() async {
    await Future.delayed(const Duration(milliseconds: 2500), () {});
    animController.forward();
    await Future.delayed(const Duration(milliseconds: 1000), () {});
    Navigator.pushReplacement(
        context, LeftToRightPageRoute(child: Landing_Page()));
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
              RightOutAnim(
                animController: animController,
                width: MediaQuery.of(context).size.width,
                child1: Text(
                  'Welcome !',
                  style: GoogleFonts.bebasNeue(
                    textStyle: const TextStyle(
                      fontSize: 45,
                      color: theme.textColor,
                    ),
                  ),
                ),
              ),
              Center(
                child: RightOutAnim(
                  animController: animController,
                  width: MediaQuery.of(context).size.width,
                  child1: const CircularProgressIndicator(
                    color: theme.primaryColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
