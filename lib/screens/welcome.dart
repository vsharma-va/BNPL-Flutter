import 'dart:developer';
import 'dart:io';

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
    _checkUserStatus();
    _enableLocationService();
    _getLocationPermission();
    _getStoragePermission();
    super.initState();
  }

  void _getStoragePermission() async {
    var status = await Permission.storage.status;
    if (status.isDenied) {
      Map<Permission, PermissionStatus> statuses = await [
        Permission.storage,
      ].request();
      log(statuses[Permission.storage].toString());
    }
    if (status.isPermanentlyDenied) {
      exit(0);
    }
  }

  void _enableLocationService() async {
    var _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        exit(0);
      }
    }
  }

  void _getLocationPermission() async {
    var _permissionGranted = await location.hasPermission();
    log(_permissionGranted.toString() + 'outside if');
    if (_permissionGranted == locationService.PermissionStatus.denied) {
      log(_permissionGranted.toString() + 'inside if');
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        log(_permissionGranted.toString() + 'inside inside if');
      } else {
        exit(0);
      }
    }
  }

  Map<String, String> _readToAMap() {
    Map<String, String> map = {};

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
        body: SingleChildScrollView(
          child: Container(
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              color: theme.backgroundColor,
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
                        color: theme.textColor,
                      ),
                    ),
                  ),
                ),
                const Center(
                    child:
                        CircularProgressIndicator(color: theme.primaryColor)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
