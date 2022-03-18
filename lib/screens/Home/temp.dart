import 'dart:ffi';
import 'dart:typed_data';
import 'package:bnpl/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:aws_lambda_api/lambda-2015-03-31.dart' as lambda;
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../auth/components/errorSnackBar.dart';
import '../auth/components/auth_functions.dart';
import '../auth/components/form_fields.dart';

class Temp extends StatefulWidget {
  @override
  State<Temp> createState() => _TempState();
}

class _TempState extends State<Temp> {
  late String? token;
  String response = 'whatis';
  int accSernoInt = -1;
  int durationInMonths = -1;
  double interestRate = -1;
  bool isLoaded = false;
  Map<String, String> userAttributes = {};
  TextEditingController phoneController = TextEditingController();
  TextEditingController instSernoController = TextEditingController();

  Future<void> signUp() async {
    try {
      final user =
          await Amplify.Auth.getCurrentUser(); //This will give you the AuthUser
      // print(user.userId);
      // print(user.username);
    } catch (e) {
      context.showErrorSnackBar(message: e.toString());
    }
  }

  Future<void> please() async {
    try {
      var res = await Amplify.Auth.fetchUserAttributes();
      res.forEach((element) {
        userAttributes[element.userAttributeKey.toString()] = element.value;
        // print('key: ${element.userAttributeKey}; value: ${element.value}');
      });
      // print(attributes);
    } on AuthException catch (e) {
      context.showErrorSnackBar(message: e.message);
    }
  }

  Future<void> what() async {
    try {
      if (userAttributes == null || userAttributes.isEmpty) {
        please();
      }
      await Amplify.Auth.signOut(options: SignOutOptions(globalSignOut: true));
      print('success');
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: ((context) => Login(attributes: userAttributes))));
    } on AmplifyException catch (e) {
      context.showErrorSnackBar(message: e.message);
    }
  }

  Future<String> testCallLambda() async {
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
        List<int> list = '{"test":"True"}'.codeUnits;

        lambda.InvocationResponse lambdaResponse = await service.invoke(
            functionName: "slopay_db_connect",
            invocationType: lambda.InvocationType.requestResponse,
            payload: Uint8List.fromList(list));

        returnString = String.fromCharCodes(lambdaResponse.payload!);

        return returnString;
      } catch (e) {
        print(e);
        return 'false';
      }
    } on AuthException catch (e) {
      print(e);
      return 'false';
    }
  }

  void createNewAccount() {
    print(userAttributes['sub'].toString());
    List<int> lambdaParameters =
        '{"name": "createNewAccount",  "userId": "${userAttributes["sub"].toString()}", "balance": "0", "collectionSerno": "-1", "accStatus": "NORM"}'
            .codeUnits;
    AuthFunc.crudFuncOnDb(parameters: lambdaParameters, context: context);
  }

  void createAnInstallment(int instPlanSerno) {
    List<String> instPlanInfoList = [];
    List<int> lambdaParameters1 =
        '{"name": "getAccSerno", "userId": "${userAttributes['sub'].toString()}"}'
            .codeUnits;
    var accSerno =
        AuthFunc.crudFuncOnDb(parameters: lambdaParameters1, context: context);

    List<int> lambdaParamaeters2 =
        '{"name": "selectInstalmentPlan", "instPlanSerno": "${instPlanSerno.toString()}"}'
            .codeUnits;

    var instPlanInfoFuture =
        AuthFunc.crudFuncOnDb(parameters: lambdaParamaeters2, context: context);

    instPlanInfoFuture.then((value) {
      var x = value.replaceAll('[', '').replaceAll(']', '');
      instPlanInfoList = x.split(',');
      interestRate = double.parse(instPlanInfoList[1].replaceAll(" ", ""));
      durationInMonths = int.parse(instPlanInfoList[0].replaceAll(" ", ""));
      accSerno.then((value) {
        accSernoInt = int.parse(value);
        print(accSernoInt);
        List<int> lambdaParameters =
            '{"name": "createInstallment",  "instType": "-1", "cAccSerno": "${accSernoInt}", "instOrigAmount": "0", "instPrincipalAmount": "1000", "instTrxnSerno": "-1", "outstandingAmt": "1000", "instStatus": "NORM", "interestPercentage": "${interestRate}", "instNoMonths": "${durationInMonths}"}'
                .codeUnits;
        var result = AuthFunc.crudFuncOnDb(
            parameters: lambdaParameters, context: context);
        result.then((value) {
          if (value.contains('errorMessage')) {
            context.showErrorSnackBar(message: "Task Timed Out");
          }
        });
      });
    });
  }

  void addInstallmentToAmortization() {
    if (durationInMonths != -1) {
      // var lambdaParameters1 =
      //     '{"name": "cInstalmentSelectQuery", "what": "instSerno"}'.codeUnits;
      // var lambdaParameters2 =
      //     '{"name": "cInstalmentSelectQuery", "what": "instTotalAmt"}'
      //         .codeUnits;
      // var instSerno = AuthFunc.crudFuncOnDb(
      //     parameters: lambdaParameters1, context: context);
      // var instTotalAmt = AuthFunc.crudFuncOnDb(
      //     parameters: lambdaParameters2, context: context);
      var lambdaParameters =
          '{"name": "createAmortization", "durationInMonths": "${durationInMonths}", "accSerno": "${accSernoInt}"}'
              .codeUnits;

      AuthFunc.crudFuncOnDb(parameters: lambdaParameters, context: context);
    }
  }

  @override
  void dispose() {
    super.dispose();
    phoneController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    signUp();
    please();
    if (!isLoaded && response != 'false') {
      testCallLambda().then(((value) {
        setState(() {
          response = value;
        });
        isLoaded = true;
      }));
    }

    var a = AuthFunc.getUserAttributes(context: context);
    a.then(
      (value) {
        userAttributes = value;
      },
    );

    if (response == 'false') {
      context.showErrorSnackBar(message: 'Error contacting server.');
      context.showErrorSnackBar(message: 'Check your internet connection');
    }

    return Scaffold(
      backgroundColor: const Color.fromRGBO(53, 56, 57, 1),
      body: Container(
        alignment: Alignment.center,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Finished !",
                style: GoogleFonts.balooTamma(
                  textStyle: const TextStyle(
                    color: Color.fromRGBO(225, 200, 87, 1),
                    fontSize: 35,
                  ),
                ),
              ),
              FormFields(
                controller: instSernoController,
                iconData: FontAwesomeIcons.solidUserCircle,
                labelText: "Last Name",
                hintText: "eg. Smith",
                emptyErrorBool: true,
                emptyErrorString: "Last Name field is empty",
                minLengthErrorBool: false,
                minLengthErrorStrict: false,
                minLength: 0,
                minLengthErrorString: "",
                passwordBool: false,
              ),
              ElevatedButton(
                onPressed: what,
                child: Text("Signout"),
              ),
              ElevatedButton(
                onPressed: createNewAccount,
                child: Text("Create Account"),
              ),
              ElevatedButton(
                onPressed: () {
                  createAnInstallment(int.parse(instSernoController.text));
                },
                child: Text("Create Installment"),
              ),
              ElevatedButton(
                onPressed: addInstallmentToAmortization,
                child: Text("Create Amortization"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
