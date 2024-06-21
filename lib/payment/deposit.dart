import 'dart:convert';
import 'package:driver/auth/globals.dart';
import 'package:driver/auth/loader.dart';
import 'package:driver/dashboard/afterlogin.dart';
import 'package:driver/dashboard/profile.dart';
import 'package:driver/dashboard/test.dart';
import 'package:driver/main.dart';
import 'package:driver/payment/confirmation.dart';
import 'package:driver/payment/phonePe.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:http/http.dart' as http;

int GlobalID = 0;
double GlobalAmount = 100;
int GlobalNumber = 0;
String GlobalResponse = '';
int money = 0;
bool selected = false;
bool selected1 = false;
bool selected2 = false;
bool selected3 = false;
bool selected4 = false;
String walletType = "Please Select Wallet";

class deposit extends StatefulWidget {
  const deposit({Key? key});

  @override
  State<deposit> createState() => _depositState();
}

class _depositState extends State<deposit> {
  double _currentSliderValue = 20;
  bool checkboxValue1 = false;
  bool checkboxValue2 = false;
  bool checkboxValue3 = false;
  bool checkboxValue4 = false;
  Future<void> makePostRequest() async {
    final url =
        Uri.parse('https://chopchoplogistic.com/Counter/api/increment-count');

    try {
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        // get count variable
        print('true');
        makeGetRequest();
      } else {
        print('Error: ${response.statusCode} - ${response.reasonPhrase}');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  Future<void> makeGetRequest() async {
    final url = Uri.parse('https://chopchoplogistic.com/Counter/api/get-count');

    try {
      final response = await http.get(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = json.decode(response.body);
        int countValue = jsonResponse['count'];
        print(countValue);
        GlobalID = countValue;
        makeGetRequest2();
      } else {
        print('Error: ${response.statusCode} - ${response.reasonPhrase}');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  Future<void> makeGetRequest2() async {
    var url = Uri.parse(
        'https://chopchoplogistic.com/Payment/phonepe/$nmbr/$GlobalAmount/$GlobalID');

    try {
      // Make the GET request
      final response = await http.get(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json',
          // Add any other headers as needed
        },
      );

      // Check if the request was successful (status code 200)
      if (response.statusCode == 200) {
        // Handle the response as needed
        GlobalResponse = response.body;
        print(GlobalResponse);
        Navigator.push(context, MaterialPageRoute(builder: (_) => phonePe()));
      } else {
        // Request failed with a non-200 status code
        print('Error: ${response.statusCode} - ${response.reasonPhrase}');
      }
    } catch (error) {
      // Handle any errors that occurred during the request
      print('Error: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: GestureDetector(
            onTap: () {
              Navigator.of(context)
                  .pushReplacement(MaterialPageRoute(builder: (_) => Alogin()));
            },
            child: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
          ),
          title: const Text(
            "Transaction Details",
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Amount',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                          height: 0,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Rs ' +
                            money.toString(), // Convert the integer to a string
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 34,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                          height: 0,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Your Curent Balance : ', // Convert the integer to a string
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                          height: 0,
                        ),
                      ),
                      Text(
                        '${DriverBalance.toString()}', // Convert the integer to a string
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                          height: 0,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: mq.width * 0.8,
                        child: Slider(
                            activeColor: const Color.fromARGB(255, 0, 128, 0),
                            value: _currentSliderValue,
                            max: 10000,
                            divisions: 100,
                            inactiveColor:
                                const Color.fromARGB(255, 215, 215, 215),
                            label: _currentSliderValue.round().toString(),
                            onChanged: (double value) {
                              setState(() {
                                _currentSliderValue = value;
                                money = value.toInt();
                                selected = false;
                                selected1 = false;
                                selected2 = false;
                                selected3 = false;
                              });
                            }),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            money = 100;
                            selected = true;
                            selected1 = false;
                            selected2 = false;
                            selected3 = false;
                          });
                        },
                        child: Container(
                          width: 61,
                          height: 60,
                          child: Stack(
                            children: [
                              Positioned(
                                left: 0,
                                top: 0,
                                child: Opacity(
                                  opacity: 0.10,
                                  child: Container(
                                    width: 61,
                                    height: 60,
                                    decoration: ShapeDecoration(
                                      color: selected ?? true
                                          ? Colors.green
                                          : const Color(0xFFFBFBFB),
                                      shape: RoundedRectangleBorder(
                                        side: const BorderSide(width: 0.50),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const Positioned(
                                left: 15,
                                top: 18,
                                child: Text(
                                  '100',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w500,
                                    height: 0,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            money = 200;
                            selected = false;
                            selected1 = true;
                            selected2 = false;
                            selected3 = false;
                          });
                        },
                        child: Container(
                          width: 61,
                          height: 60,
                          child: Stack(
                            children: [
                              Positioned(
                                left: 0,
                                top: 0,
                                child: Opacity(
                                  opacity: 0.10,
                                  child: Container(
                                    width: 61,
                                    height: 60,
                                    decoration: ShapeDecoration(
                                      color: selected1 ?? true
                                          ? Colors.green
                                          : const Color(0xFFFBFBFB),
                                      shape: RoundedRectangleBorder(
                                        side: const BorderSide(width: 0.50),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const Positioned(
                                left: 15,
                                top: 18,
                                child: Text(
                                  '200',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w500,
                                    height: 0,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            money = 500;
                            selected = false;
                            selected1 = false;
                            selected2 = true;
                            selected3 = false;
                          });
                        },
                        child: Container(
                          width: 61,
                          height: 60,
                          child: Stack(
                            children: [
                              Positioned(
                                left: 0,
                                top: 0,
                                child: Opacity(
                                  opacity: 0.10,
                                  child: Container(
                                    width: 61,
                                    height: 60,
                                    decoration: ShapeDecoration(
                                      color: selected2 ?? true
                                          ? Colors.green
                                          : const Color(0xFFFBFBFB),
                                      shape: RoundedRectangleBorder(
                                        side: const BorderSide(width: 0.50),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const Positioned(
                                left: 15,
                                top: 18,
                                child: Text(
                                  '500',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w500,
                                    height: 0,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            money = 1000;
                            selected = false;
                            selected1 = false;
                            selected2 = false;
                            selected3 = true;
                          });
                        },
                        child: Container(
                          width: 61,
                          height: 60,
                          child: Stack(
                            children: [
                              Positioned(
                                left: 0,
                                top: 0,
                                child: Opacity(
                                  opacity: 0.10,
                                  child: Container(
                                    width: 61,
                                    height: 60,
                                    decoration: ShapeDecoration(
                                      color: selected3 ?? true
                                          ? Colors.green
                                          : const Color(0xFFFBFBFB),
                                      shape: RoundedRectangleBorder(
                                        side: const BorderSide(width: 0.50),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const Positioned(
                                left: 10,
                                top: 18,
                                child: Text(
                                  '1000',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w500,
                                    height: 0,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: mq.width * 1,
                    child: TextButton(
                      onPressed: () {
                        var dt = DateTime.now();
                        GlobalAmount = money.toDouble();
                        pay = false;
                        // Navigator.push(context,
                        //     MaterialPageRoute(builder: (_) => confirm()));
                        showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return Container(
                              // width: mq.width * 0.8,
                              height: mq.height * 0.4,
                              decoration: ShapeDecoration(
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              child: Column(
                                children: [
                                  const SizedBox(
                                    height: 30,
                                  ),
                                  const Text(
                                    'Payment Details',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 22,
                                      fontFamily: 'Titillium Web',
                                      fontWeight: FontWeight.w600,
                                      height: 0,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 40, right: 40, top: 30),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Opacity(
                                          opacity: 0.40,
                                          child: Text(
                                            'Amount',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 12,
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w400,
                                              height: 0,
                                            ),
                                          ),
                                        ),
                                        Text(
                                          'Rs ' + money.toString(),
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 12,
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w600,
                                            height: 0,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 40, right: 40, top: 20),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Opacity(
                                          opacity: 0.40,
                                          child: Text(
                                            'Date',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 12,
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w400,
                                              height: 0,
                                            ),
                                          ),
                                        ),
                                        Text(
                                          dt.day.toString() +
                                              '/' +
                                              dt.month.toString() +
                                              '/' +
                                              dt.year.toString(),
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 12,
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w600,
                                            height: 0,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 40, right: 40, top: 20),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Opacity(
                                          opacity: 0.40,
                                          child: Text(
                                            'Time',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 12,
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w400,
                                              height: 0,
                                            ),
                                          ),
                                        ),
                                        Text(
                                          dt.hour.toString() +
                                              ':' +
                                              dt.minute.toString(),
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 12,
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w600,
                                            height: 0,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 50,
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        width: mq.width * 1,
                                        child: TextButton(
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (_) =>
                                                        LoadingPage()));
                                            makePostRequest();
                                          },
                                          child: Container(
                                            height: mq.height * 0.060,
                                            width: mq.width * 0.8,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(7),
                                                border: Border.all(
                                                    color: const Color.fromARGB(
                                                        255, 185, 05, 05))),
                                            child: const Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  "DEPOSIT",
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      color: Color.fromARGB(
                                                          255, 185, 05, 05)),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                      child: Container(
                        height: mq.height * 0.060,
                        width: mq.width * 0.86,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(7),
                            border: Border.all(
                                color: const Color.fromARGB(255, 185, 05, 05))),
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "PROCEED",
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
            ]));
  }
}
