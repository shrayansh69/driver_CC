import 'dart:convert';
import 'dart:io';
import 'package:driver/auth/globals.dart';
import 'package:driver/dashboard/afterlogin.dart';
import 'package:driver/dashboard/history.dart';
import 'package:driver/dashboard/map.dart';
import 'package:driver/dashboard/map2.dart';
import 'package:driver/dashboard/orderPlaced.dart';

import 'package:http/http.dart' as http;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:driver/auth/login_screen.dart';

import 'package:driver/auth/aadhar.dart';

import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';

import '../main.dart';

String otppp = "";
double minus = 0;

class otp2 extends StatefulWidget {
  @override
  _otp2State createState() => _otp2State();
}

class _otp2State extends State<otp2> {
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
                          'Enter the 6-digit OTP displayed on Senders Application with phone $n',
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
                        print(ad);
                        print(Driver_UID);
                        print(DriverBalance);
                        print(DriverP);
                        final response3 = await http.get(Uri.parse(
                            'https://chopchoplogistic.com/receiverOTP/api/list2/$ad,$otppp'));

                        if (response3.statusCode == 200) {
                          final data3 = response3.body;
                          final response4 = await http.get(Uri.parse(
                              'https://chopchoplogistic.com/updateStatus/api/list2/$ad'));
                          if (data3 == "true") {
                            print("true");
                            if (response4.statusCode == 200) {
                              final data4 = response4.body;
                              if (data4 == "true") {
                                print("hello");
                                print(mode);
                                print(DriverBalance);
                                print(DriverP);
                                print(tot);
                                if (mode == "Online") {
                                  final response20 = await http.get(Uri.parse(
                                      'https://chopchoplogistic.com/updateWallet/api/add/$Driver_UID,$DriverP'));
                                  if (response20.statusCode == 200) {
                                    final data20 = response4.body;
                                    if (data20 == "true") {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) => OrderPlaced()));
                                    }
                                  }
                                } else if (mode == 'Cash') {
                                  minus = (tot - DriverP);
                                  print("minus,$minus ");
                                  minus = minus.abs();
                                  print(minus);
                                  final response21 = await http.get(Uri.parse(
                                      'https://chopchoplogistic.com/updateWallet/api/sub/$Driver_UID,$minus'));
                                  if (response21.statusCode == 200) {
                                    final data21 = response4.body;
                                    if (data21 == "true") {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) => OrderPlaced()));
                                    }
                                  }
                                }
                              }
                            } else {
                              print(response4.body);
                            }

                            //     // ignore: use_build_context_synchronously
                          } else if (data3 == "false") {
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
                              "Deliver Package",
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
