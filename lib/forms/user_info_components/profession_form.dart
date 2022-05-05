import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../theme_data.dart' as theme;

enum Professions { business, employed, student }

class ProfessionForm extends StatefulWidget {
  @override
  State<ProfessionForm> createState() => _ProfessionFormState();
}

class _ProfessionFormState extends State<ProfessionForm> {
  Professions? _which = Professions.business;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Tell us more about yourself",
          textAlign: TextAlign.center,
          style: GoogleFonts.bebasNeue(
            textStyle: const TextStyle(
              color: theme.textColor,
              fontSize: 30,
            ),
          ),
        ),
        Text(
          "Choose your current profession",
          textAlign: TextAlign.center,
          style: GoogleFonts.bebasNeue(
            textStyle: const TextStyle(
              color: theme.secondaryColor,
              fontSize: 25,
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.only(
            top: 25,
            bottom: 5,
          ),
          child: ListTile(
            enableFeedback: true,
            title: Text(
              "Business",
              style: GoogleFonts.bebasNeue(
                textStyle: const TextStyle(
                  color: theme.textColor,
                  fontSize: 25,
                ),
              ),
            ),
            leading: Radio<Professions>(
              activeColor: theme.primaryColor,
              splashRadius: 25,
              value: Professions.business,
              groupValue: _which,
              onChanged: (Professions? value) {
                setState(() {
                  _which = value;
                });
              },
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.only(
            bottom: 5,
          ),
          child: ListTile(
            title: Text(
              "Employed",
              style: GoogleFonts.bebasNeue(
                textStyle: const TextStyle(
                  color: theme.textColor,
                  fontSize: 25,
                ),
              ),
            ),
            leading: Radio<Professions>(
              activeColor: theme.primaryColor,
              value: Professions.employed,
              splashRadius: 25,
              groupValue: _which,
              onChanged: (Professions? value) {
                setState(() {
                  _which = value;
                });
              },
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.only(
            bottom: 5,
          ),
          child: ListTile(
            title: Text(
              "Student",
              style: GoogleFonts.bebasNeue(
                textStyle: const TextStyle(
                  color: theme.textColor,
                  fontSize: 25,
                ),
              ),
            ),
            leading: Radio<Professions>(
              activeColor: theme.primaryColor,
              value: Professions.student,
              splashRadius: 25,
              groupValue: _which,
              onChanged: (Professions? value) {
                setState(() {
                  _which = value;
                });
              },
            ),
          ),
        ),
      ],
    );
  }
}
