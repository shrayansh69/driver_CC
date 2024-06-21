import 'dart:io';
import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:driver/auth/globals.dart';
import 'package:driver/auth/loader.dart';
import 'package:driver/auth/login_screen.dart';
import 'package:driver/auth/profile.dart';
import 'package:driver/auth/wait.dart';
import 'package:driver/main.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

TextEditingController BAnum = TextEditingController();
TextEditingController BAifsc = TextEditingController();
TextEditingController BAbank = TextEditingController();
TextEditingController BAbranch = TextEditingController();

class bank extends StatefulWidget {
  const bank({super.key});

  @override
  State<bank> createState() => _bankState();
}

class _bankState extends State<bank> {
  Future<void> postData() async {
    const String apiUrl =
        'https://chopchoplogistic.com/DeliveryRegistration/api/send';

    // Load image files
    String imagePath = globalImage!.path;
    File imageFile = File(imagePath);

    String imagePath2 = globalBackImage!.path;
    File imageFile2 = File(imagePath2);

    String imagePath3 = frontProfile!.path;
    File imageFile3 = File(imagePath3);

    String imagePath4 = frontProfile!.path;
    File imageFile4 = File(imagePath4);

    String imagePath5 = frontProfile!.path;
    File imageFile5 = File(imagePath5);

    String imagePath6 = frontProfile!.path;
    File imageFile6 = File(imagePath6);

    String imagePath7 = frontProfile!.path;
    File imageFile7 = File(imagePath7);
    String alphanumericCode = String.fromCharCodes(List.generate(
        15, (index) => (index.isEven ? 65 : 97) + (Random().nextInt(26))));
    ConfirmUID = alphanumericCode;
    print(alphanumericCode);
    // JSON data
    Map<String, String> jsonFields = {
      "UID": ConfirmUID,
      "phone": phoneNumberC,
      "aadharNum": ConfirmAadharNumber,
      "panNum": ConfirmPanNumber,
      "licenseNum": ConfirmLicenseNumber,
      "bankAccNum": ConfirmBankAccountNumber,
      "ifscCode": ConfirmIfscCode,
      "bankName": ConfirmBankName,
      "vehicleNumber": ConfirmVehicleNumber,
      "branchName": ConfirmBranch,
    };

    try {
      var request = http.MultipartRequest('POST', Uri.parse(apiUrl));

      // Add JSON fields
      request.fields.addAll(jsonFields);

      // Add image file
      request.files.add(http.MultipartFile(
        'aadharFimage',
        imageFile.readAsBytes().asStream(),
        imageFile.lengthSync(),
        filename: 'aadharFimage.jpg',
      ));

      request.files.add(http.MultipartFile(
        'aadharBimage',
        imageFile2.readAsBytes().asStream(),
        imageFile2.lengthSync(),
        filename: 'aadharBimage.jpg',
      ));

      request.files.add(http.MultipartFile(
        'frontProfile',
        imageFile3.readAsBytes().asStream(),
        imageFile3.lengthSync(),
        filename: 'frontProfile.jpg',
      ));

      request.files.add(http.MultipartFile(
        'panFimage',
        imageFile4.readAsBytes().asStream(),
        imageFile4.lengthSync(),
        filename: 'panFimage.jpg',
      ));

      request.files.add(http.MultipartFile(
        'panBimage',
        imageFile5.readAsBytes().asStream(),
        imageFile5.lengthSync(),
        filename: 'panBimage.jpg',
      ));

      request.files.add(http.MultipartFile(
        'licenseFimage',
        imageFile6.readAsBytes().asStream(),
        imageFile6.lengthSync(),
        filename: 'licenseFimage.jpg',
      ));

      request.files.add(http.MultipartFile(
        'licenseBimage',
        imageFile7.readAsBytes().asStream(),
        imageFile7.lengthSync(),
        filename: 'licenseBimage.jpg',
      ));

      var response = await request.send();

      if (response.statusCode == 200) {
        // Handle a successful response here
        var responseBody = await response.stream.bytesToString();
        print("Success: $responseBody");
        Navigator.push(context, MaterialPageRoute(builder: (_) => wait()));
      } else {
        // Handle errors or other status codes here
        print("Error: ${response.statusCode}");
        print("Response: ${await response.stream.bytesToString()}");
      }
    } catch (e) {
      print("Error: $e");
      // Handle network-related errors here
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
                    const SizedBox(
                      height: 30,
                    ),
                    const SizedBox(
                      height: 7.8,
                    ),
                    const Text(
                      "Enter Bank Details",
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
                      "Enter your Banking Details to proceed further to next Step.",
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
                                    controller: BAnum,
                                    onChanged: (value) {
                                      ConfirmBankAccountNumber = value;
                                    },
                                    decoration: InputDecoration(
                                        hintText: "Enter Account Number",
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
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextField(
                                  controller: BAifsc,
                                  onChanged: (value) {
                                    ConfirmIfscCode = value;
                                  },
                                  decoration: InputDecoration(
                                      hintText: "Enter IFSC Code",
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
                                child: DropdownButtonExample()),
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
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  TextField(
                                    controller: BAbranch,
                                    onChanged: (value) {
                                      ConfirmBranch = value;
                                    },
                                    decoration: InputDecoration(
                                        hintText: "Enter Branch",
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
                        )),
                  ],
                ),
              ),
            ),
            Container(
              height: mq.height * 0.25,
              child: TextButton(
                onPressed: () {
                  print(ConfirmBankAccountNumber);
                  print(ConfirmIfscCode);
                  print(ConfirmBankName);
                  print(ConfirmBranch);
                  if (ConfirmBankAccountNumber == "" ||
                      ConfirmIfscCode == "" ||
                      ConfirmBankName == "" ||
                      ConfirmBranch == "") {
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
                    postData();
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => const LoadingPage()));
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

/// Flutter code sample for [DropdownButton].

const List<String> list = <String>[
  'Select Bank',
  'State Bank of India',
  'ICICI Bank',
  'Bank of Baroda',
  'Punjab National Bank',
  'Canara Bank',
  'PNB',
  'Bank Of India',
  'UCO Bank',
  'Axis Bank Ltd',
  'HDFC Bank Ltd',
  'Indian Bank',
  'Union Bank of India',
  'Union Bank',
  'Central Bank of India',
  'Reserve Bank of India',
  'Indian Overseas Bank',
  'Axis Bank',
  'Bank of Maharashtra',
  'Kotak Mahindra Bank Ltd',
  'HDFC Bank',
  'Yes Bank Ltd',
  'IndusInd Bank',
  'IndusInd Bank Ltd',
  'IDBI Bank Ltd'
];

class DropdownButtonExample extends StatefulWidget {
  const DropdownButtonExample({Key? key});

  @override
  State<DropdownButtonExample> createState() => _DropdownButtonExampleState();
}

class _DropdownButtonExampleState extends State<DropdownButtonExample> {
  String dropdownValue = list.first;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: dropdownValue,
      elevation: 16,
      underline: Container(
        height: 2,
        color: Colors.white,
      ),
      icon: const Icon(
        Icons.arrow_drop_down,
        color: Colors.white,
      ),
      style: const TextStyle(
          fontSize: 17, fontWeight: FontWeight.w500, color: Colors.grey),
      onChanged: (String? value) {
        if (value != null) {
          // Check for null before accessing value
          setState(() {
            dropdownValue = value;
            ConfirmBankName = value;
          });
        }
      },
      hint: Text("Select Bank"),
      borderRadius: BorderRadius.circular(20),
      menuMaxHeight: 200,
      items: list.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
