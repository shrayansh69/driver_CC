import 'dart:io';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:driver/auth/globals.dart';
import 'package:driver/auth/login_screen.dart';
import 'package:driver/auth/profile.dart';
import 'package:driver/main.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

XFile? _image;
XFile? _image2;
TextEditingController CPhone = TextEditingController();

class vehicle3 extends StatefulWidget {
  const vehicle3({super.key});

  @override
  State<vehicle3> createState() => _vehicle3State();
}

class _vehicle3State extends State<vehicle3> {
  final ImagePicker _imagePicker = ImagePicker();

  Future<void> _pickImage() async {
    final XFile? pickedImage =
        await _imagePicker.pickImage(source: ImageSource.camera);

    if (pickedImage != null) {
      setState(() {
        _image = pickedImage;
        globalImage = _image;
      });
    }
  }

  final ImagePicker _imagePicker2 = ImagePicker();

  Future<void> _pickImage2() async {
    final XFile? pickedImage2 =
        await _imagePicker2.pickImage(source: ImageSource.camera);

    if (pickedImage2 != null) {
      setState(() {
        _image2 = pickedImage2;
        globalBackImage = _image2;
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
                          child: Image.asset("assets/images/vehicle_step1.png"),
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
                      "Verify Your Adhaar Card Details",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Colors.black),
                    ),
                    const Text(
                      "Mandatory*",
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Colors.red),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      "Enter your Adhaar Card Number to proceed further to next Step.",
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
                                    controller: CPhone,
                                    onChanged: (value) {
                                      ConfirmAadharNumber = value;
                                    },
                                    decoration: InputDecoration(
                                        hintText: "Enter Adhaar Card Number",
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
                                if (_image != null)
                                  Row(
                                    children: [
                                      Image.file(
                                        File(_image!.path),
                                        width: 30,
                                        height: 40,
                                      ),
                                      const SizedBox(
                                        width: 20,
                                      )
                                    ],
                                  ),
                                GestureDetector(
                                  onTap: _pickImage,
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
                                            (_image != null)
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
                          (_image != null)
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
                                if (_image2 != null)
                                  Row(
                                    children: [
                                      Image.file(
                                        File(_image2!.path),
                                        width: 30,
                                        height: 40,
                                      ),
                                      const SizedBox(
                                        width: 20,
                                      )
                                    ],
                                  ),
                                GestureDetector(
                                  onTap: _pickImage2,
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
                                            (_image2 != null)
                                                ? const Text(
                                                    "Uploaded",
                                                    style: TextStyle(
                                                        fontSize: 17,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: Colors.grey),
                                                  )
                                                : const Text(
                                                    "Upload Back Side",
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
                          (_image2 != null)
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
                  ],
                ),
              ),
            ),
            Container(
              height: mq.height * 0.25,
              child: TextButton(
                onPressed: () {
                  print(ConfirmNumber);
                  if (ConfirmAadharNumber == null ||
                      _image == null ||
                      _image2 == null) {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text("Error"),
                          content: const Text(
                              "Please make sure to fill all the details"),
                        );
                      },
                    );
                  } else {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => const vehicle5()));
                  }
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
            )
          ]),
        ),
      ),
    );
  }
}
