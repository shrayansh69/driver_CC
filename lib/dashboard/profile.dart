import 'dart:convert';

import 'package:driver/auth/login_screen.dart';
import 'package:driver/dashboard/afterlogin.dart';
import 'package:driver/dashboard/help.dart';
import 'package:driver/dashboard/history.dart';
import 'package:driver/dashboard/test.dart';
import 'package:driver/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

final introdata = GetStorage();
String UU = introdata.read('UID');
String wallet = "";

class profile extends StatefulWidget {
  const profile({super.key});

  @override
  State<profile> createState() => _profileState();
}

List<Map<String, dynamic>> data1 = [];

// ignore: camel_case_types
class _profileState extends State<profile> {
  Future<void> fetchDataFromAPI() async {
    final response = await http.get(Uri.parse(
        'https://chopchoplogistic.com/DeliveryPdetails/api/list/$UU'));

    if (response.statusCode == 200) {
      // If the server returns a 200 OK response, parse the JSON data.
      final jsonData = json.decode(response.body);

      if (jsonData is List) {
        if (mounted) {
          setState(() {
            // Assuming you have a List<Map<String, dynamic>> named 'data' in your state.
            data1 = List<Map<String, dynamic>>.from(jsonData);
          });
        }
        print(data1);
      }
    } else {
      // If the server did not return a 200 OK response, throw an exception.
      throw Exception('Failed to load data');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchDataFromAPI();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Handle the back button press here
        // Navigate back to the login screen
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => const Alogin()));

