import 'dart:convert';
import 'dart:io';
import 'package:driver/auth/loader.dart';
import 'package:driver/dashboard/afterlogin.dart';
import 'package:driver/dashboard/history.dart';
import 'package:driver/dashboard/map.dart';
import 'package:driver/dashboard/map2.dart';

import 'package:http/http.dart' as http;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:driver/auth/login_screen.dart';

import 'package:driver/auth/aadhar.dart';

import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';

import '../main.dart';

String otppp = "";

class otp1 extends StatefulWidget {
  @override
  _otp1State createState() => _otp1State();
}

class _otp1State extends State<otp1> {
  bool isApiResultTrue = false;
  bool isApiResultValid = false;
  TextEditingController ot = TextEditingController();

  final TextEditingController phoneNumberController = TextEditingController();

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
                                pageBuilder: (_, __, ___) => accept1(),
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
                          'Enter the 6-digit OTP displayed on Senders Application with phone $Numberr',
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
                      onPressed: () async {
                        print(otppp);
                        final response1 = await http.get(Uri.parse(
                            'https://chopchoplogistic.com/receiverOTP/api/list/$odd,$otppp'));
                        final response2 = await http.get(Uri.parse(
                            'https://chopchoplogistic.com/updateStatus/api/list/$odd'));
                        // 577
                        if (response1.statusCode == 200) {
                          final data1 = response1.body;

                          if (data1 == "true") {
                            if (response2.statusCode == 200) {
                              final data2 = response1.body;
                              if (data2 == "true") {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => accept2()));
                              }
                            }

                            // ignore: use_build_context_synchronously
                          } else if (data1 == "false") {
                            return showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title:
                                      Text("Wrong OTP! Try with correct OTP"),
                                );
                              },
                            );
                          }
                        }
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
                              "Receive Package",
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

  Future<void> _signInWithPhoneNumber(String opp) async {
    // String otp = opp; // Get the OTP from the user input
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
    //     // Navigator.push(context, MaterialPageRoute(builder: (_) => vehicle3()));
    //     // print("User logged in: ${user.uid}");
    //   }
    // } catch (e) {
    //   print("Failed to sign in: $e");
    // }
  }

  Future<void> checkOtp(bool val) async {
    String numbb = '+91$num';

    final response1 = await http.get(
        Uri.parse('https://chopchoplogistic.com/validUser/api/list/$numm'));

    if (response1.statusCode == 200) {
      final data1 = json.decode(response1.body);
      setState(() {
        isApiResultValid = data1; // Assuming the API response is a boolean
      });
    }
    print(numm);
    print(isApiResultValid);

    //   isApiResultTrue
    //       ? Navigator.push(context, MaterialPageRoute(builder: (_) => Alogin()))
    //       : Navigator.push(
    //           context, MaterialPageRoute(builder: (_) => vehicle3()));
    if (val) {
      if (isApiResultValid) {
        Navigator.push(context, MaterialPageRoute(builder: (_) => Alogin()));
      } else {
        Navigator.push(context, MaterialPageRoute(builder: (_) => vehicle3()));
      }
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              content: Text("Invalid OTP\nTry Again!!"), actions: []);
        },
      );
    }
  }
}
