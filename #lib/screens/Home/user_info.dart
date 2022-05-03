import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import './components/user_name_form.dart';
import '../components/animated_indexed_stack.dart';
import './components/pan_card_form.dart';
import '../Home/temp.dart';
import './components/profession_form.dart';
import '../auth/components/auth_functions.dart';
import '../../theme_data.dart' as theme;

class UserForm extends StatefulWidget {
  UserForm({Key? key}) : super(key: key);

  @override
  State<UserForm> createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _panCardController = TextEditingController();
  final GlobalKey globalKey = GlobalKey();
  final _userNameFormKey = GlobalKey<FormState>();
  final _panCardFormKey = GlobalKey<FormState>();
  final int totalNumberOfForms = 2;
  Map<String, String> userAttributes = {};

  var _formIndex = 0;

  void changeFormIndex(BuildContext context) {
    setState(() {
      _formIndex++;
    });
    if (_formIndex == totalNumberOfForms) {
      List<int> lambdaParameters =
          '{"name": "insertcUser",  "userId": "${userAttributes["sub"].toString()}", "userName": "${(_firstNameController.text + " " + _lastNameController.text)}", "userEmail": "${userAttributes["email"]}", "userMobileNo": "1234567890", "userAge": "0", "userCast": "Empty"}'
              .codeUnits;
      AuthFunc.crudFuncOnDb(parameters: lambdaParameters, context: context);
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: ((context) => Temp())));
    }
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
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: theme.backgroundColor,
        body: Container(
          child: Stack(
            children: [
              Positioned(
                top: -5,
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(175),
                  ),
                  child: Image.asset(
                    './assets/Images/sideImgRotated.png',
                    // color: theme.secondaryColor,
                  ),
                ),
              ),
              AnimatedIndexedStack(
                key: globalKey,
                index: _formIndex,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Form(
                          key: _userNameFormKey,
                          child: UserNameForm(
                            firstNameController: _firstNameController,
                            lastNameController: _lastNameController,
                          ),
                        ),
                        SizedBox(height: 55),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: theme.primaryColor,
                            onPrimary: theme.secondaryColor,
                            minimumSize: Size(screenSize.width - 10, 55),
                            shadowColor: Colors.black,
                            enableFeedback: true,
                            elevation: 15,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                          ),
                          onPressed: _continueButtonLogic,
                          child: Text(
                            "Continue",
                            style: GoogleFonts.balooTamma(
                              textStyle: const TextStyle(
                                color: theme.textColor,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const ProfessionForm(),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: theme.primaryColor,
                              onPrimary: theme.secondaryColor,
                              minimumSize: Size(screenSize.width - 10, 55),
                              shadowColor: Colors.black,
                              enableFeedback: true,
                              elevation: 15,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                            ),
                            onPressed: () {
                              changeFormIndex(context);
                            },
                            child: Text(
                              "Continue",
                              style: GoogleFonts.balooTamma(
                                textStyle: const TextStyle(
                                  color: theme.textColor,
                                  fontSize: 25,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Form(
                          key: _panCardFormKey,
                          child: PanCardForm(
                            panCardController: _panCardController,
                          ),
                        ),
                        ElevatedButton(
                          onPressed: _continueButtonLogic,
                          child: Text(
                            "Continue",
                            style: GoogleFonts.balooTamma(
                              textStyle: const TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _continueButtonLogic() {
    if (_userNameFormKey.currentState!.validate()) {
      changeFormIndex(context);
    }
  }
}
