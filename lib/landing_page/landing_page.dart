import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_sms_inbox/flutter_sms_inbox.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:intl/intl.dart';

import '../theme_data.dart' as theme;
import '../helper/page_transitions/back_forward_transition.dart';
import '../register_login/register_or_login.dart';

class Landing_Page extends StatefulWidget {
  Landing_Page({this.attributes, this.fileMap});
  final Map<String, String>? attributes;
  final Map<String, String>? fileMap;
  @override
  State<Landing_Page> createState() => Landing_Page_State();
}

class Landing_Page_State extends State<Landing_Page> {
  // final List<String> keywordsForSms = [
  //   'transaction',
  //   'credited',
  //   'debited',
  //   'account',
  //   'OTP',
  //   'payment',
  //   'credit',
  //   'debit',
  //   'reversal',
  //   'refund',
  //   'credit card',
  //   'spent',
  //   'reversed',
  //   ''
  // ];
  double maxScrollOffset = 0.0;
  bool isSignUpScreen = true;

  Future<void> _navigateToForms({required bool isRegister}) async {
    Navigator.pushReplacement(
        context,
        ForwardOrBackwardTransition(
            child: RegisterLogin(
          isRegister: isRegister,
        )));
  }

  Future<void> _getAllSms() async {
    var query = SmsQuery();
    List<SmsMessage> messages = await query.getAllSms;
    for (int i = 0; i < messages.length; i++) {
      DateTime now = DateTime.now();
      var formatter = DateFormat('dd-MM-yyyy');
      String formattedDate = formatter.format(now);
      var dateSplit = formattedDate.split('-');
      var date = DateTime(int.parse(dateSplit[2]), int.parse(dateSplit[1]),
          int.parse(dateSplit[0]));
      var threeMonthsPriorDate = DateTime(date.year, date.month - 3, date.day);
      var threeMonthsPriorDateString = formatter.format(threeMonthsPriorDate);

      if (int.parse(messages[i].date!.month.toString()) >=
              int.parse(threeMonthsPriorDateString.split('-')[1]) &&
          int.parse(messages[i].date!.month.toString()) <=
              int.parse(dateSplit[1])) {
        var regEx = RegExp(r'[a-zA-Z0-9]{2}-[a-zA-Z0-9]{6}');
        var allMatches = regEx
            .allMatches(messages[i].sender.toString())
            .map((z) => z.group(0))
            .toList();
        log(allMatches.toString());
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _getAllSms();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async => false,
      child: SafeArea(
        child: Scaffold(
          body: Container(
            alignment: Alignment.bottomCenter,
            decoration: const BoxDecoration(
              color: theme.backgroundColor,
              // gradient: LinearGradient(
              //   begin: Alignment.topCenter,
              //   colors: [
              //     Colors.white,
              //     Colors.black,
              //   ],
              // ),
            ),

            // ClipRect(child: BackdropFilter(
            //     filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
            child: Column(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: const [
                      BoxShadow(
                        spreadRadius: -9,
                        color: Colors.grey,
                        blurRadius: 1,
                        blurStyle: BlurStyle.normal,
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(25),
                      child: Image.asset(
                        './assets/Images/borrowing.png',
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(
                    top: 45,
                    left: 65,
                    right: 65,
                  ),
                  child: Text(
                    'Borrowing Made Easier!',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.bebasNeue(
                      textStyle: const TextStyle(
                        fontSize: 40,
                        color: theme.textColor,
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(
                    top: 10,
                    left: 35,
                    right: 35,
                  ),
                  height: 110,
                  child: DefaultTextStyle(
                    textAlign: TextAlign.center,
                    style: GoogleFonts.bebasNeue(
                      textStyle: TextStyle(
                        fontSize: 25,
                        color: theme.textColor.withOpacity(0.5),
                      ),
                    ),
                    child: AnimatedTextKit(
                      repeatForever: true,
                      animatedTexts: [
                        RotateAnimatedText(
                            "Borrow from the comfort of your home",
                            textAlign: TextAlign.center),
                        RotateAnimatedText("Paper less process"),
                        RotateAnimatedText("Takes less than 10 minutes"),
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(
                    top: 15,
                    left: 25,
                    right: 25,
                  ),
                  width: screenSize.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: theme.backgroundColor,
                          onPrimary: theme.secondaryColor,
                          minimumSize: Size(screenSize.width / 2 - 50, 55),
                          shadowColor: Colors.black,
                          enableFeedback: true,
                          elevation: 25,
                          // shape: RoundedRectangleBorder(
                          //   borderRadius: BorderRadius.circular(25),
                          // ),
                        ),
                        child: Text(
                          'Register',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.bebasNeue(
                            textStyle: const TextStyle(
                              fontSize: 20,
                              color: theme.primaryColor,
                            ),
                          ),
                        ),
                        onPressed: () {
                          _navigateToForms(isRegister: true);
                        },
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.grey,
                          minimumSize: Size(screenSize.width / 2 - 50, 55),
                          elevation: 0,
                          // shape: RoundedRectangleBorder(
                          //   borderRadius: BorderRadius.circular(25),
                          // ),
                        ),
                        onPressed: () => _navigateToForms(isRegister: false),
                        child: Text(
                          'Login',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.bebasNeue(
                            textStyle: const TextStyle(
                              fontSize: 20,
                              color: theme.backgroundColor,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
