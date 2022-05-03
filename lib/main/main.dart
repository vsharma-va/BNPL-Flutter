import 'package:flutter/material.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:camera/camera.dart';

import 'amplifyconfiguration.dart';
import '../splash_welcome/splash.dart';
import '../auth/errorSnackBar.dart';
import './theme_data.dart' as theme;

// main function of the app
late List<CameraDescription> cameras;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  runApp(BNPL());
}

class BNPL extends StatefulWidget {
  const BNPL({Key? key}) : super(key: key);

  @override
  State<BNPL> createState() => _BNPLState();
}

// widget used to initialize cognito
class _BNPLState extends State<BNPL> {
  bool _amplifyConfigured = false;

  @override
  void initState() {
    super.initState();
    _configureAmplify();
  }

  Future<void> _configureAmplify() async {
    try {
      await Amplify.addPlugins([AmplifyAuthCognito()]);
      await Amplify.configure(amplifyconfig);
      setState(() {
        _amplifyConfigured = true;
      });
    } catch (e) {
      context.showErrorSnackBar(message: e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ThemeData().colorScheme.copyWith(
              primary: theme.secondaryColor,
            ),
      ),
      // Splash() class contains the splash screen animation playback code
      home: const Splash(),
    );
  }
}
