import 'dart:io';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:driver/auth/globals.dart';
import 'package:driver/auth/profile.dart';
import 'package:driver/auth/vehicle_number.dart';
import 'package:driver/main.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

XFile? _image4;
XFile? _image5;
TextEditingController CPan = TextEditingController();

// ignore: camel_case_types
class vehicle4 extends StatefulWidget {
  const vehicle4({super.key});

  @override
  State<vehicle4> createState() => _vehicle4State();
}

class _vehicle4State extends State<vehicle4> {
  final ImagePicker _imagePicker4 = ImagePicker();
  Future<void> _pickImage4() async {
    final XFile? pickedImage4 =
        await _imagePicker4.pickImage(source: ImageSource.camera);

    if (pickedImage4 != null) {
      setState(() {
        _image4 = pickedImage4;
        panFimage = _image4;
      });
    }
  }

  final ImagePicker _imagePicker5 = ImagePicker();
  Future<void> _pickImage5() async {
    final XFile? pickedImage5 =
        await _imagePicker5.pickImage(source: ImageSource.camera);

    if (pickedImage5 != null) {
      setState(() {
        _image5 = pickedImage5;
        panBimage = _image5;
      });
    }
  }

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
                                pageBuilder: (_, __, ___) => const vehicle5(),
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
                          child: Image.asset("assets/images/vehicle_step3.png"),
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
                      "Verify Your Pan Card Details",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Colors.black),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      "Enter your Pan Card Number to proceed further to next Step.",
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
                                    controller: CPan,
                                    onChanged: (value) {
                                      ConfirmPanNumber = value;
                                    },
                                    decoration: InputDecoration(
                                        hintText: "Enter Pan Card Number",
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
                    const SizedBox(
                      height: 20,
                    ),
                    // Container(
                    //   decoration: BoxDecoration(
                    //     border: Border.all(width: 1, color: Colors.grey),
                    //     borderRadius: const BorderRadius.all(Radius.circular(8)),
                    //   ),
                    //   child: Row(
                    //     children: [
                    //       const SizedBox(
                    //         width: 20,
                    //       ),
                    //       Container(
                    //         width: mq.width * 0.75,
                    //         child: const Column(
                    //           mainAxisAlignment: MainAxisAlignment.center,
                    //           children: [
                    //             TextField(
                    //               decoration: InputDecoration(
                    //                   hintText: "Upload Front Side",
                    //                   hintStyle: TextStyle(
                    //                       fontSize: 17,
                    //                       fontWeight: FontWeight.w500,
                    //                       color: Colors.grey),
                    //                   border: InputBorder.none),
                    //             ),
                    //           ],
                    //         ),
                    //       ),
                    //       const Icon(
                    //         Icons.upload_file_sharp,
                    //         color: Colors.grey,
                    //       )
                    //     ],
                    //   ),
                    // ),
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
                          Container(
                            width: mq.width * 0.75,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                if (_image4 != null)
                                  Row(
                                    children: [
                                      Image.file(
                                        File(_image4!.path),
                                        width: 30,
                                        height: 40,
                                      ),
                                      const SizedBox(
                                        width: 20,
                                      )
                                    ],
                                  ),
                                GestureDetector(
                                  onTap: _pickImage4,
                                  child: SizedBox(
                                    height: 50,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            (_image4 != null)
                                                ? const Text(
                                                    "Uploaded",
                                                    style: TextStyle(
                                                        fontSize: 17,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: Colors.grey),
                                                  )
                                                : const Text(
                                                    "Upload Front Side",
                                                    style: TextStyle(
                                                        fontSize: 17,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: Colors.grey),
                                                  ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          (_image4 != null)
                              ? const Icon(
                                  Icons.check,
                                  color: Color.fromARGB(255, 0, 128, 0),
                                )
                              : const Icon(
                                  Icons.upload_file_sharp,
                                  color: Colors.grey,
                                )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    // Container(
                    //     decoration: BoxDecoration(
                    //       border: Border.all(width: 1, color: Colors.grey),
                    //       borderRadius:
                    //           const BorderRadius.all(Radius.circular(8)),
                    //     ),
                    //     child: Row(
                    //       children: [
                    //         const SizedBox(
                    //           width: 20,
                    //         ),
                    //         Container(
                    //           width: mq.width * 0.75,
                    //           child: const Column(
                    //             mainAxisAlignment: MainAxisAlignment.center,
                    //             children: [
                    //               TextField(
                    //                 decoration: InputDecoration(
                    //                     hintText: "Upload Back Side",
                    //                     hintStyle: TextStyle(
                    //                         fontSize: 17,
                    //                         fontWeight: FontWeight.w500,
                    //                         color: Colors.grey),
                    //                     border: InputBorder.none),
                    //               ),
                    //             ],
                    //           ),
                    //         ),
                    //         const Icon(
                    //           Icons.upload_file_sharp,
                    //           color: Colors.grey,
                    //         )
                    //       ],
                    //     )),
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
                                  builder: (_) => const vehicle()));
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
                          print(ConfirmPanNumber);
                          Navigator.push(context,
                              MaterialPageRoute(builder: (_) => vehicle()));
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
