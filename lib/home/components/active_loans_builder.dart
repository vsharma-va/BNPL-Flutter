import 'package:flutter/material.dart';

import '../../theme_data.dart' as theme;
import '../../lambda/common_queries.dart';

class ActiveLoansBuilder extends StatefulWidget {
  ActiveLoansBuilder({Key? key}) : super(key: key);

  @override
  State<ActiveLoansBuilder> createState() => _ActiveLoansBuilderState();
}

class _ActiveLoansBuilderState extends State<ActiveLoansBuilder> {
  var query = Query();

  Future<void> getAllActiveLoans() async {
    var accSerno =
        int.parse(await query.getAccSernoByCognitoId(context: context));
    var lambdaParameters = '{"name":"getActiveLoans", "accSerno": "$accSerno"}';
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var parentHeight = screenSize.height / 100 * 60;
    return Column(
      children: [
        Container(
          height: parentHeight,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: theme.planCardColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              Container(
                alignment: Alignment.topLeft,
                decoration: BoxDecoration(
                  color: theme.form,
                  borderRadius: BorderRadius.circular(10),
                ),
                margin: const EdgeInsets.only(
                  top: 10,
                  left: 15,
                  right: 15,
                  bottom: 10,
                ),
                padding: const EdgeInsets.all(15),
                height: parentHeight / 100 * 20,
                child: Column(
                  children: [
                    const Text(
                      "{Plan Number}",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontFamily: 'CascadiaCode',
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(
                              top: 25,
                              left: 15,
                            ),
                            child: const Text(
                              "{Amount}",
                              style: TextStyle(
                                fontFamily: 'CascadiaCode',
                                fontSize: 14,
                              ),
                            ),
                          ),
                          Container(
                            alignment: Alignment.centerRight,
                            margin: const EdgeInsets.only(top: 25, right: 15),
                            child: const Text(
                              "{Interest Rate}",
                              style: TextStyle(
                                fontFamily: 'CascadiaCode',
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
