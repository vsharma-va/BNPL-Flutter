import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:rive/rive.dart';

class Login extends StatefulWidget {
  final Animation<double> transitionAnimation;

  const Login.main({
    required this.transitionAnimation,
  });

  @override
  State<Login> createState() => _LoginState(this.transitionAnimation);
}

class _LoginState extends State<Login> {
  _LoginState(this.transitionAnimation);
  final Animation<double> transitionAnimation;
  bool isSignUpScreen = true;

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            width: screenSize.width,
            height: screenSize.height,
            decoration: const BoxDecoration(
              color: Color.fromRGBO(53, 56, 57, 1),
            ),
            child: const RiveAnimation.asset(
              "assets/animations/login_background_animation.riv",
              fit: BoxFit.cover,
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 90, left: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Hero(
                  tag: "Welcome Text",
                  child: RichText(
                    text: const TextSpan(
                      text: "Welcome!",
                      style: TextStyle(
                        fontSize: 35,
                        letterSpacing: 2,
                        color: Color.fromARGB(255, 0, 255, 213),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: (screenSize.height / 2) - (screenSize.height * 0.5) / 2,
            child: Container(
              height: screenSize.height * 0.5,
              padding: EdgeInsets.all(20),
              width: screenSize.width - 40,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.all(
                  Radius.circular(15),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 15,
                    spreadRadius: 5,
                  ),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isSignUpScreen = false;
                          });
                        },
                        child: Column(
                          children: [
                            Text(
                              "LOGIN",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: !isSignUpScreen
                                    ? Color.fromARGB(255, 0, 195, 255)
                                    : Color.fromARGB(255, 102, 101, 101),
                              ),
                            ),
                            if (!isSignUpScreen)
                              Container(
                                margin: EdgeInsets.only(top: 3),
                                height: 2,
                                width: 55,
                                color: Color.fromRGBO(53, 56, 57, 1),
                              )
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isSignUpScreen = true;
                          });
                        },
                        child: Column(
                          children: [
                            Text(
                              "SINGUP",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: isSignUpScreen
                                    ? Color.fromARGB(255, 0, 195, 255)
                                    : Color.fromARGB(255, 102, 101, 101),
                              ),
                            ),
                            if (isSignUpScreen)
                              Container(
                                margin: EdgeInsets.only(top: 3),
                                height: 2,
                                width: 55,
                                color: Color.fromRGBO(53, 56, 57, 1),
                              )
                          ],
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: [
                        buildTextField(FontAwesomeIcons.userAstronaut,
                            "User Name", false, false),
                        buildTextField(
                            FontAwesomeIcons.mailchimp, "Email", false, true),
                        buildTextField(
                            FontAwesomeIcons.lock, "Password", true, false),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildTextField(
      var icon, String hintText, bool isPassword, bool isEmail) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: TextField(
        obscureText: isPassword,
        keyboardType: isEmail ? TextInputType.emailAddress : TextInputType.text,
        decoration: InputDecoration(
          prefixIcon: Icon(
            icon,
            color: Color.fromRGBO(53, 56, 57, 1),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Color.fromRGBO(53, 56, 57, 1),
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(35.0),
            ),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Color.fromRGBO(53, 56, 57, 1),
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(35.0),
            ),
          ),
          contentPadding: EdgeInsets.all(10),
          hintText: hintText,
          hintStyle: const TextStyle(
            fontSize: 14,
            color: Color.fromRGBO(53, 56, 57, 1),
          ),
        ),
      ),
    );
  }
}
// Widget build(BuildContext context) {
//   var screenSize = MediaQuery.of(context).size;
//   return Scaffold(
//     backgroundColor: Color.fromRGBO(53, 56, 57, 1),
//     body: Container(
//       height: screenSize.height,
//       child: Column(
//         children: <Widget>[
//           Container(
//             height: screenSize.height * 0.3,
//             alignment: Alignment.center,
//             decoration: const BoxDecoration(
//               color: Colors.amber,
//             ),
//             child: const Hero(
//               tag: "Welcome Text",
//               child: Text(
//                 "Welcome !",
//                 textAlign: TextAlign.center,
//                 style: TextStyle(color: Colors.black, fontSize: 35),
//               ),
//             ),
//           ),
//           const SizedBox(height: 40),
//           Container(
//             height: screenSize.height * 0.7 - 40,
//             alignment: Alignment.center,
//             decoration: const BoxDecoration(
//               color: Colors.black,
//               borderRadius: BorderRadius.only(
//                 topLeft: Radius.circular(20),
//                 topRight: Radius.circular(25),
//               ),
//             ),
//           ),
//         ],
//       ),
//     ),
//   );
