import 'package:flutter/material.dart';

class FormFields extends StatelessWidget {
  FormFields({
    required this.controller,
    required this.iconData,
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
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: Icon(
          iconData,
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Color.fromRGBO(53, 56, 57, 1),
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(25.0),
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Color.fromRGBO(53, 56, 57, 1),
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(25.0),
          ),
        ),
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Color.fromARGB(255, 194, 25, 25),
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(25.0),
          ),
        ),
        focusedErrorBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Color.fromARGB(255, 212, 20, 20),
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(25.0),
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
