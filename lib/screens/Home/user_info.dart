import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import './components/user_name_form.dart';
import '../components/animated_indexed_stack.dart';
import './components/pan_card_form.dart';
import '../Home/temp.dart';

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

  var _formIndex = 0;

  void changeFormIndex(BuildContext context) {
    setState(() {
      _formIndex++;
    });
    if (_formIndex == totalNumberOfForms) {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: ((context) => Temp())));
    }
    print(_formIndex);
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color.fromRGBO(67, 67, 67, 1),
      body: Container(
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(175),
              ),
              child: Image.asset(
                './assets/Images/background(5).png',
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
                        onPressed: () {
                          if (_userNameFormKey.currentState!.validate()) {
                            changeFormIndex(context);
                          }
                        },
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
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Form(
                        key: _panCardFormKey,
                        child: PanCardForm(
                          panCardController: _panCardController,
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          if (_panCardFormKey.currentState!.validate()) {
                            changeFormIndex(context);
                          }
                        },
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
}
