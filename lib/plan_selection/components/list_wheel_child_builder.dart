import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../theme_data.dart' as theme;

class ListWheelChildBuilder extends StatelessWidget {
  ListWheelChildBuilder({required this.item, required this.currentPlansInfo});

  late int item;
  late List<dynamic> currentPlansInfo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.only(
          top: 7.0,
          right: 7.0,
          left: 7.0,
          bottom: 0.0,
        ),
        decoration: BoxDecoration(
          color: theme.planCardColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Hero(
              tag: 'heading-instalment-plan-$item',
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: theme.form,
                ),
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      width: double.infinity,
                      child: Text(
                        "Plan ${item + 1}",
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                          fontFamily: 'CascadiaCode',
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                          decoration: TextDecoration.none,
                          color: theme.textColor,
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      width: double.infinity,
                      margin: const EdgeInsets.only(top: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            alignment: Alignment.topLeft,
                            child: const Text(
                              "Amount: INR 10000",
                              style: TextStyle(
                                fontFamily: 'CascadiaCode',
                                color: theme.textColor,
                                fontWeight: FontWeight.normal,
                                decoration: TextDecoration.none,
                                fontSize: 13,
                              ),
                            ),
                          ),
                          Container(
                            alignment: Alignment.topRight,
                            child: Text(
                              "Duration: ${currentPlansInfo[1]} Months",
                              style: const TextStyle(
                                fontFamily: 'CascadiaCode',
                                color: theme.textColor,
                                fontWeight: FontWeight.normal,
                                decoration: TextDecoration.none,
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(
                left: 17,
                right: 17,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: const EdgeInsets.only(
                      top: 10,
                      bottom: 10,
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      "Interest Rate: ${currentPlansInfo[0] * 100}%",
                      style: const TextStyle(
                        fontFamily: 'CascadiaCode',
                        color: theme.textColor,
                        fontSize: 13,
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.only(
                      top: 10,
                      bottom: 10,
                    ),
                    child: Text(
                      "Per Day Charge: ${(((10000 / currentPlansInfo[1]) * (currentPlansInfo[0] + 1)) / 30).toStringAsFixed(2)}",
                      style: const TextStyle(
                        fontFamily: 'CascadiaCode',
                        color: theme.textColor,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.only(top: 2, bottom: 2),
              margin: const EdgeInsets.only(top: 9),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: theme.form,
              ),
              child: const Text(
                "Tap Anywhere For Details",
                textAlign: TextAlign.center,
                style: TextStyle(
                  backgroundColor: theme.form,
                  fontFamily: 'CascadiaCode',
                  color: theme.textColor,
                  fontSize: 13,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
