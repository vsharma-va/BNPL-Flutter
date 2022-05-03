import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../main/theme_data.dart' as theme;

class FormFields extends StatelessWidget {
  FormFields({
    required this.controller,
    required this.iconData,
    required this.labelText,
    required this.hintText,
    required this.emptyErrorBool,
    required this.emptyErrorString,
    required this.minLengthErrorBool,
    required this.minLengthErrorStrict,
    required this.minLength,
    required this.minLengthErrorString,
    required this.passwordBool,
  });

  final TextEditingController controller;
  final IconData? iconData;
  final bool emptyErrorBool;
  final bool minLengthErrorBool;
  final bool minLengthErrorStrict;
  final bool passwordBool;
  final int minLength;
  final String emptyErrorString;
  final String minLengthErrorString;
  final String hintText;
  final String labelText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      // controller: phoneController,
      controller: this.controller,
      obscureText: passwordBool ? true : false,
      enableSuggestions: passwordBool ? false : true,
      autocorrect: passwordBool ? false : true,
      keyboardType:
          passwordBool ? TextInputType.text : TextInputType.emailAddress,
      style: GoogleFonts.balooTamma(
        textStyle: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.normal,
            color: theme.textColor),
      ),
      decoration: InputDecoration(
        labelText: '$labelText*',
        labelStyle: GoogleFonts.balooTamma(
          textStyle: const TextStyle(
              // field name colour
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: theme.secondaryColor),
        ),
        floatingLabelStyle: GoogleFonts.balooTamma(
          textStyle: const TextStyle(
              // field name colour when the text field is selected
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: theme.secondaryColor),
        ),
        hintText: '$hintText',
        hintStyle: GoogleFonts.balooTamma(
          textStyle: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.normal,
              color: Color.fromARGB(255, 133, 133, 133)),
        ),
        prefixIcon: Icon(
          iconData,
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            width: 3,
            // default field outline colour
            color: theme.primaryColor,
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            width: 3,
            color: theme.secondaryColor,
          ),
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(15),
            topLeft: Radius.circular(15),
          ),
        ),
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            width: 3,
            color: Color.fromARGB(255, 194, 25, 25),
          ),
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(15),
            topLeft: Radius.circular(15),
          ),
        ),
        focusedErrorBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            width: 3,
            color: Color.fromARGB(255, 212, 20, 20),
          ),
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(15),
            topLeft: Radius.circular(15),
          ),
        ),
      ),
      validator: (value) {
        if (emptyErrorBool) {
          if (value!.isEmpty) {
            return emptyErrorString;
          }
        }
        if (minLengthErrorBool) {
          if (minLengthErrorStrict) {
            if (value!.length != minLength) {
              return minLengthErrorString;
            }
          } else {
            if (value!.length < minLength) {
              return minLengthErrorString;
            }
          }
        }
        return null;
      },
    );
  }
}
