import 'dart:io';

import 'package:driver/auth/globals.dart';
import 'package:driver/dashboard/ReceiveOTP.dart';
import 'package:driver/dashboard/afterlogin.dart';
import 'package:driver/dashboard/map.dart';
import 'package:driver/main.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

bool islaod = false;

class onlinePayment extends StatefulWidget {
  const onlinePayment({super.key});

  @override
  State<onlinePayment> createState() => _onlinePaymentState();
}

XFile? _image20;
XFile? paymentImage;

class _onlinePaymentState extends State<onlinePayment> {
  final ImagePicker _imagePicker20 = ImagePicker();
  Future<void> _pickImage20() async {
    final XFile? pickedImage20 =
        await _imagePicker20.pickImage(source: ImageSource.camera);

    if (pickedImage20 != null) {
      setState(() {
        _image20 = pickedImage20;
        paymentImage = _image20;
      });
    }
  }

  Future<void> postData2() async {
    String apiUrl =
        'https://chopchoplogistic.com/updateStatus/api/paymentSS/${mapdata[0]['order_ID']}';

    // Load image files
    String imagePath = paymentImage!.path;
    File imageFile20 = File(imagePath);

    try {
      var request = http.MultipartRequest('POST', Uri.parse(apiUrl));

      // Add JSON fields

      // Add image file
      request.files.add(http.MultipartFile(
        'paymentSS',
        imageFile20.readAsBytes().asStream(),
        imageFile20.lengthSync(),
        filename: 'paymentSS.jpg',
      ));

      var response = await request.send();

      if (response.statusCode == 200) {
        // Handle a successful response here
        var responseBody = await response.stream.bytesToString();
        print("Success: $responseBody");
        // Navigator.push(context, MaterialPageRoute(builder: (_) => otp1()));
        Navigator.push(context, MaterialPageRoute(builder: (_) => otp1()));
        setState(() {
          islaod = true;
        });
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
        // Handle the back button press here
        // Navigate back to the login screen
        Navigator.push(context, MaterialPageRoute(builder: (_) => Alogin()));

        // Return false to prevent the back button from popping the route
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (_, __, ___) => accept1(),
                  transitionsBuilder:
                      (_, Animation<double> animation, __, Widget child) {
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
            child: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
          ),
        ),
        body: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: mq.width * 0.92,
                  child: const Divider(
                    color: Color.fromARGB(255, 240, 240, 240),
                    thickness: 2,
                  ),
                ),
              ],
            ),
            Container(
                width: mq.width * 0.6,
                child: Image.asset("assets/images/QRcode.png")),
            SizedBox(
              height: mq.height * 0.02,
            ),
            // Text(
            //   "Order Value : ₹ ${mapdata[0]['Total_price']} ",
            //   style: TextStyle(
            //       fontSize: mq.height * 0.025, fontWeight: FontWeight.w500),
            // ),
            Text(
              "CHOPCHOPLOGISTICSSOLUTIONS",
              style: TextStyle(
                  fontSize: mq.height * 0.02, fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: mq.height * 0.03,
            ),
            SizedBox(
              width: mq.width * 0.92,
              child: const Divider(
                color: Color.fromARGB(255, 240, 240, 240),
                thickness: 2,
              ),
            ),
            SizedBox(
              height: mq.height * 0.03,
            ),
            const Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Text(
                    "Upload Image of the Transaction Details",
                    style: TextStyle(
                      fontFamily: "Inter",
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xff424347),
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: mq.height * 0.01,
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.grey),
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
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
                          if (_image20 != null)
                            Row(
                              children: [
                                Image.file(
                                  File(_image20!.path),
                                  width: 30,
                                  height: 40,
                                ),
                                const SizedBox(
                                  width: 20,
                                )
                              ],
                            ),
                          GestureDetector(
                            onTap: _pickImage20,
                            child: SizedBox(
                              height: 50,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      (_image20 != null)
                                          ? const Text(
                                              "Uploaded",
                                              style: TextStyle(
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.grey),
                                            )
                                          : const Text(
                                              "Upload Front Side",
                                              style: TextStyle(
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.w500,
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
                    (_image20 != null)
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
            ),
            SizedBox(
              height: mq.height * 0.1,
            ),
            SizedBox(
              width: mq.width * 0.92,
              child: const Divider(
                color: Color.fromARGB(255, 240, 240, 240),
                thickness: 2,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30, right: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Summary "),
                  Text("₹ ${mapdata[0]['Total_price']}")
                ],
              ),
            ),
            SizedBox(
              height: mq.height * 0.02,
            ),
            SizedBox(
              width: mq.width * 1,
              child: TextButton(
                onPressed: () async {
                  postData2();
                  // Navigator.push(
                  //     context, MaterialPageRoute(builder: (_) => otp1()));
                },
                child: Container(
                  height: mq.height * 0.060,
                  width: mq.width * 0.86,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7),
                      border: Border.all(
                          color: const Color.fromARGB(255, 0, 128, 0))),
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "SUBMIT",
                        style: TextStyle(
                            fontSize: 18,
                            color: Color.fromARGB(255, 0, 128, 0)),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
