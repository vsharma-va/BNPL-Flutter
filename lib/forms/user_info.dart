import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import './user_info_components/user_name_form.dart';
import '../helper/animations/animated_indexed_stack.dart';
import './user_info_components/pan_card_form.dart';
import '../Home/temp.dart';
import './user_info_components/profession_form.dart';
import '../auth/auth_functions.dart';
import '../theme_data.dart' as theme;
import '../landing_page/landing_page.dart';
import '../helper/page_transitions/back_forward_transition.dart';

class UserForm extends StatefulWidget {
  UserForm({Key? key}) : super(key: key);

  @override
  State<UserForm> createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _panCardController = TextEditingController();
  final GlobalKey globalKey = GlobalKey();
  final _userNameFormKey = GlobalKey<FormState>();
  final _panCardFormKey = GlobalKey<FormState>();
  final GlobalKey _formHousingContainer = GlobalKey();
  final int totalNumberOfForms = 2;
  late List<GlobalKey<FormState>> allFormKeys;
  double currentProgressPercentage = 0.0;
  double previousProgressPercentage = 0.0;
  Map<String, String> userAttributes = {};

  _UserFormState() {
    allFormKeys = [_userNameFormKey, _panCardFormKey];
  }

  var _formIndex = 0;

  void changeFormIndex(BuildContext context) async {
    setState(() {
      _formIndex++;
      previousProgressPercentage = currentProgressPercentage;
      currentProgressPercentage = _formIndex / totalNumberOfForms;
    });
    if (_formIndex == totalNumberOfForms) {
      List<int> lambdaParameters =
          '{"name": "insertcUser",  "userId": "${userAttributes["sub"].toString()}", "userName": "${(_firstNameController.text + " " + _lastNameController.text)}", "userEmail": "${userAttributes["email"]}", "userMobileNo": "1234567890", "userAge": "0", "userCast": "Empty"}'
              .codeUnits;
      AuthFunc.crudFuncOnDb(parameters: lambdaParameters, context: context);
      await Future.delayed(const Duration(milliseconds: 1500), () {});
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: ((context) => Temp())));
    }
  }

  void transitionToHomeScreen() {
    Navigator.pushReplacement(context,
        ForwardOrBackwardTransition(child: Landing_Page(), back: true));
  }

  @override
  void initState() {
    var x = AuthFunc.getUserAttributes(context: context);
    x.then(
      (value) {
        userAttributes = value;
      },
    );
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _panCardController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return SafeArea(
      child: WillPopScope(
        onWillPop: () async {
          transitionToHomeScreen();
          return true;
        },
        child: Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  alignment: Alignment.topLeft,
                  child: BackButton(
                    onPressed: transitionToHomeScreen,
                  ),
                ),
                Container(
                  alignment: Alignment.topLeft,
                  padding: const EdgeInsets.only(
                    left: 35,
                    top: 15,
                  ),
                  child: Text(
                    "$_formIndex/$totalNumberOfForms",
                    style: GoogleFonts.bebasNeue(
                      textStyle: const TextStyle(
                        fontSize: 35,
                        color: theme.primaryColor,
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(25),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: TweenAnimationBuilder<double>(
                        tween: Tween<double>(
                          begin: previousProgressPercentage,
                          end: currentProgressPercentage,
                        ),
                        duration: const Duration(milliseconds: 1500),
                        builder: (context, value, _) => LinearProgressIndicator(
                          minHeight: 20,
                          value: value,
                          backgroundColor:
                              theme.secondaryColor.withOpacity(0.5),
                          valueColor: const AlwaysStoppedAnimation<Color>(
                              theme.primaryColor),
                        ),
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.all(35),
                  child: Stack(
                    fit: StackFit.passthrough,
                    children: [
                      Container(
                        key: _formHousingContainer,
                        padding: const EdgeInsets.only(
                          top: 55,
                          bottom: 55,
                          left: 25,
                          right: 25,
                        ),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: theme.form.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Container(
                          alignment: Alignment.center,
                          child: AnimatedIndexedStack(
                            key: globalKey,
                            index: _formIndex,
                            children: [
                              Form(
                                key: _userNameFormKey,
                                child: UserNameForm(
                                  firstNameController: _firstNameController,
                                  lastNameController: _lastNameController,
                                ),
                              ),
                              Form(
                                key: _panCardFormKey,
                                child: ProfessionForm(),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: theme.backgroundColor,
                            onPrimary: theme.secondaryColor,
                            minimumSize: Size(screenSize.width / 2 - 50, 55),
                            shadowColor: Colors.black,
                            enableFeedback: true,
                            elevation: 15,
                            // shape: RoundedRectangleBorder(
                            //   borderRadius: BorderRadius.circular(25),
                            // ),
                          ),
                          child: Text(
                            'Next',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.bebasNeue(
                              textStyle: const TextStyle(
                                fontSize: 20,
                                color: theme.primaryColor,
                              ),
                            ),
                          ),
                          onPressed: _continueButtonLogic,
                        ),
                      ),
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

  void _continueButtonLogic() {
    if (allFormKeys[_formIndex].currentState!.validate()) {
      changeFormIndex(context);
    }
  }
}
