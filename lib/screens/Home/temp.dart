import 'dart:typed_data';
import 'package:bnpl/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:aws_lambda_api/lambda-2015-03-31.dart' as lambda;

import '../auth/components/errorSnackBar.dart';
import '../components/file_read_write.dart';

class Temp extends StatefulWidget {
  @override
  State<Temp> createState() => _TempState();
}

class _TempState extends State<Temp> {
  late String? token;
  String response = 'whatis';
  bool isLoaded = false;
  Map<String, String> attributes = {};
  TextEditingController phoneController = TextEditingController();

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
        attributes[element.userAttributeKey.toString()] = element.value;
        // print('key: ${element.userAttributeKey}; value: ${element.value}');
      });
      // print(attributes);
    } on AuthException catch (e) {
      context.showErrorSnackBar(message: e.message);
    }
  }

  Future<void> what() async {
    try {
      await Amplify.Auth.signOut(options: SignOutOptions(globalSignOut: true));
      print('success');
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: ((context) => Login(attributes: attributes))));
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

    if (response == 'false') {
      context.showErrorSnackBar(message: 'Error contacting server.');
      context.showErrorSnackBar(message: 'Check your internet connection');
    }

    return Scaffold(
      backgroundColor: const Color.fromRGBO(53, 56, 57, 1),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                if (attributes['identities']!.contains('Google')) {
                  print(writeDetails("${attributes['email']} Google"));
                  print(1);
                } else if (attributes['identities']!.contains('Facebook')) {
                  print(writeDetails("${attributes['email']} Facebook"));
                  print(2);
                }
                what();
              },
              child: const Text("Signout"),
            ),
            ElevatedButton(
              onPressed: () {
                testCallLambda();
              },
              child: const Text("Retry"),
            ),
            TextField(
              keyboardType: TextInputType.phone,
              controller: phoneController,
            ),
            ElevatedButton(
              onPressed: () {
                // _sendSMS('your code is 123456', ['9860285402']);
              },
              child: const Text("Confirm"),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // if (attributes.length == 4)
                //   Text(
                //     'Cognito Id: ${attributes['sub']}',
                //     style: const TextStyle(
                //       color: Color.fromARGB(255, 0, 255, 213),
                //     ),
                //   ),
                // const SizedBox(height: 10),
                // if (attributes.length == 4)
                //   Text(
                //     'Google Id: ${(attributes['identities'])}',
                //     style: const TextStyle(
                //       color: Color.fromARGB(255, 0, 255, 213),
                //     ),
                //   ),
                // const SizedBox(height: 10),
                // if (attributes.length == 4)
                //   Text(
                //     'email: ${attributes['email']}',
                //     style: const TextStyle(
                //       color: Color.fromARGB(255, 0, 255, 213),
                //     ),
                //   ),
                // if (attributes.length < 4)
                //   Text(
                //     'Cognito Id: ${attributes['sub']}',
                //     style: const TextStyle(
                //       color: Color.fromARGB(255, 0, 255, 213),
                //     ),
                //   ),
                // const SizedBox(height: 10),
                // if (attributes.length < 4)
                //   Text(
                //     'Email Verified: ${attributes['email_verified']}',
                //     style: const TextStyle(
                //       color: Color.fromARGB(255, 0, 255, 213),
                //     ),
                //   ),
                // const SizedBox(height: 10),
                // if (attributes.length < 4)
                //   Text(
                //     'Email: ${attributes['email']}',
                //     style: const TextStyle(
                //       color: Color.fromARGB(255, 0, 255, 213),
                //     ),
                //   ),
                // const SizedBox(height: 20),
                Text(
                  'Lambda Result: $response',
                  style: const TextStyle(
                    color: Colors.red,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
