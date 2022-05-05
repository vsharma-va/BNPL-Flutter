import 'dart:developer';
import 'dart:typed_data';

import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:flutter/material.dart';
import 'package:aws_lambda_api/lambda-2015-03-31.dart' as lambda;

import '../forms/user_info.dart';
import 'errorSnackBar.dart';
import '../landing_page/landing_page.dart';
import '../home/temp.dart';

class AuthFunc {
  static Future<void> googleSignIn({required BuildContext context}) async {
    try {
      var res =
          await Amplify.Auth.signInWithWebUI(provider: AuthProvider.google);
      if (res.isSignedIn) {
        proceedToNextPageAfterAuth(context: context);
      }
    } on AmplifyException catch (e) {
      context.showErrorSnackBar(message: e.message);
    }
  }

  static void proceedToNextPageAfterAuth({required BuildContext context}) {
    var userAttributes = {};
    getUserAttributes(context: context).then(
      (value) {
        userAttributes = value;
        log(userAttributes['sub'].toString());
        List<int> lambdaParameters =
            '{"name": "getAccSerno", "userId": "${userAttributes["sub"].toString()}"}'
                .codeUnits;
        var returnString = '';
        var futureReturnString =
            crudFuncOnDb(parameters: lambdaParameters, context: context);
        futureReturnString.then(
          (value) {
            returnString = value;
            log(returnString);
            if (returnString != 'false') {
              try {
                int.parse(returnString);
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: ((context) => Temp())));
                log('to temp');
              } on FormatException {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: ((context) => UserForm())));
                log('to userform');
              }
            } else {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: ((context) => UserForm())));
              log('else userform');
            }
          },
        );
      },
    );
  }

  static Future<void> facebookSignIn({required BuildContext context}) async {
    try {
      var res =
          await Amplify.Auth.signInWithWebUI(provider: AuthProvider.facebook);
      if (res.isSignedIn) {
        proceedToNextPageAfterAuth(context: context);
      }
    } on AmplifyException catch (e) {
      context.showErrorSnackBar(message: e.message);
    }
  }

  static Future<Map<String, String>> getUserAttributes(
      {required BuildContext context}) async {
    Map<String, String> attributes = {};
    try {
      var res = await Amplify.Auth.fetchUserAttributes();
      res.forEach((element) {
        attributes[element.userAttributeKey.toString()] = element.value;
      });
    } on AuthException catch (e) {
      context.showErrorSnackBar(message: e.message);
    }
    return attributes;
  }

  static Future<void> signOut({required BuildContext context}) async {
    try {
      await Amplify.Auth.signOut(
          options: const SignOutOptions(globalSignOut: true));
      log('success');
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Landing_Page(),
        ),
      );
    } on AmplifyException catch (e) {
      context.showErrorSnackBar(message: e.message);
    }
  }

  static Future<String> crudFuncOnDb(
      {required List<int> parameters,
      required BuildContext context,
      String funcName = 'undefined'}) async {
    var returnString = '';
    try {
      var session = await Amplify.Auth.fetchAuthSession(
              options: CognitoSessionOptions(getAWSCredentials: true))
          as CognitoAuthSession;

      var cred = lambda.AwsClientCredentials(
        accessKey: session.credentials!.awsAccessKey!,
        secretKey: session.credentials!.awsSecretKey!,
        sessionToken: session.credentials!.sessionToken!,
      );

      const String region = "ap-south-1";

      final service = lambda.Lambda(region: region, credentials: cred);

      try {
        lambda.InvocationResponse lambdaResponse = await service.invoke(
            functionName: "slopay_db_connect",
            invocationType: lambda.InvocationType.requestResponse,
            payload: Uint8List.fromList(parameters));

        returnString = String.fromCharCodes(lambdaResponse.payload!);
        // context.showErrorSnackBar(
        //     message: "attributeName: ${funcName} Success !!");
        return returnString;
      } catch (e) {
        // context.showErrorSnackBar(
        //     message: e.toString() + ' at attributeName: $funcName Faliure');
        return 'false';
      }
    } on AuthException catch (e) {
      // context.showErrorSnackBar(
      //     message: e.message + ' at attributeName: $funcName Faliure');
      return 'false';
    }
  }
}
