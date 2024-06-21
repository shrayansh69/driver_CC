import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:driver/auth/globals.dart';
import 'package:driver/auth/loader.dart';

import 'package:http/http.dart' as http;
import 'package:driver/auth/otp.dart';
import 'package:driver/main.dart';
import 'package:flutter/material.dart';

String phoneNumberC = "";
String verificationId = "";
String numm = "";
int phoneOTP = 0;

class loginScreen extends StatefulWidget {
  @override
  _loginScreenState createState() => _loginScreenState();
}

class _loginScreenState extends State<loginScreen> {
  final TextEditingController phoneNumberController = TextEditingController();
  Future<void> fetchData() async {
    phoneOTP = 100000 + Random().nextInt(900000);
    final phoneNumber = phoneNumberController.text;
    print(phoneNumberController.text);
    final url =
        'https://chopchoplogistic.com/smsgateway.php/?phone_number=$phoneNumber&otp=$phoneOTP';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        // Successful request, handle the response
        print('Response data: ${response.body}');
        // ScaffoldMessenger.of(context).showSnackBar(
        //   SnackBar(
        //     content: Text('OTP Sent to $phoneNumber'),
        //   ),
        // );
        Navigator.push(context, MaterialPageRoute(builder: (_) => otp()));
      } else {
        // Handle error
        print('Error: ${response.statusCode}');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to send OTP!'),
          ),
        );
      }
    } catch (e) {
      // Handle any exceptions that occurred during the request
      print('Exception: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(
            height: mq.height * 0.45,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: mq.height * 0.06,
                  ),
                  Container(
                    width: mq.width * 0.3,
                    child: Image.asset("assets/images/fire.png"),
                  ),
                  Text(
                    'Chop-Chop',
                    style: TextStyle(
                      fontSize: mq.height * 0.06,
                      fontWeight: FontWeight.w600,
                      color: const Color.fromARGB(255, 185, 05, 05),
                      fontFamily: "BRUSHSCI",
                    ),
                  ),
                  Text(
                    'Delivery Partner',
                    style: TextStyle(
                        fontSize: mq.height * 0.05,
                        fontWeight: FontWeight.w300,
                        color: const Color.fromARGB(255, 0, 128, 0)),
                  ),
                  Text(
                    'Welcome',
                    style: TextStyle(
                      fontSize: mq.height * 0.04,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Text(
                    "Log in to your account.",
                    style: TextStyle(
                        fontSize: mq.height * 0.025,
                        color: const Color.fromARGB(255, 0, 0, 0)),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: mq.height * 0.09,
            child: Padding(
              padding: const EdgeInsets.only(right: 20, left: 20),
              child: Container(
                  height: mq.height * 0.07,
                  decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.grey),
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(7.0),
                    child: Row(
                      children: [
                        const SizedBox(
                          width: 10,
                        ),
                        const Text(
                          "+91",
                          style: TextStyle(fontSize: 17),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Container(
                          width: mq.width * 0.66,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextField(
                                controller: phoneNumberController,
                                keyboardType: TextInputType.phone,
                                decoration: const InputDecoration(
                                    hintText: " Enter your Number",
                                    hintStyle: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.grey),
                                    border: InputBorder.none),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20, left: 20),
            child: SizedBox(
              height: mq.height * 0.06,
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        "You will receive an SMS verification that may apply\nmessage and data rates.",
                        style: TextStyle(
                            fontSize: 13,
                            color: Color.fromARGB(255, 75, 75, 75)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: mq.height * 0.2,
          ),
          SizedBox(
            height: mq.height * 0.2,
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: mq.width * 1,
                      child: TextButton(
                        onPressed: () async {
                          String phoneNumber = phoneNumberController.text;
                          phoneNumberC = phoneNumber;
                          phoneNumber = '+91$phoneNumber';
                          // fetchData(phoneNumber);
                          print(phoneNumber);

                          // _verifyPhoneNumber();
                          fetchData();
                          Navigator.push(context,
                              MaterialPageRoute(builder: (_) => LoadingPage()));
                        },
                        child: Container(
                          height: mq.height * 0.060,
                          width: mq.width * 0.86,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7),
                              border: Border.all(
                                  color:
                                      const Color.fromARGB(255, 185, 05, 05))),
                          child: const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "PROCEED",
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Color.fromRGBO(185, 5, 5, 1)),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const Text(
                  "By continuing, you agree to our",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Color.fromARGB(255, 70, 70, 70)),
                ),
                GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: SizedBox(
                              height: 400,
                              width: double.infinity,
                              child: SingleChildScrollView(
                                child: Padding(
                                  padding: EdgeInsets.all(20.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Terms & Conditions",
                                        style: TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Text(
                                          'Welcome to Chop-Chop! These terms of use ("Agreement") establish a legal contract between Chop-Chop Technologies Private Limited ("Chop-Chop" or "we" or "us") and you, the user. By accessing or using our website, you agree to comply with and be bound by these terms.'),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Text(
                                        '1. Interpretation',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Text(
                                        'A) Singular includes plural, and vice versa. Masculine includes feminine.\nB) Headings are for convenience and do not affect interpretation.\nC) References to individuals include heirs and juristic persons include affiliates.',
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Text(
                                        '2. Eligibility',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Text(
                                        'A) Users must be 18 or older. If under 18, parental consent is required.\nB) Chop-Chop may deny access if under 18 is detected.',
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Text(
                                        '3. Account Registration and Security',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Text(
                                        'A) Access as a registered or guest user.\nB) Registered users must maintain account security. Notify Chop-Chop of any unauthorized use.',
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Text(
                                        '4. Services',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Text(
                                        'A) Chop-Chop provides on-demand delivery and related services.\nB) We facilitate delivery services but do not own or control user products.',
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Text(
                                        '5. Use of the Website/Services',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Text(
                                        'Agree not to:\nA) Defame, abuse, harass, or violate rights.\nB) Publish inappropriate, defamatory, or unlawful content.\nC) Conduct surveys, contests, or chain letters.\nD) Use automated processes to access the website.',
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Text(
                                        '6. Third-Party Contents',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Text(
                                        'A) Users assume risk regarding others compliance.\n) External links are not controlled by us; different terms may apply.',
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Text(
                                        '7. Promotions, Discounts, and Coupons',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Text(
                                        'Chop-Chop reserves the right to offer discounts/promotions at its discretion. Participation is voluntary.',
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Text(
                                        '8. Communications',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Text(
                                        'Agree to receive electronic communications from Chop-Chop.',
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Text(
                                        '9. Limitation of Liability',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Text(
                                        'Chop-Chop is not liable for special, incidental, or consequential damages.',
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Text(
                                        '10. Updates',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Text(
                                        'Chop-Chop may update terms; continued use implies acceptance.',
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        });
                  },
                  child: const Text(
                    "Terms of Conditions",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        decoration: TextDecoration.underline,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Color.fromARGB(255, 50, 147, 185)),
                  ),
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }

  Future<void> _verifyPhoneNumber() async {
    // String phoneNumber = phoneNumberController.text;
    // numm = phoneNumber;
    // ConfirmNumber = phoneNumber;
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

    //       ;
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

  Future<void> _signInWithPhoneNumber() async {
    // String otp = "023847"; // Get the OTP from the user input

    // try {
    //   PhoneAuthCredential credential = PhoneAuthProvider.credential(
    //     verificationId: verificationId,
    //     smsCode: otp,
    //   );
    //   await _auth.signInWithCredential(credential);

    //   // You can now access the signed-in user
    //   User? user = _auth.currentUser;
    //   if (user != null) {
    //     print("User logged in: ${user.uid}");
    //   }
    // } catch (e) {
    //   print("Failed to sign in: $e");
    // }
  }
}
