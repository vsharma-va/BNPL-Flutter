import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'dart:async';

import 'auth/components/errorSnackBar.dart';
import 'Home/temp.dart';

class OTP extends StatefulWidget {
  OTP({required this.emailId, required this.password});

  final String emailId;
  final String password;

  @override
  _OTPState createState() => _OTPState(emailId: emailId, password: password);
}

class _OTPState extends State<OTP> {
  _OTPState({required this.emailId, required this.password});

  final String emailId;
  final String password;

  final _formKey = GlobalKey<FormState>();
  TextEditingController textController = TextEditingController();
  StreamController<ErrorAnimationType>? errorController;

  @override
  void initState() {
    errorController = StreamController<ErrorAnimationType>();
    super.initState();
  }

  @override
  void dispose() {
    errorController!.close();

    super.dispose();
  }

  Future<void> confirmEmailId(String otp) async {
    SignUpResult user;
    try {
      user = await Amplify.Auth.confirmSignUp(
        username: emailId,
        confirmationCode: otp,
      );
      await Amplify.Auth.signIn(username: emailId, password: password);
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) => Temp()));
    } on AuthException catch (e) {
      context.showErrorSnackBar(message: e.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(53, 56, 57, 1),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            alignment: Alignment.center,
            child: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 8.0,
                  horizontal: 30,
                ),
                child: PinCodeTextField(
                  onChanged: ((value) {}),
                  appContext: context,
                  pastedTextStyle: const TextStyle(
                    color: Color.fromARGB(255, 0, 195, 255),
                    fontWeight: FontWeight.bold,
                  ),
                  length: 6,
                  obscureText: true,
                  obscuringCharacter: '*',
                  blinkWhenObscuring: true,
                  animationType: AnimationType.fade,
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.box,
                    borderRadius: BorderRadius.circular(5),
                    fieldHeight: 50,
                    fieldWidth: 40,
                    activeFillColor: Colors.white,
                    inactiveColor: const Color.fromARGB(255, 255, 255, 255),
                    inactiveFillColor: const Color.fromARGB(255, 0, 195, 255),
                    activeColor: Colors.black,
                    selectedFillColor: const Color.fromARGB(255, 0, 195, 255),
                    selectedColor: Colors.black,
                  ),
                  cursorColor: Colors.black,
                  animationDuration: const Duration(milliseconds: 300),
                  enableActiveFill: true,
                  errorAnimationController: errorController,
                  controller: textController,
                  keyboardType: TextInputType.number,
                  boxShadows: const [
                    BoxShadow(
                      offset: Offset(0, 1),
                      color: Colors.black12,
                      blurRadius: 10,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            child: ElevatedButton(
              child: const Text(
                "Confirm",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              onPressed: () {
                confirmEmailId(textController.text);
              },
            ),
          ),
        ],
      ),
    );
  }
}
