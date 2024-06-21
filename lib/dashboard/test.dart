// ignore_for_file: unused_import

import 'dart:convert';

import 'package:driver/auth/globals.dart';
import 'package:driver/dashboard/map.dart';
import 'package:driver/dashboard/testingYash.dart';
import 'package:driver/main.dart';
import 'package:driver/payment/deposit.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sliding_switch/sliding_switch.dart';

import 'package:driver/dashboard/history.dart';
import 'package:driver/dashboard/profile.dart';
import 'package:driver/dashboard/tes.dart';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

String nmbr = '';
final introdata = GetStorage();
String UU = introdata.read('UID');
bool online = false;

class test extends StatefulWidget {
  const test({super.key});

  @override
  State<test> createState() => _testState();
}

class _testState extends State<test> {
  Future<List<Map<String, dynamic>>?> fetchDataFromAPI() async {
    print("Test  :  $UU");
    final response = await http.get(Uri.parse(
        'https://chopchoplogistic.com/DeliveryPdetails/api/list/$UU'));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);

      if (jsonData is List) {
        return List<Map<String, dynamic>>.from(jsonData);
      }
    }
    return null;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchDataFromAPI();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        shadowColor: Colors.grey,
        bottomOpacity: 1,
        leadingWidth: 120,
        backgroundColor: Colors.white,
        centerTitle: true,
        leading: Padding(
          padding:
              const EdgeInsets.only(top: 13, bottom: 13, left: 10, right: 10),
          child: SlidingSwitch(
            value: online,
            width: 100,
            onChanged: (bool value) {
              online = value;
              print(online);
              if (DriverBalance <= 0 && value == true) {
                value = false;
                setState(() {
                  online = value;
                });
                showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: SizedBox(
                          height: 100,
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Center(
                              child: Text(
                                "Please make sure to clear all your dues to proceed further. ",
                                style: TextStyle(fontSize: 20),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                      );
                    });
                // value = false;
              } else {
                setState(() {
                  online = value;
                });
              }
            },
            height: 30,
            contentSize: 10,
            animationDuration: const Duration(milliseconds: 150),
            onTap: () {
              print(data1);
            },
            onDoubleTap: () {},
            onSwipe: () {},
            textOff: "OFFLINE",
            textOn: "ONLINE",
            colorOff: const Color.fromARGB(255, 185, 05, 05),
            colorOn: const Color.fromARGB(255, 0, 128, 0),
            background: const Color(0xffe4e5eb),
            buttonColor: const Color(0xfff7f5f7),
            inactiveColor: const Color(0xff636f7b),
          ),
        ),
        actions: [const Home()],
        title: SizedBox(
          width: mq.width * 0.4,
          child: Image.asset(
            "assets/images/logo.png",
            width: 80,
          ),
        ),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>?>(
        future: fetchDataFromAPI(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // While waiting for data, display a loading indicator
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError || snapshot.data == null) {
            return Center(
              child: Text('Failed to load data. Please try again.'),
            );
          } else {
            // Data has been fetched, you can use it in your UI
            final data1 = snapshot.data!;
            return buildUI(data1);
          }
        },
      ),
    );
  }

  @override
  Widget buildUI(List<Map<String, dynamic>> data1) {
    DriverBalance = double.parse(data1[0]['wallet']);
    print(DriverBalance);
    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: Container(
              height: mq.height * 0.25,
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
                padding: const EdgeInsets.all(8.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Text(
                            "WELCOME PARTNER",
                            style: TextStyle(
                                fontSize: mq.width * 0.06,
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Text(
                            "Your Total Balance : ",
                            style: TextStyle(
                                fontSize: mq.width * 0.045,
                                fontWeight: FontWeight.w600,
                                color: const Color.fromARGB(255, 92, 92, 92)),
                          ),
                          Text(
                            data1.isNotEmpty
                                ? data1[0]['wallet'] ?? 'N/A'
                                : 'Loading...',
                            style: TextStyle(
                                fontSize: mq.width * 0.045,
                                fontWeight: FontWeight.w600,
                                color: const Color.fromARGB(255, 92, 92, 92)),
                          ),
                        ],
                      ),
                      Text(
                        "*Your payment will be settled by company at every Tuseday & Saturday",
                        style: TextStyle(fontSize: 10, color: Colors.grey),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        width: mq.width * 1,
                        child: TextButton(
                          onPressed: () {
                            nmbr = data1[0]['phone'];
                            print(nmbr);
                            Navigator.push(context,
                                MaterialPageRoute(builder: (_) => deposit()));
                          },
                          child: Container(
                            height: mq.height * 0.05,
                            width: mq.width * 0.86,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(7),
                                border: Border.all(
                                    color: const Color.fromARGB(
                                        255, 185, 05, 05))),
                            child: const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "DEPOSIT",
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Color.fromARGB(255, 185, 05, 05)),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ]),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                width: mq.width * 0.27,
                child: const Divider(
                  color: Colors.grey,
                  thickness: 1,
                ),
              ),
              SizedBox(
                width: mq.width * 0.4,
                child: const Text(
                  "Nearby Orders",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.grey,
                      letterSpacing: 1),
                ),
              ),
              SizedBox(
                width: mq.width * 0.27,
                child: const Divider(
                  color: Colors.grey,
                  thickness: 1,
                ),
              ),
            ],
          ),
          SizedBox(
            height: mq.height * 0.04,
          ),
          online
              ? OrdersList()
              : Padding(
                  padding: const EdgeInsets.only(top: 100),
                  child: SizedBox(
                    width: mq.width * 0.8,
                    child: Image.asset("assets/images/offline.png"),
                  ),
                )
        ]),
      ),
    );
  }
}

