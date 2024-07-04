import 'dart:async';

import 'package:driver/auth/loader.dart';
import 'package:driver/dashboard/acceptOrder.dart';
import 'package:driver/dashboard/afterlogin.dart';
import 'package:driver/dashboard/map.dart';
import 'package:driver/dashboard/test.dart';
import 'package:driver/dashboard/var.dart';
import 'package:driver/main.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

bool acptOrdr = false;
String? distance;
List Orders = [];
List<Map<String, dynamic>> data = [];
List<Map<String, dynamic>> data2 = [];
String time = "";
String order_ID = "";
String S_UID = "";
String D_UID = "";
String S_name = "";
String R_name = "";
String D_name = "";
String S_phone = "";
String R_phone = "";
String D_phone = "";
String R_address = "";
String S_address = "";
String S_Latitude = "";
String S_Longitude = "";
String weight = "";
String category = "";
String payment_mode = "";
String Total_price = "";
String Drivers_earning = "";
String oid = "";

class OrdersList extends StatefulWidget {
  @override
  _OrdersListState createState() => _OrdersListState();
}

class _OrdersListState extends State<OrdersList> {
  late Timer _timer;
  @override
  void initState() {
    super.initState();
    data = [];
    fetchDataFromAPI();
    fetchDataFromAPI2();
    _timer = Timer.periodic(Duration(seconds: 2), (Timer timer) {
      fetchDataFromAPI();
    });
  }

  Future<void> fetchDataFromAPI() async {
    final response = await http
        .get(Uri.parse('https://chopchoplogistic.com/PendingList/api/list'));

    if (response.statusCode == 200) {
      // If the server returns a 200 OK response, parse the JSON data.
      final jsonData = json.decode(response.body);
      if (jsonData is List) {
        if (mounted) {
          setState(() {
            data = List<Map<String, dynamic>>.from(jsonData);
          });
        }
      }
    } else {
      // If the server did not return a 200 OK response, throw an exception.
      throw Exception('Failed to load data');
    }
  }

  Future<void> fetchDataFromAPI2() async {
    final response = await http.get(Uri.parse(
        'https://chopchoplogistic.com/DeliveryPdetails/api/list/$UU'));

    if (response.statusCode == 200) {
      // If the server returns a 200 OK response, parse the JSON data.
      final jsonData = json.decode(response.body);

      if (jsonData is List) {
        if (mounted) {
          setState(() {
            // Assuming you have a List<Map<String, dynamic>> named 'data' in your state.
            data2 = List<Map<String, dynamic>>.from(jsonData);
          });
        }
        print(data2);
      }
    } else {
      // If the server did not return a 200 OK response, throw an exception.
      throw Exception('Failed to load data');
    }
  }

