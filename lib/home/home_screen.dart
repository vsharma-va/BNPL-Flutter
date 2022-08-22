import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../helper/page_transitions/back_forward_transition.dart';
import '../temp/temp.dart';
import '../plan_selection/plan_display.dart';
import '../lambda/common_queries.dart';
import '../theme_data.dart' as theme;
import './components/active_loans_builder.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var query = Query();
  bool isTopBarExpanded = false;
  bool isSecondaryBarExpanded = false;
  String userName = '';

  Future<void> getUserName() async {
    var name = await query.getUserName(context: context);
    userName = name.replaceAll("\"", "");
    setState(() {});
  }

  void onTopBarPanUpdate(DragUpdateDetails details) {
    if (details.delta.dy < 0) {
      setState(() {
        isTopBarExpanded = false;
      });
    }
    if (details.delta.dy > 0) {
      setState(() {
        isTopBarExpanded = true;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getUserName();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: WillPopScope(
          onWillPop: () async {
            Navigator.pushReplacement(context,
                ForwardOrBackwardTransition(child: Temp(), back: true));
            return true;
          },
          child: Column(
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
              Stack(
                children: [
                  AnimatedContainer(
                    duration: isTopBarExpanded
                        ? const Duration(milliseconds: 100)
                        : const Duration(milliseconds: 450),
                    height: isTopBarExpanded ? 350 : 0,
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.only(
                        top: 25,
                        left: 10,
                        right: 10,
                        bottom: 10,
                      ),
                      margin: const EdgeInsets.only(
                        top: 25,
                        left: 35,
                        right: 35,
                        bottom: 25,
                      ),
                      decoration: BoxDecoration(
                        color: theme.planCardColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        children: [
                          AnimatedContainer(
                            duration: isTopBarExpanded
                                ? const Duration(milliseconds: 850)
                                : const Duration(milliseconds: 150),
                            margin: isTopBarExpanded
                                ? const EdgeInsets.only(
                                    top: 100,
                                  )
                                : const EdgeInsets.only(top: 0),
                            padding: isTopBarExpanded
                                ? const EdgeInsets.all(10)
                                : const EdgeInsets.all(0),
                            decoration: BoxDecoration(
                              color: theme.backgroundColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Container(
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: theme.planCardColor,
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  child: IconButton(
                                    alignment: Alignment.center,
                                    icon: const FaIcon(
                                        FontAwesomeIcons.moneyBill),
                                    onPressed: () {},
                                  ),
                                ),
                                Column(
                                  children: [
                                    Container(
                                      alignment: Alignment.topCenter,
                                      child: const Text(
                                        "Borrowing Limit",
                                        textAlign: TextAlign.justify,
                                        style: TextStyle(
                                          fontFamily: 'CascadiaCode',
                                          fontSize: 16,
                                          color: theme.textColor,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.bottomCenter,
                                      child: const Text(
                                        "INR 10000",
                                        style: TextStyle(
                                          fontFamily: 'CascadiaCode',
                                          fontSize: 16,
                                          color: theme.textColor,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          AnimatedContainer(
                            duration: isTopBarExpanded
                                ? const Duration(milliseconds: 150)
                                : const Duration(milliseconds: 150),
                            height: isTopBarExpanded ? 75 : 0,
                            margin: isTopBarExpanded
                                ? const EdgeInsets.only(top: 20)
                                : const EdgeInsets.only(top: 0),
                            decoration: BoxDecoration(
                              color: theme.backgroundColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                AnimatedOpacity(
                                  duration: const Duration(milliseconds: 150),
                                  opacity: isTopBarExpanded ? 1 : 0,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: theme.planCardColor,
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                    margin: const EdgeInsets.only(
                                      top: 17,
                                      left: 17,
                                      right: 35,
                                      bottom: 17,
                                    ),
                                    alignment: Alignment.centerLeft,
                                    child: IconButton(
                                      icon: const FaIcon(
                                          FontAwesomeIcons.cashRegister),
                                      onPressed: () {},
                                    ),
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.centerRight,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      primary: theme.form,
                                      onPrimary: theme.secondaryColor,
                                      shadowColor: Colors.black,
                                      enableFeedback: true,
                                      elevation: 15,
                                      // shape: RoundedRectangleBorder(
                                      //   borderRadius: BorderRadius.circular(25),
                                      // ),
                                    ),
                                    onPressed: () {
                                      Navigator.pushReplacement(
                                          context,
                                          ForwardOrBackwardTransition(
                                              child: AvailablePlansPage(
                                                  back: false)));
                                    },
                                    child: const Text(
                                      "Take a Loan",
                                      style: TextStyle(
                                        fontFamily: 'CascadiaCode',
                                        fontSize: 16,
                                        color: theme.textColor,
                                      ),
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
                  AnimatedPositioned(
                    duration: const Duration(milliseconds: 500),
                    child: GestureDetector(
                      onPanUpdate: onTopBarPanUpdate,
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 500),
                        margin: isTopBarExpanded
                            ? const EdgeInsets.only(
                                top: 35,
                                left: 45,
                                right: 45,
                                bottom: 25,
                              )
                            : const EdgeInsets.only(
                                top: 25,
                                left: 35,
                                right: 35,
                                bottom: 25,
                              ),
                        child: Container(
                          padding: const EdgeInsets.only(
                            top: 25,
                            right: 30,
                            left: 30,
                            bottom: 25,
                          ),
                          // margin: const EdgeInsets.only(
                          //   top: 25,
                          //   left: 35,
                          //   right: 35,
                          //   bottom: 25,
                          // ),
                          decoration: BoxDecoration(
                            color: theme.form,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              const Text(
                                "Hello",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: 'CascadiaCode',
                                  color: theme.textColor,
                                  fontSize: 25,
                                ),
                              ),
                              Text(
                                "" + userName.split(" ")[0] + " ",
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 25,
                                  fontFamily: 'CascadiaCode',
                                  color: theme.textColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: theme.backgroundColor,
                                ),
                                child: IconButton(
                                  icon:
                                      const FaIcon(FontAwesomeIcons.creditCard),
                                  onPressed: () {},
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                flex: 1,
                child: SizedBox(
                  width: double.infinity,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height / 100 * 60,
                          margin: const EdgeInsets.only(
                            top: 25,
                            bottom: 25,
                          ),
                          child: CarouselSlider(
                            items: [
                              ActiveLoansBuilder(),
                              ActiveLoansBuilder(),
                            ],
                            options: CarouselOptions(
                              height: double.infinity,
                              enlargeCenterPage: true,
                            ),
                          ),
                          // Container(
                          //   height: 450,
                          //   width: double.infinity,
                          //   decoration: BoxDecoration(
                          //     color: theme.textColor,
                          //     borderRadius: BorderRadius.circular(10),
                          //   ),
                          //   margin: const EdgeInsets.only(
                          //     top: 25,
                          //     right: 35,
                          //     left: 35,
                          //   ),
                          //   child: CarouselSlider(
                          //     options: CarouselOptions(
                          //       height: 450,
                          //       viewportFraction: 0.8,
                          //       enlargeCenterPage: true,
                          //       scrollDirection: Axis.horizontal,
                          //     ),
                          //     items: const [
                          //       ActiveLoansBuilder(),
                          //       ActiveLoansBuilder(),
                          //     ],
                          //   ),
                          // ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
