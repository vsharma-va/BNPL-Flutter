import 'package:flutter/material.dart';

import 'FirstScreen/splash.dart';

void main() {
  runApp(BNPL());
}

class BNPL extends StatelessWidget {
  const BNPL({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Splash(),
    );
  }
}
