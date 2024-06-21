import 'dart:io';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:driver/auth/globals.dart';
import 'package:driver/auth/panCard.dart';
import 'package:driver/auth/profile.dart';
import 'package:driver/auth/license.dart';
import 'package:driver/main.dart';
import 'package:flutter/material.dart';

TextEditingController Vnum = TextEditingController();

// ignore: camel_case_types
class vehicle extends StatefulWidget {
  const vehicle({super.key});

  @override
  State<vehicle> createState() => _vehicleState();
}

class _vehicleState extends State<vehicle> {
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
        body: SingleChildScrollView(
          child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            Container(
              height: mq.height * 0.75,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: mq.height * 0.08,
                    ),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                pageBuilder: (_, __, ___) => const vehicle4(),
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
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: mq.height * 0.05,
                      child: const AutoSizeText(
                        'Delivery Partner',
                        style: TextStyle(
                            fontSize: 38,
                            fontWeight: FontWeight.w300,
                            color: Color.fromARGB(255, 0, 128, 0)),
                        minFontSize: 30,
                        maxFontSize: 38,
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          child: Image.asset("assets/images/vehicle_step4.png"),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    const SizedBox(
                      height: 7.8,
                    ),
                    const Text(
                      "Verify Your Vehicle Number",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Colors.black),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      "Enter your Vehicle Number to proceed further to next Step.",
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Color.fromARGB(255, 97, 97, 97)),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                        decoration: BoxDecoration(
                          border: Border.all(width: 1, color: Colors.grey),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8)),
                        ),
                        child: Row(
                          children: [
                            const SizedBox(
                              width: 20,
                            ),
                            SizedBox(
                              width: mq.width * 0.66,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  TextField(
                                    controller: Vnum,
                                    onChanged: (value) {
                                      ConfirmVehicleNumber = value;
                                    },
                                    decoration: InputDecoration(
                                        hintText: "Enter Vehicle Number",
                                        hintStyle: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.grey),
                                        border: InputBorder.none),
                                  ),
                                ],
                              ),
                            )
                          ],
                        )),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: mq.height * 0.25,
              child: Padding(
                padding: const EdgeInsets.all(40),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => const vehicle2()));
                        },
                        child: const Text(
                          "Skip",
                          style: TextStyle(
                              fontSize: 18,
                              color: Color.fromARGB(255, 185, 05, 05),
                              decoration: TextDecoration.underline),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          print(ConfirmVehicleNumber);
                          Navigator.push(context,
                              MaterialPageRoute(builder: (_) => vehicle2()));
                        },
                        child: Container(
                          height: 45,
                          width: mq.width * 0.3,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7),
                              border: Border.all(
                                  color:
                                      const Color.fromARGB(255, 185, 05, 05))),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Next",
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Color.fromARGB(255, 185, 05, 05)),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ]),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
