import 'dart:developer';

import 'package:flutter/material.dart';

import '../auth/auth_functions.dart';

class Query {
  var userAttributes = {};

  Future<String> getAccSernoByCognitoId({required BuildContext context}) async {
    if (userAttributes.isNotEmpty) {
      var lambdaParameters =
          '{"name": "getAccSerno", "userId": "${userAttributes['sub'].toString()}"}'
              .codeUnits;
      var accSernoFuture =
          AuthFunc.crudFuncOnDb(parameters: lambdaParameters, context: context);
      return accSernoFuture;
    } else {
      var userAttributes = await AuthFunc.getUserAttributes(context: context);
      var lambdaParameters =
          '{"name": "getAccSerno", "userId": "${userAttributes['sub'].toString()}"}'
              .codeUnits;
      var accSernoFuture =
          AuthFunc.crudFuncOnDb(parameters: lambdaParameters, context: context);
      return accSernoFuture;
    }
  }

  Future<String> getUserName({required BuildContext context}) async {
    if (userAttributes.isEmpty) {
      userAttributes = await AuthFunc.getUserAttributes(context: context);
    }
    var lambdaParameters =
        '{"name": "getUserName", "userId": "${userAttributes['sub'].toString()}"}'
            .codeUnits;
    var userName =
        AuthFunc.crudFuncOnDb(parameters: lambdaParameters, context: context);
    return userName;
  }

  Future<List<dynamic>> getInstPlanRateAndDuration(
      {required BuildContext context, required int instPlanSerno}) async {
    List<int> lambdaParamaeters2 =
        '{"name": "selectInstalmentPlan", "instPlanSerno": "${instPlanSerno.toString()}"}'
            .codeUnits;
    var interestRate = -1.0;
    var durationInMonths = -1;
    var y = '';

    var instPlanInfoFuture =
        AuthFunc.crudFuncOnDb(parameters: lambdaParamaeters2, context: context);
    await instPlanInfoFuture.then((value) {
      y = value;
      var instPlanInfoList =
          y.replaceAll('[', '').replaceAll(']', '').split(',');
      interestRate = double.parse(instPlanInfoList[1].replaceAll(" ", ""));
      durationInMonths = int.parse(instPlanInfoList[0].replaceAll(" ", ""));
      return [interestRate, durationInMonths];
    });
    return [interestRate, durationInMonths];
  }

  Future<int> getNumberOfPlans({required BuildContext context}) async {
    var numberOfPlans = -1;
    List<int> lambdaParameters = '{"name": "getNumberOfPlans"}'.codeUnits;

    var numberOfPlansFuture =
        AuthFunc.crudFuncOnDb(parameters: lambdaParameters, context: context);
    await numberOfPlansFuture.then((value) {
      log(value);
      numberOfPlans = int.parse(value);
      return numberOfPlans;
    });

    return numberOfPlans;
  }
}
