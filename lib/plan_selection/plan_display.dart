import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:google_fonts/google_fonts.dart';

import '../theme_data.dart' as theme;
import '../lambda/common_queries.dart';
import '../home/temp.dart';
import '../helper/page_transitions/back_forward_transition.dart';
import '../auth/errorSnackBar.dart';

class AvailablePlansPage extends StatefulWidget {
  @override
  State<AvailablePlansPage> createState() => _AvailablePlansPageState();
}

class _AvailablePlansPageState extends State<AvailablePlansPage> {
  int numberOfPlans = -1;
  List<dynamic> allPlansInfo = [];
  List<Future<dynamic>> allPlansInfoFuture = [];

  List<int> cardsList = [];

  Future<void> setupPage({required BuildContext context}) async {
    var query = Query();
    var numberOfPlansFuture = query.getNumberOfPlans(context: context);
    await numberOfPlansFuture.then((value) {
      numberOfPlans = value;
    });
    log('number of plans ' + numberOfPlans.toString());
    context.showErrorSnackBar(
        message: 'Querying AWS -> setupPage({required BuildContext context})',
        upTime: Duration(milliseconds: 1500));
    for (var i = 0; i < numberOfPlans; i++) {
      var infoListFuture = query.getInstPlanRateAndDuration(
          context: context, instPlanSerno: i + 1);
      cardsList.add(i + 1);
      await infoListFuture.then((value) {
        allPlansInfo.add(value);
      });
    }
    context.showErrorSnackBar(
        message:
            'Finished Querying AWS -> setupPage({required BuildContext context})',
        upTime: Duration(milliseconds: 1500));
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    setupPage(context: context);
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return SafeArea(
      child: WillPopScope(
        onWillPop: () async {
          Navigator.pushReplacement(
              context, ForwardOrBackwardTransition(child: Temp(), back: true));
          return true;
        },
        child: Scaffold(
          body: Column(
            children: [
              Container(
                alignment: Alignment.topLeft,
                child: BackButton(
                  onPressed: () {
                    Navigator.pushReplacement(context,
                        ForwardOrBackwardTransition(child: Temp(), back: true));
                  },
                ),
              ),
              Container(
                alignment: Alignment.center,
                child: Text(
                  'Select a plan',
                  style: GoogleFonts.bebasNeue(
                    textStyle: TextStyle(color: theme.textColor, fontSize: 35),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.only(top: 100),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (cardsList.isNotEmpty && allPlansInfo.isNotEmpty)
                      Container(
                        padding: const EdgeInsets.only(
                          left: 25,
                          right: 25,
                        ),
                        height: screenSize.height / 2,
                        width: screenSize.width,
                        child: CarouselSlider(
                          options: CarouselOptions(
                            height: screenSize.height,
                            viewportFraction: 0.7,
                            enlargeCenterPage: true,
                          ),
                          items: cardsList
                              .map(
                                (item) => ClipRRect(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15)),
                                  child: Container(
                                    height: screenSize.height / 2,
                                    width: screenSize.width,
                                    color: theme.form.withOpacity(0.5),
                                    child: Container(
                                      child: Column(
                                        children: [
                                          Text(
                                            'Plan - $item',
                                            style: GoogleFonts.oswald(
                                              textStyle: const TextStyle(
                                                  color: theme.textColor,
                                                  fontSize: 25),
                                            ),
                                          ),
                                          Expanded(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          bottom: 5),
                                                  child: Text(
                                                    'Principal Amount - Rs 10000',
                                                    style: GoogleFonts.oswald(
                                                      textStyle:
                                                          const TextStyle(
                                                              color: theme
                                                                  .textColor,
                                                              fontSize: 20),
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          bottom: 5),
                                                  child: Text(
                                                    'Interest Rate - ${allPlansInfo[item - 1][0] * 100}%',
                                                    style: GoogleFonts.oswald(
                                                      textStyle:
                                                          const TextStyle(
                                                              color: theme
                                                                  .textColor,
                                                              fontSize: 20),
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                    bottom: 5,
                                                  ),
                                                  child: Text(
                                                    'Duration - ${allPlansInfo[item - 1][1]}',
                                                    style: GoogleFonts.oswald(
                                                      textStyle:
                                                          const TextStyle(
                                                              color: theme
                                                                  .textColor,
                                                              fontSize: 20),
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          bottom: 5),
                                                  child: Text(
                                                    'Per Day Charge - ${(((10000 / allPlansInfo[item - 1][1]) + allPlansInfo[item - 1][0] * 10000) / 30).toStringAsFixed(2)}',
                                                    style: GoogleFonts.oswald(
                                                      textStyle:
                                                          const TextStyle(
                                                              color: theme
                                                                  .textColor,
                                                              fontSize: 20),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            alignment: Alignment.bottomRight,
                                            child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                primary: theme.backgroundColor,
                                                onPrimary: theme.secondaryColor,
                                                minimumSize: Size(75, 55),
                                                shadowColor: Colors.black,
                                                enableFeedback: true,
                                                elevation: 15,
                                                // shape: RoundedRectangleBorder(
                                                //   borderRadius: BorderRadius.circular(25),
                                                // ),
                                              ),
                                              child: Text(
                                                'Details',
                                                textAlign: TextAlign.center,
                                                style: GoogleFonts.bebasNeue(
                                                  textStyle: const TextStyle(
                                                    fontSize: 15,
                                                    color: theme.primaryColor,
                                                  ),
                                                ),
                                              ),
                                              onPressed: () {},
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                      ),
                    if (cardsList.isEmpty ||
                        allPlansInfo.isEmpty &&
                            cardsList.length == numberOfPlans)
                      Container(
                        alignment: Alignment.center,
                        child: const CircularProgressIndicator(
                          color: theme.primaryColor,
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
