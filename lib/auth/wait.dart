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

class wait extends StatelessWidget {
  const wait({super.key});

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
        body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(
            height: mq.height * 0.85,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: mq.height * 0.07,
                  ),
                  Container(
                    width: mq.width * 0.3,
                    child: Image.asset("assets/images/fire.png"),
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
                    height: mq.height * 0.03,
                  ),
                  Center(
                    child: Container(
                        height: mq.height * 0.3,
                        child: Image.asset("assets/images/124.png")),
                  ),
                  SizedBox(
                    height: mq.height * 0.03,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Status : ",
                          style: TextStyle(
                              fontSize: mq.width * 0.06,
                              color: const Color.fromARGB(255, 0, 0, 0)),
                        ),
                        Text(
                          "Pending",
                          style: TextStyle(
                              fontSize: mq.width * 0.06, color: Colors.red),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "You will be contacted soon once we complete our online verification.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: mq.width * 0.055,
                        color: const Color.fromARGB(255, 75, 75, 75)),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: mq.height * 0.1,
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [],
                ),
                SizedBox(
                  height: mq.height * 0.05,
                ),
                Text(
                  "NOTE : Once online verification is successful you\n             to visit our office for offline verification.",
                  style: TextStyle(
                      fontSize: mq.width * 0.03,
                      color: const Color.fromARGB(255, 75, 75, 75)),
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
