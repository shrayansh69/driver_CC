// ignore_for_file: unused_import

import 'dart:convert';

import 'package:driver/dashboard/afterlogin.dart';
import 'package:driver/dashboard/map.dart';
import 'package:driver/dashboard/map2.dart';
import 'package:driver/dashboard/profile.dart';
import 'package:driver/dashboard/test.dart';
import 'package:driver/main.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

final introdata = GetStorage();
String Numberr = "";
String UUID = introdata.read('UID');
String ad = "";
String n = "";

class history extends StatefulWidget {
  const history({super.key});

  @override
  State<history> createState() => _historyState();
}

List<Map<String, dynamic>> historyData = [];

class _historyState extends State<history> {
  void initState() {
    super.initState();
    fetchDataFromAPI4();
  }

  Future<void> fetchDataFromAPI4() async {
    final response = await http.get(Uri.parse(
        'https://chopchoplogistic.com/DriverOrderList/api/list/$UUID'));

    if (response.statusCode == 200) {
      // If the server returns a 200 OK response, parse the JSON data.
      final jsonData = json.decode(response.body);
      if (jsonData is List) {
        if (mounted) {
          setState(() {
            historyData = List<Map<String, dynamic>>.from(jsonData);
          });
        }
      }
    } else {
      // If the server did not return a 200 OK response, throw an exception.
      throw Exception('Failed to load data');
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
          leading: IconButton(
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => Alogin()));
              },
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.black,
              )),
          backgroundColor: Colors.white,
        ),
        body: ListView.builder(
          itemCount: historyData.length,
          itemBuilder: (BuildContext context, int index) {
            final item = historyData[index];
            if (item['status'] == 'A') {
              introdata.write("OrderID", item['order_ID']);
            }
            return buildListItem(item);
          },
        ),
      ),
    );
  }

  Widget buildListItem(Map<String, dynamic> item) {
    return SingleChildScrollView(
      child: GestureDetector(
        onTap: () {
          DriverP = double.parse(item['Drivers_earning']);
          ad = item['order_ID'];
          n = item['S_phone'];
          (item['status'] == 'A')
              ? {
                  if (item['status1'] == 0)
                    {
                      Navigator.push(
                          context, MaterialPageRoute(builder: (_) => accept1()))
                    }
                  else if (item['status1'] == 1)
                    {
                      Navigator.push(
                          context, MaterialPageRoute(builder: (_) => accept2()))
                    }
                }
              : showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Column(
                        children: [
                          ClipRRect(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(100)),
                              child: Container(
                                  width: mq.width * 0.5,
                                  child:
                                      Image.asset('assets/images/fire2.png'))),
                          Text(
                            "Order has been Successfully Delivered",
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    );
                  },
                );
        },
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: mq.height * 0.1,
                  width: mq.width * 0.96,
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 245, 245, 245),
                      border: Border.all(
                        color: const Color.fromARGB(255, 212, 212, 212),
                        width: 1,
                      ),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10))),
                  child: Row(children: [
                    Container(
                        height: mq.height * 0.1,
                        width: mq.width * 0.03,
                        decoration: BoxDecoration(
                          color: (item['status'] == "A")
                              ? (item['status1'] == 0)
                                  ? Color.fromRGBO(185, 5, 5, 1)
                                  : Color.fromARGB(255, 5, 85, 183)
                              : Color(0xff056300),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              bottomLeft: Radius.circular(10)),
                        )),
                    Container(
                      width: mq.width * 0.6,
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                "Order ID :",
                                style: TextStyle(
                                  fontFamily: "Inter",
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xff000000),
                                  height: 22 / 18,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              Text(
                                item['order_ID'].toString().substring(0, 7),
                                style: TextStyle(
                                  fontFamily: "Inter",
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xff656565),
                                  height: 12 / 10,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              Row(
                                children: [
                                  Text(
                                    item['Timestamp'],
                                    style: TextStyle(
                                      fontFamily: "Inter",
                                      fontSize: 10.5,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xff656565),
                                      height: 13 / 10.5,
                                    ),
                                    textAlign: TextAlign.center,
                                  )
                                ],
                              )
                            ]),
                      ),
                    ),
                    SizedBox(
                      width: mq.width * 0.3,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "₹ ${item['Drivers_earning']}",
                            style: TextStyle(
                              fontFamily: "Inter",
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Color(0xff000000),
                              height: 22 / 18,
                            ),
                            textAlign: TextAlign.left,
                          ),
                          Text(
                            (item['status'] == "A")
                                ? (item['status1'] == 0)
                                    ? "PENDING"
                                    : "DELIVERING"
                                : "SUCCESS",
                            style: TextStyle(
                              fontFamily: "Inter",
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: (item['status'] == "A")
                                  ? (item['status1'] == 0)
                                      ? Color.fromRGBO(185, 5, 5, 1)
                                      : Color.fromARGB(255, 5, 85, 183)
                                  : Color(0xff056300),
                              height: 22 / 18,
                            ),
                            textAlign: TextAlign.center,
                          )
                        ],
                      ),
                    ),
                  ]),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