  @override
  void dispose() {
    // Cancel the timer in the dispose method
    _timer?.cancel();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Container(
      height: mq.height * 0.48,
      child: ListView.builder(
        itemCount: data.length,
        itemBuilder: (BuildContext context, int index) {
          final item = data[index];

          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () async {
                    bool isLoading = true;
                    //   _showAlertDialog(context);
                    Sadd = "${item['P_area']}";
                    Dadd = "${item['D_area']}";
                    // final response = await http.get(Uri.parse(
                    //     'https://chopchoplogistic.com/distance-api/api/distance?address1=$Sadd&address2=$Dadd'));
                    // if (response.statusCode == 200) {
                    //   final data = json.decode(response.body);
                    if (mounted) {
                      setState(() {
                        distance = item['distance'];
                        isLoading = false;
                      });
                      // }
                    }
                    isLoading
                        ? Center(child: CircularProgressIndicator())
                        // ignore: use_build_context_synchronously
                        : showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return Padding(
                                padding: EdgeInsets.all(8.0),
                                child: SizedBox(
                                    height: 400,
                                    child: Container(
                                      height: mq.height * 0.4,
                                      decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.grey),
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(10))),
                                      child: Row(children: [
                                        SizedBox(
                                          width: mq.width * 0.9,
                                          child: Padding(
                                            padding: EdgeInsets.only(left: 10),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  "Order Id : ${item['id']}${item['UID'].toString().substring(0, 5)}",
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
                                                  "${item['category']}",
                                                  style: TextStyle(
                                                    fontFamily: "Inter",
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w400,
                                                    color: Color(0xff1e2a52),
                                                    height: 15 / 12,
                                                  ),
                                                  textAlign: TextAlign.left,
                                                ),
                                                const SizedBox(
                                                  width: double.infinity,
                                                  child: Divider(
                                                    color: Colors.grey,
                                                    thickness: 1,
                                                  ),
                                                ),
                                                Text(
                                                  "${item['timestamp']}",
                                                  style: TextStyle(
                                                    fontFamily: "Inter",
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.w400,
                                                    color: Color(0xff1e2a52),
                                                    height: 15 / 12,
                                                  ),
                                                  textAlign: TextAlign.left,
                                                ),
                                                // ignore: prefer_const_constructors
                                                SizedBox(
                                                  height: 20,
                                                ),
                                                Container(
                                                  height: 50,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                      color: Colors.white,
                                                      boxShadow: const [
                                                        BoxShadow(
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    212,
                                                                    212,
                                                                    212),
                                                            spreadRadius: 1,
                                                            blurRadius: 10)
                                                      ]),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: [
                                                      Container(
                                                        width: mq.width * 0.2,
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Text(
                                                              distance ?? '',
                                                              style: TextStyle(
                                                                fontFamily:
                                                                    "Inter",
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                color: Color(
                                                                    0xff1e2a52),
                                                                height: 19 / 16,
                                                              ),
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                            ),
                                                            Text(
                                                              "Total Distance",
                                                              style: TextStyle(
                                                                fontFamily:
                                                                    "Inter",
                                                                fontSize: 10,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                color: Color(
                                                                    0xff1e2a52),
                                                                height: 17 / 14,
                                                              ),
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                      Container(
                                                        width: 1,
                                                        height: 30,
                                                        color: const Color
                                                            .fromARGB(
                                                            255, 207, 207, 207),
                                                      ),
                                                      Container(
                                                        width: mq.width * 0.2,
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Text(
                                                              "${item['Drivers_earning']}",
                                                              style: TextStyle(
                                                                fontFamily:
                                                                    "Inter",
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                color: Color(
                                                                    0xff1e2a52),
                                                                height: 19 / 16,
                                                              ),
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                            ),
                                                            Text(
                                                              "Earning",
                                                              style: TextStyle(
                                                                fontFamily:
                                                                    "Inter",
                                                                fontSize: 10,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                color: Color(
                                                                    0xff1e2a52),
                                                                height: 17 / 14,
                                                              ),
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 20,
                                                ),
                                                Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      const Text(
                                                        "Shop/Pickup Location",
                                                        style: TextStyle(
                                                          fontFamily: "Inter",
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color:
                                                              Color(0xff1e2a52),
                                                          height: 19 / 16,
                                                        ),
                                                        textAlign:
                                                            TextAlign.left,
                                                      ),
                                                      Text(
                                                        "${item['P_flat']}, ${item['P_area']}",
                                                        style: TextStyle(
                                                          fontFamily: "Inter",
                                                          fontSize: 10,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          color:
                                                              Color(0xff1e2a52),
                                                          height: 12 / 10,
                                                        ),
                                                        textAlign:
                                                            TextAlign.left,
                                                      ),
                                                      SizedBox(
                                                        height: 20,
                                                      ),
                                                      Text(
                                                        "Drop Location",
                                                        style: TextStyle(
                                                          fontFamily: "Inter",
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color:
                                                              Color(0xff1e2a52),
                                                          height: 19 / 16,
                                                        ),
                                                        textAlign:
                                                            TextAlign.left,
                                                      ),
                                                      Text(
                                                        "${item['D_flat']}, ${item['D_area']}",
                                                        style: TextStyle(
                                                          fontFamily: "Inter",
                                                          fontSize: 10,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          color:
                                                              Color(0xff1e2a52),
                                                          height: 12 / 10,
                                                        ),
                                                        textAlign:
                                                            TextAlign.left,
                                                      ),
                                                      SizedBox(
                                                        height: 20,
                                                      ),
                                                      Text(
                                                        "Weight",
                                                        style: TextStyle(
                                                          fontFamily: "Inter",
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color:
                                                              Color(0xff1e2a52),
                                                          height: 19 / 16,
                                                        ),
                                                        textAlign:
                                                            TextAlign.left,
                                                      ),
                                                      Text(
                                                        "${item['weight']}",
                                                        style: TextStyle(
                                                          fontFamily: "Inter",
                                                          fontSize: 10,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          color:
                                                              Color(0xff1e2a52),
                                                          height: 12 / 10,
                                                        ),
                                                        textAlign:
                                                            TextAlign.left,
                                                      )
                                                    ]),
                                                SizedBox(
                                                  height: 20,
                                                ),
                                                Container(
                                                  height: 50,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: [
                                                      Container(
                                                        width: mq.width * 0.4,
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Container(
                                                              height: 50,
                                                              child: Row(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  SizedBox(
                                                                    width:
                                                                        mq.width *
                                                                            0.4,
                                                                    child:
                                                                        TextButton(
                                                                      onPressed:
                                                                          () {
                                                                        Navigator.push(
                                                                            context,
                                                                            MaterialPageRoute(builder: (_) => Alogin()));
                                                                      },
                                                                      child:
                                                                          Container(
                                                                        height:
                                                                            40,
                                                                        width:
                                                                            150,
                                                                        decoration: BoxDecoration(
                                                                            borderRadius:
                                                                                BorderRadius.circular(5),
                                                                            border: Border.all(color: Color.fromARGB(255, 185, 05, 05))),
                                                                        child:
                                                                            const Column(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.center,
                                                                          children: [
                                                                            Text(
                                                                              "Reject",
                                                                              style: TextStyle(fontSize: 10, color: Color.fromARGB(255, 185, 05, 05)),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Container(
                                                        width: 1,
                                                        height: 30,
                                                        color: const Color
                                                            .fromARGB(
                                                            255, 207, 207, 207),
                                                      ),
                                                      Container(
                                                        width: mq.width * 0.4,
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Container(
                                                              height: 50,
                                                              child: Row(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  SizedBox(
                                                                    width:
                                                                        mq.width *
                                                                            0.4,
                                                                    child:
                                                                        TextButton(
                                                                      onPressed:
                                                                          () async {
                                                                        String
                                                                            link =
                                                                            item['id'].toString();
                                                                        print(
                                                                            link);
                                                                        final response1 =
                                                                            await http.get(Uri.parse('https://chopchoplogistic.com/acceptedOrder/api/list/$link'));
                                                                        if (response1.statusCode ==
                                                                            200) {
                                                                          final data1 =
                                                                              json.decode(response1.body);
                                                                          if (mounted) {
                                                                            setState(() {
                                                                              acptOrdr = data1; // Assuming the API response is a boolean
                                                                            });
                                                                          }
                                                                        }
                                                                        print(
                                                                            acptOrdr);
                                                                        Navigator.push(
                                                                            context,
                                                                            MaterialPageRoute(builder: (_) => LoadingPage()));
                                                                        const String
                                                                            apiUrl =
                                                                            'https://chopchoplogistic.com/acceptedOrder/api/send';
                                                                        order_ID =
                                                                            "${item['id']}${item['UID']}";
                                                                        S_UID =
                                                                            "${item['UID']}";
                                                                        D_UID =
                                                                            UU;
                                                                        S_name =
                                                                            "${item['P_name']}";
                                                                        R_name =
                                                                            "${item['D_name']}";
                                                                        D_name =
                                                                            data2[0]['Name'];
                                                                        S_phone =
                                                                            "${item['P_phone']}";
                                                                        R_phone =
                                                                            "${item['D_phone']}";
                                                                        D_phone =
                                                                            data2[0]['phone'];
                                                                        R_address =
                                                                            "${item['D_flat']}, ${item['D_area']}";
                                                                        S_address =
                                                                            "${item['P_flat']}, ${item['P_area']}";
                                                                        S_Latitude =
                                                                            "${item['P_latitude']}";
                                                                        S_Longitude =
                                                                            "${item['P_longitude']}";
                                                                        weight =
                                                                            "${item['weight']}";
                                                                        category =
                                                                            "${item['category']}";
                                                                        payment_mode =
                                                                            "${item['payment']}";
                                                                        Total_price =
                                                                            "${item['Total_fare']}";
                                                                        Drivers_earning =
                                                                            "${item['Drivers_earning']}";

                                                                        Map<String,
                                                                                String>
                                                                            jsonFields =
                                                                            {
                                                                          "order_ID":
                                                                              order_ID,
                                                                          "S_UID":
                                                                              S_UID,
                                                                          "D_UID":
                                                                              D_UID,
                                                                          "S_name":
                                                                              S_name,
                                                                          "R_name":
                                                                              R_name,
                                                                          "D_name":
                                                                              D_name,
                                                                          "S_phone":
                                                                              S_phone,
                                                                          "R_phone":
                                                                              R_phone,
                                                                          "D_phone":
                                                                              D_phone,
                                                                          "R_address":
                                                                              R_address,
                                                                          "S_address":
                                                                              S_address,
                                                                          "S_Latitude":
                                                                              S_Latitude,
                                                                          "S_Longitude":
                                                                              S_Longitude,
                                                                          "weight":
                                                                              weight,
                                                                          "category":
                                                                              category,
                                                                          "payment_mode":
                                                                              payment_mode,
                                                                          "Total_price":
                                                                              Total_price,
                                                                          "Drivers_earning":
                                                                              Drivers_earning,
                                                                        };
                                                                        try {
                                                                          var request = http.MultipartRequest(
                                                                              'POST',
                                                                              Uri.parse(apiUrl));

                                                                          // Add JSON fields
                                                                          request
                                                                              .fields
                                                                              .addAll(jsonFields);
                                                                          var response =
                                                                              await request.send();

                                                                          if (response.statusCode ==
                                                                              200) {
                                                                            // Handle a successful response here
                                                                            var responseBody =
                                                                                await response.stream.bytesToString();
                                                                            print("Success: $responseBody");
                                                                            if (acptOrdr ==
                                                                                true) {
                                                                              Navigator.push(context, MaterialPageRoute(builder: (_) => success()));
                                                                            }
                                                                            // Navigator.push(context, MaterialPageRoute(builder: (_) => wait()));
                                                                          } else {
                                                                            // Handle errors or other status codes here
                                                                            print("Error: ${response.statusCode}");
                                                                            print("Response: ${await response.stream.bytesToString()}");
                                                                          }
                                                                        } catch (e) {
                                                                          print(
                                                                              "Error: $e");
                                                                          // Handle network-related errors here
                                                                        }
                                                                      },
                                                                      child:
                                                                          Container(
                                                                        height:
                                                                            40,
                                                                        width:
                                                                            150,
                                                                        decoration: BoxDecoration(
                                                                            borderRadius:
                                                                                BorderRadius.circular(5),
                                                                            border: Border.all(color: Color.fromARGB(255, 0, 128, 0))),
                                                                        child:
                                                                            const Column(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.center,
                                                                          children: [
                                                                            Text(
                                                                              "Accept",
                                                                              style: TextStyle(fontSize: 10, color: Color.fromARGB(255, 0, 128, 0)),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ]),
                                    )),
                              );
                            });
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Container(
                      height: 65,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10))),
                      child: Row(children: [
                        SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          width: mq.width * 0.5,
                          child: Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Order Id :",
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
                                      "${item['id']}${item['UID'].toString().substring(0, 5)}",
                                      style: TextStyle(
                                        fontFamily: "Inter",
                                        fontSize: 10,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.grey,
                                        height: 19 / 16,
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
                                  ],
                                ),
                                Text(
                                  "${item['category']}",
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
                ),
                SizedBox(
                  height: 20,
                )
              ],
            ),
          );
        },
      ),
    );
  }
}

class OrderDetail extends StatelessWidget {
  const OrderDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: mq.height * 0.4,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: const BorderRadius.all(Radius.circular(10))),
      child: Row(children: [
        SizedBox(
          width: mq.width * 0.9,
          child: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
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
                const Text(
                  "Fresh Fruits Delivery",
                  style: TextStyle(
                    fontFamily: "Inter",
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff1e2a52),
                    height: 15 / 12,
                  ),
                  textAlign: TextAlign.left,
                ),
                const SizedBox(
                  width: double.infinity,
                  child: Divider(
                    color: Colors.grey,
                    thickness: 1,
                  ),
                ),
                const Text(
                  "10:00 AM, 12 December 2023",
                  style: TextStyle(
                    fontFamily: "Inter",
                    fontSize: 10,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff1e2a52),
                    height: 15 / 12,
                  ),
                  textAlign: TextAlign.left,
                ),
                // ignore: prefer_const_constructors
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                            color: Color.fromARGB(255, 212, 212, 212),
                            spreadRadius: 1,
                            blurRadius: 10)
                      ]),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: mq.width * 0.2,
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "10 km",
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
                              "Total Distance",
                              style: TextStyle(
                                fontFamily: "Inter",
                                fontSize: 10,
                                fontWeight: FontWeight.w500,
                                color: Color(0xff1e2a52),
                                height: 17 / 14,
                              ),
                              textAlign: TextAlign.left,
                            )
                          ],
                        ),
                      ),
                      Container(
                        width: 1,
                        height: 30,
                        color: const Color.fromARGB(255, 207, 207, 207),
                      ),
                      Container(
                        width: mq.width * 0.2,
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "23 mins",
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
                              "Estimated Time",
                              style: TextStyle(
                                fontFamily: "Inter",
                                fontSize: 10,
                                fontWeight: FontWeight.w500,
                                color: Color(0xff1e2a52),
                                height: 17 / 14,
                              ),
                              textAlign: TextAlign.left,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Shop/Pickup Location",
                        style: TextStyle(
                          fontFamily: "Inter",
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Color(0xff1e2a52),
                          height: 19 / 16,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      Text(
                        "49736 Herman Cape, Collierview, MS 05826-8876",
                        style: TextStyle(
                          fontFamily: "Inter",
                          fontSize: 10,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff1e2a52),
                          height: 12 / 10,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Drop Location",
                        style: TextStyle(
                          fontFamily: "Inter",
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Color(0xff1e2a52),
                          height: 19 / 16,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      Text(
                        "Suite 557 54919 Lou Dam, Boyerside, IN 42927",
                        style: TextStyle(
                          fontFamily: "Inter",
                          fontSize: 10,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff1e2a52),
                          height: 12 / 10,
                        ),
                        textAlign: TextAlign.left,
                      )
                    ]),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: mq.width * 0.4,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 50,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: mq.width * 0.4,
                                    child: TextButton(
                                      onPressed: () {
                                        // Navigator.push(
                                        //     context,
                                        //     MaterialPageRoute(
                                        //         builder: (_) => vehicle3()));
                                      },
                                      child: Container(
                                        height: 40,
                                        width: 150,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            border: Border.all(
                                                color: Color.fromARGB(
                                                    255, 185, 05, 05))),
                                        child: const Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "Reject",
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  color: Color.fromARGB(
                                                      255, 185, 05, 05)),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 1,
                        height: 30,
                        color: const Color.fromARGB(255, 207, 207, 207),
                      ),
                      Container(
                        width: mq.width * 0.4,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 50,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: mq.width * 0.4,
                                    child: TextButton(
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (_) => accept1()));
                                      },
                                      child: Container(
                                        height: 40,
                                        width: 150,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            border: Border.all(
                                                color: Color.fromARGB(
                                                    255, 0, 128, 0))),
                                        child: const Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "Accept",
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  color: Color.fromARGB(
                                                      255, 0, 128, 0)),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
