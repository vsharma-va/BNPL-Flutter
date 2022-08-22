import 'package:flutter/material.dart';

import '../../theme_data.dart' as theme;
import '../../helper/page_transitions/back_forward_transition.dart';
import '../plan_display.dart';

class DetailsPage extends StatelessWidget {
  DetailsPage({required this.planNumberZeroIndex, required this.planInfo});

  final int planNumberZeroIndex;
  final List<dynamic> planInfo;

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: WillPopScope(
          onWillPop: () async {
            Navigator.pushReplacement(
                context,
                ForwardOrBackwardTransition(
                    child: AvailablePlansPage(back: true), back: true));
            return true;
          },
          child: Scaffold(
            body: Stack(
              children: [
                Positioned.fill(
                  left: 0,
                  right: 0,
                  child: Container(
                    color: theme.backgroundColor,
                  ),
                ),
                Positioned(
                  height: screenSize.height,
                  width: screenSize.width,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 55,
                      bottom: 75,
                      left: 25,
                      right: 25,
                    ),
                    child: SingleChildScrollView(
                      child: Container(
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: theme.planCardColor,
                        ),
                        padding: const EdgeInsets.only(
                          top: 7.0,
                          right: 7.0,
                          left: 7.0,
                          bottom: 0.0,
                        ),
                        child: Column(
                          children: [
                            Hero(
                              tag:
                                  'heading-instalment-plan-$planNumberZeroIndex',
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
                                        "Plan ${planNumberZeroIndex + 1}",
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
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
                                              "Duration: ${planInfo[1]} Months",
                                              style: const TextStyle(
                                                fontFamily: 'CascadiaCode',
                                                fontWeight: FontWeight.normal,
                                                decoration: TextDecoration.none,
                                                color: theme.textColor,
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
                            for (var i = 0; i < planInfo[1]; i++)
                              Container(
                                alignment: Alignment.center,
                                child: Column(
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(
                                        // top: i == 0 ? 30.0 : 10.0,
                                        top: 35,
                                        bottom: 5,
                                      ),
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "Instalment ${i + 1}",
                                        textAlign: TextAlign.left,
                                        style: const TextStyle(
                                          fontFamily: 'CascadiaCode',
                                          color: theme.textColor,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Container(
                                            alignment: Alignment.topLeft,
                                            child: const Text(
                                              "Repayment Date",
                                              style: TextStyle(
                                                fontFamily: 'CascadiaCode',
                                                fontSize: 13,
                                                color: theme.textColor,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          alignment: Alignment.topRight,
                                          child: const Text(
                                            "12-02-2022",
                                            textAlign: TextAlign.right,
                                            style: TextStyle(
                                              fontFamily: 'CascadiaCode',
                                              fontSize: 13,
                                              color: theme.textColor,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 7,
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Container(
                                            alignment: Alignment.topLeft,
                                            child: const Text(
                                              "Interest",
                                              style: TextStyle(
                                                fontFamily: 'CascadiaCode',
                                                fontSize: 13,
                                                color: theme.textColor,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          alignment: Alignment.topRight,
                                          child: Text(
                                            ((10000 / planInfo[1]) *
                                                    (planInfo[0]))
                                                .toStringAsFixed(2),
                                            style: const TextStyle(
                                              fontFamily: 'CascadiaCode',
                                              fontSize: 13,
                                              color: theme.textColor,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 7,
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Container(
                                            alignment: Alignment.topLeft,
                                            child: const Text(
                                              "Repayment Amount",
                                              style: TextStyle(
                                                fontFamily: 'CascadiaCode',
                                                fontSize: 13,
                                                color: theme.textColor,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          alignment: Alignment.topRight,
                                          child: Text(
                                            ((10000 / planInfo[1]) *
                                                    (planInfo[0] + 1))
                                                .toStringAsFixed(2),
                                            style: const TextStyle(
                                              fontFamily: 'CascadiaCode',
                                              fontSize: 13,
                                              color: theme.textColor,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.topLeft,
                  child: BackButton(
                    onPressed: () {
                      // final route = FadeThroughPageRoute(
                      //     page: AvailablePlansPage(back: true));
                      // Navigator.of(context).push(route);
                      Navigator.push(
                          context,
                          PageRouteBuilder(
                              transitionDuration:
                                  const Duration(milliseconds: 500),
                              pageBuilder: (_, __, ___) =>
                                  AvailablePlansPage(back: true)));
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
