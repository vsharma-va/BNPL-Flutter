import 'dart:developer';
import 'dart:typed_data';
import 'dart:convert';

import 'package:bnpl/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:aws_lambda_api/lambda-2015-03-31.dart' as lambda;
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:location/location.dart' as locationService;
import 'package:flutter_sms_inbox/flutter_sms_inbox.dart';

import '../auth/errorSnackBar.dart';
import '../auth/auth_functions.dart';
import '../forms/parent/form_fields.dart';
import './components/text_recognition/text_recognition_view.dart';
import '../landing_page/landing_page.dart';
import '../helper/page_transitions/back_forward_transition.dart';
import '../plan_selection/plan_display.dart';
import '../lambda/common_queries.dart';

class Temp extends StatefulWidget {
  @override
  State<Temp> createState() => _TempState();
}

// todo
// acc serno remains -1 if not pressed in order
// check geolocation

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
  dynamic currentLocation = '';
  List<Placemark> placemarks = [];
  var location = locationService.Location();
  var query = Query();

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
      log('success');
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Landing_Page(
                    attributes: userAttributes,
                  )));
      // Navigator.of(context).pushReplacement(MaterialPageRoute(
      //     builder: ((context) => Login(attributes: userAttributes))));
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
        log(e.toString());
        return 'false';
      }
    } on AuthException catch (e) {
      log(e.toString());
      return 'false';
    }
  }

  Future<void> _getLocation() async {
    currentLocation = await location.getLocation();
    List<Placemark> f = await placemarkFromCoordinates(
        double.parse(currentLocation.latitude.toString()),
        double.parse(currentLocation.longitude.toString()));
    setState(() {
      placemarks = f;
    });
  }

  Future<void> _saveLocationToDb() async {
    await _getLocation();
    // accSerno: int, name: str, street: str, isoCountryCode: str, locality: str, subThroughFare: str, throughfare: str, subLocality: str, postalCode: str, admistrativeArea: str, subAdministrativeArea: str
    if (accSernoInt == -1) {
      var accSernoFuture = await query.getAccSernoByCognitoId(context: context);
      accSernoInt = int.parse(accSernoFuture);
      _saveLocationToDbQuery();
    } else {
      _saveLocationToDbQuery();
    }
  }

  Future<void> _saveLocationToDbQuery() async {
    List<int> lambdaParameters =
        '{"name": "saveLocation", "accSerno": "$accSernoInt", "namex": "${placemarks[0].name.toString()}", "street": "${placemarks[0].street.toString()}", "isoCountryCode": "${placemarks[0].isoCountryCode.toString()}", "locality": "${placemarks[0].locality.toString()}", "subThroughFare": "${placemarks[0].subThoroughfare.toString()}", "throughfare": "${placemarks[0].thoroughfare.toString()}", "subLocality": "${placemarks[0].subLocality.toString()}", "postalCode": "${placemarks[0].postalCode.toString()}", "administrativeArea": "${placemarks[0].administrativeArea.toString()}", "subAdministrativeArea": "${placemarks[0].subAdministrativeArea.toString()}"}'
            .codeUnits;
    var returnString =
        AuthFunc.crudFuncOnDb(parameters: lambdaParameters, context: context);
    returnString.then((value) {
      context.showErrorSnackBar(
          message: value, upTime: const Duration(milliseconds: 400000));
    });
  }

  void createNewAccount() {
    log(userAttributes['sub'].toString());
    List<int> lambdaParameters =
        '{"name": "createNewAccount",  "userId": "${userAttributes["sub"].toString()}", "balance": "0", "collectionSerno": "-1", "accStatus": "NORM"}'
            .codeUnits;
    var returnValue = AuthFunc.crudFuncOnDb(
        parameters: lambdaParameters,
        context: context,
        funcName: 'createNewAccount()');
    returnValue.then((value) {
      context.showErrorSnackBar(
          message: value, upTime: const Duration(milliseconds: 4000));
    });
  }

  Future<void> createAnInstallment(int instPlanSerno) async {
    if (accSernoInt == -1) {
      var accSernoFuture = await query.getAccSernoByCognitoId(context: context);
      accSernoInt = int.parse(accSernoFuture);
      _createAnInstallmentQuery(instPlanSerno);
    } else {
      _createAnInstallmentQuery(instPlanSerno);
    }
  }

  void _createAnInstallmentQuery(int instPlanSerno) {
    List<String> instPlanInfoList = [];

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
      List<int> lambdaParameters =
          '{"name": "createInstallment",  "instType": "-1", "cAccSerno": "$accSernoInt", "instOrigAmount": "0", "instPrincipalAmount": "1000", "instTrxnSerno": "-1", "outstandingAmt": "1000", "instStatus": "NORM", "interestPercentage": "$interestRate", "instNoMonths": "$durationInMonths"}'
              .codeUnits;
      var result = AuthFunc.crudFuncOnDb(
          parameters: lambdaParameters,
          context: context,
          funcName: 'createAnInstallment(int instPlanSerno)');
      result.then((value) {
        context.showErrorSnackBar(
            message: value, upTime: const Duration(milliseconds: 4000));
      });
    });
  }

  Future<void> addInstallmentToAmortization() async {
    if (accSernoInt == -1) {
      var accSernoFuture = await query.getAccSernoByCognitoId(context: context);
      accSernoInt = int.parse(accSernoFuture);
      _addInstallmentToAmortizationQuery();
    } else {
      _addInstallmentToAmortizationQuery();
    }
  }

  void _addInstallmentToAmortizationQuery() {
    if (durationInMonths != -1) {
      var lambdaParameters =
          '{"name": "createAmortization", "durationInMonths": "$durationInMonths", "accSerno": "$accSernoInt"}'
              .codeUnits;

      var result = AuthFunc.crudFuncOnDb(
          parameters: lambdaParameters,
          context: context,
          funcName: 'addInstallmentToAmortization()');
      result.then((value) {
        context.showErrorSnackBar(
            message: value, upTime: const Duration(milliseconds: 4000));
      });
    }
  }

  Future<void> getAndStoreSms() async {
    if (accSernoInt == -1) {
      var accSernoIntFuture =
          await query.getAccSernoByCognitoId(context: context);
      accSernoInt = int.parse(accSernoIntFuture);
      _getAndStoreSmsQuery();
    } else {
      _getAndStoreSmsQuery();
    }
  }

  Future<void> _getAndStoreSmsQuery() async {
    var query = SmsQuery();
    var senders = [];
    var bodies = [];
    var datetimestamps = [];
    List<SmsMessage> messages = await query.getAllSms;
    messages.forEach((element) {
      final sender = element.sender.toString().trim();
      final senderBytes = utf8.encode(sender);
      final base64Sender = base64.encode(senderBytes);
      senders.add(base64Sender);

      final body = element.body.toString().trim();
      final bodyBytes = utf8.encode(body);
      final base64Body = base64.encode(bodyBytes);
      bodies.add(base64Body);
      var timestamp = element.date!.year.toString() +
          r'-' +
          element.date!.month.toString() +
          r'-' +
          element.date!.day.toString() +
          ' ' +
          element.date!.hour.toString() +
          ':' +
          element.date!.minute.toString() +
          ':' +
          element.date!.second.toString();
      final timestampBytes = utf8.encode(timestamp);
      final base64Timestamp = base64.encode(timestampBytes);
      datetimestamps.add(base64Timestamp);
    });
    var lambdaParameters2 =
        '{"name": "storeSms", "accSerno": "$accSernoInt", "sender": "$senders", "body": "$bodies", "datetimestamp": "$datetimestamps"}'
            .codeUnits;
    var result =
        AuthFunc.crudFuncOnDb(parameters: lambdaParameters2, context: context);
    result.then((value) {
      context.showErrorSnackBar(
          message: value.toString(),
          upTime: const Duration(milliseconds: 4000));
    });
  }

  void textRecognizerView() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => TextRecognizerView()));
  }

  void goToPlanSelection() {
    Navigator.pushReplacement(context,
        ForwardOrBackwardTransition(child: AvailablePlansPage(back: false)));
  }

  void goToHomeScreen() {
    Navigator.pushReplacement(
        context, ForwardOrBackwardTransition(child: HomeScreen(), back: false));
  }

  @override
  void dispose() {
    super.dispose();
    phoneController.dispose();
    instSernoController.dispose();
  }

  @override
  Widget build(BuildContext context) {
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

    if (response == 'false') {}

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(53, 56, 57, 1),
        body: Container(
          alignment: Alignment.center,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Debug",
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
                  labelText: "Enter installment plan",
                  hintText: "Either 1 or 2",
                  emptyErrorBool: true,
                  emptyErrorString: "This field cannot be empty",
                  minLengthErrorBool: false,
                  minLengthErrorStrict: false,
                  minLength: 0,
                  minLengthErrorString: "",
                  passwordBool: false,
                ),
                ElevatedButton(
                  onPressed: () {
                    AuthFunc.signOut(context: context);
                  },
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
                ElevatedButton(
                  onPressed: _saveLocationToDb,
                  child: Text("Save Location To Db"),
                ),
                ElevatedButton(
                  onPressed: textRecognizerView,
                  child: Text("Scan Text"),
                ),
                ElevatedButton(
                  onPressed: getAndStoreSms,
                  child: Text("Get and store sms"),
                ),
                ElevatedButton(
                  onPressed: goToPlanSelection,
                  child: Text("Go to plan selection"),
                ),
                ElevatedButton(
                  onPressed: goToHomeScreen,
                  child: Text("Go to home screen"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
