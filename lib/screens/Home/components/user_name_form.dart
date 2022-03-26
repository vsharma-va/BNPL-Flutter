import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../auth/components/form_fields.dart';
import '../../../theme_data.dart' as theme;

class UserNameForm extends StatelessWidget {
  UserNameForm(
      {required this.firstNameController, required this.lastNameController});

  final TextEditingController firstNameController;
  final TextEditingController lastNameController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(0),
          child: Text(
            "Tell Us Your Name",
            style: GoogleFonts.balooTamma(
              textStyle: const TextStyle(
                color: theme.textColor,
                fontSize: 30,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(0),
          child: Text(
            "Be Exact As Per Your Bank Records",
            style: GoogleFonts.balooTamma(
              textStyle: const TextStyle(
                color: theme.secondaryColor,
                fontSize: 20,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: FormFields(
            controller: firstNameController,
            iconData: FontAwesomeIcons.solidUserCircle,
            labelText: "First Name",
            hintText: "eg. John",
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
          hintText: "eg. Smith",
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
