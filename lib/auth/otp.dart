import 'dart:convert';
import 'dart:io';
import 'package:driver/auth/globals.dart';
import 'package:driver/auth/rejected.dart';
import 'package:driver/auth/wait.dart';
import 'package:driver/auth/wait2.dart';
import 'package:driver/dashboard/afterlogin.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:driver/auth/login_screen.dart';

import 'package:driver/auth/aadhar.dart';

import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';

import '../main.dart';

String otppp = "";
String opp = "";
String isApiResultValid = "";

class otp extends StatefulWidget {
  @override
  _otpState createState() => _otpState();
}

class _otpState extends State<otp> {
  bool isApiResultTrue = false;
  final introdata = GetStorage();

  final TextEditingController phoneNumberController = TextEditingController();
  Future<void> ExistingUser() async {
    print(otppp);
    print("otppp");
    ExistingUse();
  }

  @override
  Widget build(BuildContext context) {
    bool isOtp = false;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: mq.height * 0.75,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: mq.height * 0.08,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                pageBuilder: (_, __, ___) => loginScreen(),
                                transitionsBuilder: (_,
                                    Animation<double> animation,
                                    __,
                                    Widget child) {
                                  return SlideTransition(
                                    position: Tween<Offset>(
                                      begin: const Offset(-1.0, 0.0),
                                      end: Offset.zero,
                                    ).animate(animation),
                                    child: child,
                                  );
                                },
                              ),
                            );
                          },
                          child: const Icon(Icons.arrow_back),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                pageBuilder: (_, __, ___) => Alogin(),
                                transitionsBuilder: (_,
                                    Animation<double> animation,
                                    __,
                                    Widget child) {
                                  return SlideTransition(
                                    position: Tween<Offset>(
                                      begin: const Offset(-1.0, 0.0),
                                      end: Offset.zero,
                                    ).animate(animation),
                                    child: child,
                                  );
                                },
                              ),
                            );
                          },
                          child: const Text(
                            "Change Number",
                            style: TextStyle(
                                color: Color.fromARGB(255, 185, 05, 05),
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: mq.height * 0.03,
                    ),
                    const AutoSizeText(
                      'Enter authentication code',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                      ),
                      minFontSize: 16,
                      maxFontSize: 28,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(right: 20, left: 20, top: 10),
                      child: SizedBox(
                        height: mq.height * 0.04,
                        child: AutoSizeText(
                          'Enter the 6-digit OTP that we have sent via SMS to the phone number $phoneNumberC',
                          style: const TextStyle(
                            color: Color.fromARGB(255, 81, 81, 81),
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.center,
                          minFontSize: 10,
                          maxFontSize: 17,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: mq.height * 0.05,
                    ),
                    OtpTextField(
                      numberOfFields: 6,
                      showFieldAsBox: true,
                      fieldWidth: 40,
                      focusedBorderColor: Color.fromARGB(255, 0, 128, 0),
                      enabledBorderColor: Colors.grey,
                      onCodeChanged: (String code) {
                        //handle validation or checks here

                        print(otppp);
                      },
                      onSubmit: (String verificationCode) {
                        isOtp = true;
                        otppp = verificationCode;
                      },
                    )
                  ],
                ),
              ),
            ),
            Container(
              height: mq.height * 0.2,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: mq.width * 1,
                    child: TextButton(
                      onPressed: () {
                        print(otppp.toString());
                        String te = phoneOTP.toString();
                        // te = "503493";
                        if (otppp == te) {
                          print("Successful");
                          ExistingUser();
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Incorrect Otp. Try again.'),
                            ),
                          );
                        }
                        // _signInWithPhoneNumber(otppp);
                        // Navigator.push(context,
                        //     MaterialPageRoute(builder: (_) => vehicle3()));
                        // checkOtp(phoneNumberC, otppp);
                      },
                      child: Container(
                        height: mq.height * 0.060,
                        width: mq.width * 0.86,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(7),
                            border: Border.all(
                                color: isOtp
                                    ? Colors.amber
                                    : Color.fromARGB(255, 185, 05, 05))),
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Login",
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Color.fromARGB(255, 185, 05, 05)),
                            ),
                          ],
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
    );
  }

  Future<void> _verifyPhoneNumber() async {
    // String phoneNumber = phoneNumberController.text;

    // await _auth.verifyPhoneNumber(
    //   phoneNumber: '+91$phoneNumber',
    //   // phoneNumber: '+919304837716',
    //   verificationCompleted: (PhoneAuthCredential credential) {},
    //   verificationFailed: (FirebaseAuthException e) {
    //     print("Verification failed: ${e.message}");
    //   },
    //   codeSent: (String verificationIdd, int? resendToken) {
    //     setState(() {
    //       verificationId = verificationIdd;
    //     });
    //     ScaffoldMessenger.of(context).showSnackBar(
    //       SnackBar(
    //         content: Text('OTP Sent to $phoneNumber'),
    //       ),
    //     );
    //   },
    //   codeAutoRetrievalTimeout: (String verificationId) {},
    // );
  }

  Future<void> _signInWithPhoneNumber(String opp) async {
    // String otp = opp;
    // // Get the OTP from the user input
    // print(otp);
    // try {
    //   PhoneAuthCredential credential = PhoneAuthProvider.credential(
    //     verificationId: verificationId,
    //     smsCode: otp,
    //   );
    //   await _auth.signInWithCredential(credential);

    //   // You can now access the signed-in user
    //   User? user = _auth.currentUser;
    //   print(otp);
    //   if (user != null) {
    //     checkOtp(true);
    //     ConfirmUID = user.uid;
    //     introdata.write('UID', ConfirmUID);
    //     // Navigator.push(context, MaterialPageRoute(builder: (_) => vehicle3()));
    //     // print("User logged in: ${user.uid}");
    //   }
    // } catch (e) {
    //   print("Failed to sign in: $e");
    // }
  }
  Future<void> ExistingUse() async {
    final url =
        'https://chopchoplogistic.com/UserValidity/api/dlist/$phoneNumberC';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        print(responseData['exists']);
        String Check = responseData['exists'].toString();
        // Check if the 'exists' key is present in the response
        if ((Check == "true")) {
          String userExists = responseData['UID'];
          print(userExists);
          introdata.write('UID', userExists);
          checkOtp(true);
          //       nameStorage.write('Contact', numm);
        } else {
          print("not a existing user");
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => vehicle3()));
        }
      } else {
        // Handle error
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      // Handle exceptions
      print('Exception: $e');
    }
  }

  Future<void> checkOtp(bool val) async {
    String numbb = '+91$phoneNumberC';

    final response1 = await http.get(Uri.parse(
        'https://chopchoplogistic.com/validUser/api/list/$phoneNumberC'));

    if (response1.statusCode == 200) {
      final data1 = (response1.body);
      setState(() {
        isApiResultValid = data1; // Assuming the API response is a boolean
      });
    }
    print(phoneNumberC);
    print(isApiResultValid);

    //   isApiResultTrue
    //       ? Navigator.push(context, MaterialPageRoute(builder: (_) => Alogin()))
    //       : Navigator.push(
    //           context, MaterialPageRoute(builder: (_) => vehicle3()));
    if (val) {
      if (isApiResultValid == "P") {
        Navigator.push(context, MaterialPageRoute(builder: (_) => wait()));
      } else if (isApiResultValid == "A") {
        Navigator.push(context, MaterialPageRoute(builder: (_) => wait2()));
      } else if (isApiResultValid == "R") {
        Navigator.push(context, MaterialPageRoute(builder: (_) => rejected()));
      } else if (isApiResultValid == "C") {
        introdata.write("loggedIN", true);
        Navigator.push(context, MaterialPageRoute(builder: (_) => Alogin()));
      } else if (isApiResultValid == "User not found") {
        Navigator.push(context, MaterialPageRoute(builder: (_) => vehicle3()));
      }
    }
  }
}
