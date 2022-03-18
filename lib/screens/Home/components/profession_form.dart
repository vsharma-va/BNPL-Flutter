import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfessionForm extends StatelessWidget {
  const ProfessionForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "Tell us more about yourself",
          style: GoogleFonts.balooTamma(
            textStyle: const TextStyle(
              color: Color.fromRGBO(240, 165, 0, 1),
              fontSize: 25,
            ),
          ),
        ),
        Text(
          "Choose your current profession",
          style: GoogleFonts.balooTamma(
            textStyle: const TextStyle(
              color: Color.fromRGBO(228, 88, 38, 1),
              fontSize: 20,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10),
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(250, 45),
            ),
            icon: const Icon(
              FontAwesomeIcons.bookOpen,
              color: Colors.black87,
            ),
            onPressed: () {},
            label: Text(
              "Student",
              style: GoogleFonts.balooTamma(
                textStyle: const TextStyle(
                  color: Colors.black87,
                  fontSize: 25,
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10),
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(250, 45),
            ),
            icon: const Icon(
              FontAwesomeIcons.cashRegister,
              color: Colors.black87,
            ),
            onPressed: () {},
            label: Text(
              "Salaried",
              style: GoogleFonts.balooTamma(
                textStyle: const TextStyle(
                  color: Colors.black87,
                  fontSize: 25,
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10),
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(250, 45),
            ),
            icon: const Icon(
              FontAwesomeIcons.building,
              color: Colors.black87,
            ),
            onPressed: () {},
            label: Text(
              "Self Employed",
              style: GoogleFonts.balooTamma(
                textStyle: const TextStyle(
                  color: Colors.black87,
                  fontSize: 25,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
