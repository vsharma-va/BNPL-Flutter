import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../auth/components/form_fields.dart';

class UserNameForm extends StatelessWidget {
  UserNameForm(
      {required this.firstNameController, required this.lastNameController});

  final TextEditingController firstNameController;
  final TextEditingController lastNameController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Let's Get You Set Up",
          style: GoogleFonts.balooTamma(
            textStyle: const TextStyle(color: Colors.white, fontSize: 30),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: FormFields(
            controller: firstNameController,
            iconData: FontAwesomeIcons.solidUserCircle,
            labelText: "First Name",
            hintText: "Enter your first name",
            emptyErrorBool: true,
            emptyErrorString: "First Name field is empty",
            minLengthErrorBool: false,
            minLengthErrorStrict: false,
            minLength: 0,
            minLengthErrorString: "",
            passwordBool: false,
          ),
        ),
        FormFields(
          controller: lastNameController,
          iconData: FontAwesomeIcons.solidUserCircle,
          labelText: "Last Name",
          hintText: "Enter your last name",
          emptyErrorBool: true,
          emptyErrorString: "Last Name field is empty",
          minLengthErrorBool: false,
          minLengthErrorStrict: false,
          minLength: 0,
          minLengthErrorString: "",
          passwordBool: false,
        ),
      ],
    );
  }
}