        // Return false to prevent the back button from popping the route
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 2,
          backgroundColor: Colors.white,
          leading: IconButton(
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => const Alogin()));
              },
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.black,
              )),
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(25.0),
                child: Container(
                  height: mq.height * 0.12,
                  width: mq.width * 1,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                            color: Color.fromARGB(255, 212, 212, 212),
                            spreadRadius: 1,
                            blurRadius: 10)
                      ]),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: mq.width * 0.2,
                              child: ProfilePicture(
                                name: data1.isNotEmpty
                                    ? data1[0]['Name'] ?? 'N/A'
                                    : 'Loading...',
                                radius: 31,
                                fontsize: 21,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: mq.width * 0.6,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                data1.isNotEmpty
                                    ? data1[0]['Name'] ?? 'N/A'
                                    : 'Loading...',
                                style: const TextStyle(
                                  fontFamily: "Inter",
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xff000000),
                                  height: 22 / 18,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              Text(
                                data1.isNotEmpty
                                    ? "User ID : ${data1[0]['UID'].substring(0, 10)}" ??
                                        'N/A'
                                    : 'Loading...',
                                style: const TextStyle(
                                  fontFamily: "Inter",
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xff006210),
                                  height: 12 / 10,
                                ),
                                textAlign: TextAlign.center,
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Personal Details",
                        style: TextStyle(
                          fontFamily: "Inter",
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Color(0xff000000),
                          height: 22 / 18,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: mq.height * 0.17,
                        width: mq.width * 1,
                        decoration: const BoxDecoration(
                            color: Color.fromARGB(255, 240, 240, 240),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Full Name",
                                  style: TextStyle(
                                    fontFamily: "Inter",
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xff636363),
                                    height: 22 / 18,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                Text(
                                  data1.isNotEmpty
                                      ? data1[0]['Name'] ?? 'N/A'
                                      : 'Loading...',
                                  style: const TextStyle(
                                    fontFamily: "Inter",
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xff000000),
                                    height: 22 / 18,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                const Text(
                                  "Contact No.",
                                  style: TextStyle(
                                    fontFamily: "Inter",
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xff636363),
                                    height: 22 / 18,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                Text(
                                  data1.isNotEmpty
                                      ? data1[0]['phone'] ?? 'N/A'
                                      : 'Loading...',
                                  style: const TextStyle(
                                    fontFamily: "Inter",
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xff000000),
                                    height: 22 / 18,
                                  ),
                                  textAlign: TextAlign.center,
                                )
                              ]),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        "Aadhar Details",
                        style: TextStyle(
                          fontFamily: "Inter",
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Color(0xff000000),
                          height: 22 / 18,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: mq.height * 0.1,
                        width: mq.width * 1,
                        decoration: const BoxDecoration(
                            color: Color.fromARGB(255, 240, 240, 240),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Adhaar Number",
                                  style: TextStyle(
                                    fontFamily: "Inter",
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xff636363),
                                    height: 22 / 18,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                Text(
                                  data1.isNotEmpty
                                      ? data1[0]['aadharNum'] ?? 'N/A'
                                      : 'Loading...',
                                  style: const TextStyle(
                                    fontFamily: "Inter",
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xff000000),
                                    height: 22 / 18,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ]),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        "Pan Details",
                        style: TextStyle(
                          fontFamily: "Inter",
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Color(0xff000000),
                          height: 22 / 18,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: mq.height * 0.1,
                        width: mq.width * 1,
                        decoration: const BoxDecoration(
                            color: Color.fromARGB(255, 240, 240, 240),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Pan Number",
                                  style: TextStyle(
                                    fontFamily: "Inter",
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xff636363),
                                    height: 22 / 18,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                Text(
                                  data1.isNotEmpty
                                      ? data1[0]['panNum'] ?? 'N/A'
                                      : 'Loading...',
                                  style: const TextStyle(
                                    fontFamily: "Inter",
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xff000000),
                                    height: 22 / 18,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ]),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        "Vehicle Details",
                        style: TextStyle(
                          fontFamily: "Inter",
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Color(0xff000000),
                          height: 22 / 18,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: mq.height * 0.2,
                        width: mq.width * 1,
                        decoration: const BoxDecoration(
                            color: Color.fromARGB(255, 240, 240, 240),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Vehicle Number",
                                  style: TextStyle(
                                    fontFamily: "Inter",
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xff636363),
                                    height: 22 / 18,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                                Text(
                                  data1.isNotEmpty
                                      ? data1[0]['vehicleNumber'] ?? 'N/A'
                                      : 'Loading...',
                                  style: const TextStyle(
                                    fontFamily: "Inter",
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xff000000),
                                    height: 22 / 18,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                const Text(
                                  "Driving License Number",
                                  style: TextStyle(
                                    fontFamily: "Inter",
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xff636363),
                                    height: 22 / 18,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                                Text(
                                  data1.isNotEmpty
                                      ? data1[0]['lisenceNum'] ?? 'N/A'
                                      : 'Loading...',
                                  style: const TextStyle(
                                    fontFamily: "Inter",
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xff000000),
                                    height: 22 / 18,
                                  ),
                                  textAlign: TextAlign.center,
                                )
                              ]),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(builder: (_) => Help()));
                        },
                        child: Container(
                          height: mq.height * 0.06,
                          width: mq.width * 1,
                          decoration: BoxDecoration(
                              // color: Color.fromARGB(255, 240, 240, 240),
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: Color.fromARGB(255, 45, 160,
                                    255), // Specify the border color here
                                width: 2.0,
                              )),
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Center(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "HELP",
                                    style: TextStyle(
                                      fontFamily: "Inter",
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      color: Color.fromARGB(255, 45, 160, 255),
                                      height: 22 / 18,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      GestureDetector(
                        onTap: () {
                          introdata.write("loggedIN", false);
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(builder: (_) => loginScreen()));
                        },
                        child: Container(
                          height: mq.height * 0.06,
                          width: mq.width * 1,
                          decoration: BoxDecoration(
                              // color: Color.fromARGB(255, 240, 240, 240),
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: const Color.fromARGB(255, 185, 05,
                                    05), // Specify the border color here
                                width: 2.0,
                              )),
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Center(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Logout",
                                    style: TextStyle(
                                      fontFamily: "Inter",
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      color: Color.fromARGB(255, 185, 05, 05),
                                      height: 22 / 18,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  Icon(
                                    Icons.logout,
                                    color: Color.fromARGB(255, 185, 05, 05),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
