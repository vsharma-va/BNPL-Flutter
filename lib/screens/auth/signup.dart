import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';

import 'signup_login_animation.dart';
import 'components/form_fields.dart';
import 'components/errorSnackBar.dart';
import '../otp.dart';
import '../Home/temp.dart';

class SignUp extends StatefulWidget {
  final AnimationController animController;
  final Size screenSize;
  final GlobalKey globalKey;
  SignUp({
    required this.animController,
    required this.screenSize,
    required this.globalKey,
  });

  @override
  State<SignUp> createState() => _SignUpState(
      animController: animController,
      screenSize: screenSize,
      globalKey: globalKey);
}

class _SignUpState extends State<SignUp> {
  _SignUpState({
    required this.animController,
    required this.screenSize,
    required this.globalKey,
  });

  bool isSignUpScreen = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final AnimationController animController;
  final Size screenSize;
  final GlobalKey globalKey;
  final _emailFormKey = GlobalKey<FormState>();
  final _passwordFormKey = GlobalKey<FormState>();
  late bool isLoading;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    animController.dispose();
    super.dispose();
  }

  Future<void> signOut() async {
    try {
      await Amplify.Auth.signOut(options: SignOutOptions(globalSignOut: true));
      context.showErrorSnackBar(message: "success");
    } on AmplifyException catch (e) {
      context.showErrorSnackBar(message: e.message);
    }
  }

  Future<void> signUp(String emailId, String password) async {
    Map<CognitoUserAttributeKey, String> userAttributes = {
      CognitoUserAttributeKey.email: emailId,
      const CognitoUserAttributeKey.custom("provider"): "Cognito"
    };
    try {
      SignUpResult user = await Amplify.Auth.signUp(
        username: emailId,
        password: password,
        options: CognitoSignUpOptions(userAttributes: userAttributes),
      );
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => OTP(
                emailId: emailId,
                password: password,
              )));
    } on AuthException catch (e) {
      context.showErrorSnackBar(message: e.message);
    }
  }

  Future<void> googleSignUp() async {
    try {
      var res = await Amplify.Auth.signInWithWebUI(
        provider: AuthProvider.google,
      ); //provider: AuthProvider.google);
      if (res.isSignedIn) {
        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (context) => Temp()));
      }
    } on AmplifyException catch (e) {
      context.showErrorSnackBar(message: e.message);
    }
  }

  Future<void> facebookSignUp() async {
    try {
      var res =
          await Amplify.Auth.signInWithWebUI(provider: AuthProvider.facebook);
      if (res.isSignedIn) {
        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: ((context) => Temp())));
      }
    } on AmplifyException catch (e) {
      context.showErrorSnackBar(message: e.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SignUpLoginAnim(
      globalKey: globalKey,
      animController: animController,
      top: (screenSize.height / 2) - (screenSize.height * 0.5) / 2,
      height: screenSize.height * 0.5,
      width: screenSize.width - 40,
      cardChild: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  const Text(
                    "SIGNUP",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 0, 195, 255),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 3),
                    height: 2,
                    width: 75,
                    color: const Color.fromRGBO(53, 56, 57, 1),
                  )
                ],
              ),
              GestureDetector(
                onTap: () {
                  animController.reset();
                  animController.forward();
                },
                child: Column(
                  children: const [
                    Text(
                      "LOGIN",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 102, 101, 101),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Container(
            alignment: Alignment.bottomCenter,
            padding: EdgeInsets.only(
              top: (screenSize.height * 0.05),
              left: 20,
              right: 20,
            ),
            child: Column(
              children: [
                Form(
                  key: _emailFormKey,
                  child: FormFields(
                    controller: emailController,
                    iconData: FontAwesomeIcons.mailBulk,
                    hintText: "Enter Your Email",
                    emptyErrorBool: true,
                    emptyErrorString: 'Input Field Cannot be Empty',
                    minLengthErrorBool: false,
                    minLengthErrorStrict: false,
                    minLength: 0,
                    minLengthErrorString: '',
                    passwordBool: false,
                  ),
                ),
                const SizedBox(height: 10),
                Form(
                  key: _passwordFormKey,
                  child: FormFields(
                    controller: passwordController,
                    iconData: FontAwesomeIcons.userSecret,
                    hintText: "Enter Your Password",
                    emptyErrorBool: true,
                    emptyErrorString: "Input Field Cannot be Empty",
                    minLengthErrorBool: true,
                    minLengthErrorStrict: false,
                    minLength: 6,
                    minLengthErrorString:
                        'Password should atleast be 6 characters long',
                    passwordBool: true,
                  ),
                ),
              ],
            ),
          ),
          Column(
            children: [
              Container(
                alignment: Alignment.bottomCenter,
                padding: const EdgeInsets.only(
                  top: 10,
                ),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    onPrimary: Colors.black,
                  ),
                  onPressed: () {
                    if (_emailFormKey.currentState!.validate() &&
                        _passwordFormKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Processing Data'),
                        ),
                      );
                      signOut();
                      signUp(emailController.text, passwordController.text);
                    }
                  },
                  child: const Text(
                    "Continue",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 102, 101, 101),
                    ),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.bottomCenter,
                child: ElevatedButton.icon(
                  icon: const FaIcon(
                    FontAwesomeIcons.google,
                    color: Colors.red,
                  ),
                  label: const Text(
                    'Sign Up With Google',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 102, 101, 101),
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    onPrimary: Colors.black,
                  ),
                  onPressed: () {
                    googleSignUp();
                  },
                ),
              ),
              Container(
                alignment: Alignment.bottomCenter,
                child: ElevatedButton.icon(
                  icon: const FaIcon(
                    FontAwesomeIcons.facebook,
                    color: Colors.blue,
                  ),
                  label: const Text(
                    'Sign Up With Facebook',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 102, 101, 101),
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    onPrimary: Colors.black,
                  ),
                  onPressed: () {
                    facebookSignUp();
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