class Home extends GetView<Homec> {
  const Home({Key? key});

  @override
  Widget build(BuildContext context) {
    Get.put(Homec());
    return SizedBox(
      width: mq.width * 0.3,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            children: [
              const Icon(
                Icons.location_on_outlined,
                color: Colors.black,
                size: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Obx(
                        () => Text(
                          controller.locality.value,
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 10.5,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                    ],
                  ),
                  Obx(
                    () => Text(
                      controller.address.value,
                      style: const TextStyle(
                          color: Color.fromARGB(255, 48, 48, 48),
                          fontSize: 7.5,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class onl extends StatefulWidget {
  const onl({Key? key}) : super(key: key);

  @override
  State<onl> createState() => _onlState();
}

class _onlState extends State<onl> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: mq.height * 0.4,
      color: Colors.white,
      child: Column(children: [
        GestureDetector(
          onTap: () {
            //   _showAlertDialog(context);
            showModalBottomSheet(
                context: context,
                builder: (context) {
                  return const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: 400,
                      child: OrderDetail(),
                    ),
                  );
                });
          },
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Container(
              height: 65,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: const BorderRadius.all(Radius.circular(10))),
              child: Row(children: [
                SizedBox(
                  width: mq.width * 0.5,
                  child: const Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Order Id : 549SD00X87",
                          style: TextStyle(
                            fontFamily: "Inter",
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Color(0xff1e2a52),
                            height: 19 / 16,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        Text(
                          "Fresh Fruits Delivery",
                          style: TextStyle(
                            fontFamily: "Inter",
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Color(0xff1e2a52),
                            height: 15 / 12,
                          ),
                          textAlign: TextAlign.left,
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  width: mq.width * 0.3,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 22,
                          width: 72,
                          decoration: const BoxDecoration(
                              color: Color.fromARGB(255, 0, 128, 0),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5))),
                          child: const Center(
                              child: Text(
                            "View Details",
                            style: TextStyle(
                              fontFamily: "Inter",
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                              height: 12 / 10,
                            ),
                            textAlign: TextAlign.left,
                          )),
                        ),
                      ),
                    ],
                  ),
                ),
                const Icon(Icons.arrow_drop_down_sharp)
              ]),
            ),
          ),
        )
      ]), // You can change the color or add child widgets here.
    );
  }
}
