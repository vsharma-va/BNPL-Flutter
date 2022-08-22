import 'dart:developer';

import 'package:flutter/material.dart';

import '../theme_data.dart' as theme;
import '../lambda/common_queries.dart';
import '../temp/temp.dart';
import '../helper/page_transitions/back_forward_transition.dart';
import '../auth/errorSnackBar.dart';
import '../home/home_screen.dart';
import './components/list_wheel_child_builder.dart';
import './components/details_display.dart';

class AvailablePlansPage extends StatefulWidget {
  @override
  AvailablePlansPage({required bool this.back});
  final bool back;
  State<AvailablePlansPage> createState() => _AvailablePlansPageState();
}

class _AvailablePlansPageState extends State<AvailablePlansPage>
    with SingleTickerProviderStateMixin {
  int numberOfPlans = -1;
  List<dynamic> allPlansInfo = [];
  List<int> cardsList = [];
  final FixedExtentScrollController _rotatingScrollController =
      FixedExtentScrollController();

  Future<void> setupPage({required BuildContext context}) async {
    var query = Query();
    var numberOfPlansFuture = query.getNumberOfPlans(context: context);
    await numberOfPlansFuture.then((value) {
      numberOfPlans = value;
    });
    log('number of plans ' + numberOfPlans.toString());
    // context.showErrorSnackBar(
    //     message: 'Querying AWS -> setupPage({required BuildContext context}) async',
    //     upTime: Duration(milliseconds: 1500));
    for (var i = 0; i < numberOfPlans; i++) {
      var infoListFuture = query.getInstPlanRateAndDuration(
          context: context, instPlanSerno: i + 1);
      cardsList.add(i + 1);
      await infoListFuture.then((value) {
        allPlansInfo.add(value);
      });
    }
    // context.showErrorSnackBar(
    //     message:
    //         'Finished Querying AWS -> setupPage({required BuildContext context}) async',
    //     upTime: Duration(milliseconds: 1500));
    log(allPlansInfo.toString());
    setState(() {});
  }

  void rotatingScrollChildTapped() {
    var currentScrollIndex = _rotatingScrollController.selectedItem;
    // Navigator.of(context).pushReplacement(MaterialPageRoute(
    //     builder: ((context) => DetailsPage(
    //           planNumberZeroIndex: currentScrollIndex,
    //           planInfo: allPlansInfo[currentScrollIndex],
    //         ))));

    // Navigator.push(context, MaterialPageRoute(builder: (_) {
    //   return DetailsPage(
    //     planNumberZeroIndex: currentScrollIndex,
    //     planInfo: allPlansInfo[currentScrollIndex],
    //   );
    // }));

    Navigator.push(
        context,
        PageRouteBuilder(
            transitionDuration: const Duration(milliseconds: 500),
            pageBuilder: (_, __, ___) => DetailsPage(
                  planNumberZeroIndex: currentScrollIndex,
                  planInfo: allPlansInfo[currentScrollIndex],
                )));
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    setupPage(context: context);
  }

  @override
  void dispose() {
    super.dispose();
    _rotatingScrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: WillPopScope(
          onWillPop: () async {
            Navigator.pushReplacement(context,
                ForwardOrBackwardTransition(child: HomeScreen(), back: true));
            return true;
          },
          child: Scaffold(
            body: Column(
              children: [
                Container(
                  alignment: Alignment.topLeft,
                  child: BackButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          ForwardOrBackwardTransition(
                              child: HomeScreen(), back: true));
                    },
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  child: const Text(
                    'SELECT A PLAN',
                    style: TextStyle(
                        color: theme.textColor,
                        fontSize: 35,
                        fontFamily: 'CascadiaCode'),
                  ),
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.only(
                      top: 25,
                      left: 25,
                      right: 25,
                    ),
                    child: GestureDetector(
                      onTap: rotatingScrollChildTapped,
                      child: ListWheelScrollView(
                        diameterRatio: 0.75,
                        perspective: 0.001,
                        itemExtent: 185,
                        physics: const FixedExtentScrollPhysics(),
                        controller: _rotatingScrollController,
                        children: [
                          for (var currentPlanInfo in allPlansInfo)
                            ListWheelChildBuilder(
                                item: allPlansInfo.indexOf(currentPlanInfo),
                                currentPlansInfo: currentPlanInfo),
                        ],
                      ),
                    ),
                  ),
                ),
                if (cardsList.isEmpty ||
                    allPlansInfo.isEmpty && cardsList.length == numberOfPlans)
                  Container(
                    alignment: Alignment.center,
                    child: const CircularProgressIndicator(
                      color: theme.primaryColor,
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
