import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import './components/user_name_form.dart';
import '../components/animated_indexed_stack.dart';
import './components/pan_card_form.dart';
import '../Home/temp.dart';
import './components/profession_form.dart';
import '../auth/components/auth_functions.dart';

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
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color.fromRGBO(27, 26, 23, 1),
      body: Container(
        child: Stack(
          children: [
            Positioned(
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(175),
                ),
                child: Image.asset(
                  './assets/Images/trees(1).png',
                  color: const Color.fromRGBO(228, 88, 38, 1),
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
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          onPrimary: Color.fromRGBO(27, 26, 23, 1),
                        ),
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
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ProfessionForm(),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            onPrimary: Color.fromRGBO(27, 26, 23, 1),
                          ),
                          onPressed: () {
                            changeFormIndex(context);
                          },
                          child: Text(
                            "Continue",
                            style: GoogleFonts.balooTamma(
                              textStyle: TextStyle(
                                color: Colors.black,
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
    );
  }

  void _continueButtonLogic() {
    if (_userNameFormKey.currentState!.validate()) {
      changeFormIndex(context);
    }
  }
}
