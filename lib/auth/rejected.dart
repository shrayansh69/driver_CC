// ignore_for_file: unused_import

import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:driver/auth/aadhar.dart';
import 'package:driver/auth/globals.dart';
import 'package:http/http.dart' as http;

import 'package:driver/dashboard/afterlogin.dart';
import 'package:driver/dashboard/test.dart';
import 'package:driver/main.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class rejected extends StatelessWidget {
  const rejected({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final value = await showDialog<bool>(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text("Alert"),
              content: const Text("Are you sure you want to exit ?"),
              actions: [
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: const Text("NO"),
                ),
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(exit(1)),
                  child: const Text("YES"),
                )
              ],
            );
          },
        );
        if (value != null) {
          return Future.value(value);
        } else {
          return Future.value(false);
        }
      },
      child: Scaffold(
        body: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          SizedBox(
            height: mq.height * 1,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: mq.height * 0.07,
                  ),
                  Text(
                    'Chop-Chop',
                    style: TextStyle(
                      fontSize: mq.width * 0.13,
                      fontWeight: FontWeight.w600,
                      color: const Color.fromARGB(255, 185, 05, 05),
                      fontFamily: "BRUSHSCI",
                    ),
                  ),
                  Text(
                    'Delivery Partner',
                    style: TextStyle(
                        fontSize: mq.width * 0.1,
                        fontWeight: FontWeight.w300,
                        color: const Color.fromARGB(255, 0, 128, 0)),
                  ),
                  SizedBox(
                    height: mq.height * 0.05,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Status : ",
                          style: TextStyle(
                              fontSize: mq.width * 0.05,
                              color: const Color.fromARGB(255, 0, 0, 0)),
                        ),
                        Text(
                          "Rejected",
                          style: TextStyle(
                              fontSize: mq.width * 0.05,
                              color: Color.fromARGB(255, 185, 05, 05)),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                      width: mq.width * 0.5,
                      child: Image.asset("assets/images/rejected.png")),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    "Please visit Our Office for any enquiry or contact Us at",
                    style: TextStyle(
                        fontSize: mq.width * 0.06,
                        fontWeight: FontWeight.w500,
                        color: const Color.fromARGB(255, 75, 75, 75)),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 60,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Address : ",
                              style: TextStyle(
                                fontSize: mq.width * 0.04,
                              ),
                            ),
                            Text(
                              "D-73, Harbanswala, Seemadwar\nDehradun, Uttarakhand, 248001",
                              style: TextStyle(
                                fontSize: mq.width * 0.04,
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Contact : ",
                              style: TextStyle(
                                fontSize: mq.width * 0.04,
                              ),
                            ),
                            Text(
                              "+91 8193054444",
                              style: TextStyle(
                                fontSize: mq.width * 0.04,
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Email : ",
                              style: TextStyle(
                                fontSize: mq.width * 0.04,
                              ),
                            ),
                            Text(
                              "Support@chopchoplogistic.com",
                              style: TextStyle(
                                fontSize: mq.width * 0.04,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
