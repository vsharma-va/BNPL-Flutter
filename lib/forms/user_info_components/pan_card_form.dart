import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../parent/form_fields.dart';

class PanCardForm extends StatelessWidget {
  PanCardForm({required this.panCardController});

  final TextEditingController panCardController;

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
            controller: panCardController,
            iconData: FontAwesomeIcons.solidUserCircle,
            labelText: "Pan Number",
            hintText: "Enter your pan number",
            emptyErrorBool: true,
            emptyErrorString: "Pan Number Field is empty",
            minLengthErrorBool: false,
            minLengthErrorStrict: false,
            minLength: 0,
            minLengthErrorString: "",
            passwordBool: false,
          ),
        ),
      ],
    );
  }
}
