// ignore_for_file: prefer_const_constructors

import 'dart:async';
import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:driver/dashboard/ReceiveOTP.dart';
import 'package:driver/dashboard/afterlogin.dart';
import 'package:driver/dashboard/history.dart';
import 'package:driver/dashboard/tes.dart';
import 'package:driver/dashboard/test.dart';
import 'package:driver/main.dart';
import 'package:driver/payment/online.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter_sliding_up_panel/sliding_up_panel_widget.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

final introdata = GetStorage();
String idd = introdata.read('OrderID');
// String idd = ad;
double latitude = 0;
double logitude = 0;
String pp = "";
double latt = 0;
double logg = 0;

String odd = "";
String add = "";

class MapSample extends StatefulWidget {
  const MapSample({super.key});

  @override
  State<MapSample> createState() => MapSampleState();
}

List<Map<String, dynamic>> mapdata = [];
List<Map<String, dynamic>> mapdata2 = [];

class MapSampleState extends State<MapSample> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  static CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(lat, lon),
    zoom: 16.4746,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: mq.height * 1,
        child: GoogleMap(
          mapType: MapType.normal,
          initialCameraPosition: _kGooglePlex,
          polylines: {
            Polyline(
              polylineId: PolylineId('route'),
              points: polyLineCoordinates,
              width: 3,
              color: Color.fromARGB(255, 185, 05, 05),
            ),
          },
          markers: {
            // ignore: prefer_const_constructors
            Marker(
                markerId: MarkerId('Source'),
                position: LatLng(lat, lon),
                infoWindow: InfoWindow(title: "Your Location")),
            Marker(
                markerId: MarkerId('Destination'),
                position: LatLng(latt, logg),
                infoWindow: InfoWindow(title: "Destination Location"))
          },
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
        ),
      ),
    );
  }
}

List<LatLng> polyLineCoordinates = [];

class accept1 extends StatefulWidget {
  accept1({super.key});

  @override
  State<accept1> createState() => _accept1State();
}

class _accept1State extends State<accept1> {
  void openGoogleMaps() async {
    // Replace latitude and longitude with the actual location you want to open.

    String googleMapsUrl =
        'https://www.google.com/maps/search/?api=1&query=$latt, $logg';

    if (await canLaunch(googleMapsUrl)) {
      await launch(googleMapsUrl);
    } else {
      throw 'Could not launch $googleMapsUrl';
    }
  }

  Future<void> getPolyPoints() async {
    polyLineCoordinates = [];
    PolylinePoints polylinePoints = PolylinePoints();
    try {
      PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
          "AIzaSyDnWZjHoz1I8bgvQjBSa4MEpTRE3cnBzPA",
          PointLatLng(lat, lon),
          PointLatLng(latt, logg));
      if (result.points.isNotEmpty) {
        setState(() {
          result.points.forEach((PointLatLng point) {
            polyLineCoordinates.add(LatLng(point.latitude, point.longitude));
          });
        });
      }
    } catch (error) {
      print(error);
    }
  }

  Future<void> fetchDataFromAPI5() async {
    final response = await http.get(Uri.parse(
        'https://chopchoplogistic.com/latlng/api/get-latlng/${mapdata[0]['S_address']}'));

    if (response.statusCode == 200) {
      // If the server returns a 200 OK response, parse the JSON data.
      final Map<String, dynamic> jsonData = json.decode(response.body);
      if (jsonData.containsKey('latitude') &&
          jsonData.containsKey('longitude')) {
        setState(() {
          latt = jsonData['latitude'];
          logg = jsonData['longitude'];
          print('Latitude: $latt');
          print('Longitude: $logg');
        });
        await getPolyPoints();
      }
    } else {
      // If the server did not return a 200 OK response, throw an exception.
      throw Exception('Failed to load data');
    }
  }

  Future<void> fetchDataFromAPI4() async {
    final response = await http.get(Uri.parse(
        'https://chopchoplogistic.com/DriverOrderList/api/list2/$ad'));
    print(ad);
    add = ad;
    if (response.statusCode == 200) {
      // If the server returns a 200 OK response, parse the JSON data.
      final jsonData = json.decode(response.body);
      if (jsonData is List) {
        setState(() {
          mapdata = List<Map<String, dynamic>>.from(jsonData);
          latitude = double.parse(mapdata[0]['S_Latitude']);
          logitude = double.parse(mapdata[0]['S_Longitude']);
        });
        await fetchDataFromAPI5();
      }
    } else {
      // If the server did not return a 200 OK response, throw an exception.
      throw Exception('Failed to load data');
    }
  }

  @override
  void initState() {
    polyLineCoordinates = [];
    fetchDataFromAPI4();
  }

  Widget build(BuildContext context) {
    Numberr = mapdata.isEmpty ? "loading" : mapdata[0]['S_phone'];
    odd = mapdata.isEmpty ? "loading" : mapdata[0]['order_ID'];
    bool showMapSample = polyLineCoordinates.isNotEmpty;
    return WillPopScope(
      onWillPop: () async {
        // Handle the back button press here
        // Navigate back to the login screen
        Navigator.push(context, MaterialPageRoute(builder: (_) => Alogin()));

        // Return false to prevent the back button from popping the route
        return false;
      },
      child: Scaffold(
        body: Stack(
          children: [
            showMapSample
                ? const MapSample()
                : Center(child: CircularProgressIndicator()),
            Positioned(
              top: mq.height * 0.05,
              child: IconButton(
                onPressed: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (_) => Alogin()));
                },
                icon: const Icon(Icons.arrow_back),
              ),
            ),
            Positioned(
                child: SlidingUpPanelWidget(
                    controlHeight: mq.height * 0.3,
                    panelController: SlidingUpPanelController(),
                    child: Container(
                      height: mq.height * 0.2,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                      ),
                      child: Column(children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Container(
                                width: mq.width * 0.2,
                                height: 4,
                                decoration: const BoxDecoration(
                                    color: Color.fromARGB(255, 197, 197, 197),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                child: const Divider(
                                  color: Color.fromARGB(255, 197, 197, 197),
                                  thickness: 2,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 20, right: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.shopping_bag_outlined),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Order ID :",
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
                                        mapdata.isEmpty
                                            ? "Loading"
                                            : "${mapdata[0]['order_ID'].toString().substring(0, 5)}",
                                        style: TextStyle(
                                          fontFamily: "Inter",
                                          fontSize: 8,
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xff1e2a52),
                                          height: 19 / 16,
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                              GestureDetector(
                                onTap: () {
                                  openGoogleMaps();
                                },
                                child: Container(
                                  height: 30,
                                  width: mq.width * 0.3,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.blue),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                  ),
                                  child: Center(
                                      child: Text(
                                    "Show Direction",
                                    style: TextStyle(color: Colors.blue),
                                  )),
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(25.0),
                          child: Container(
                            height: mq.height * 0.32,
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
                              padding: EdgeInsets.all(15.0),
                              child: Column(
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
                                      mapdata.isEmpty
                                          ? "Loading"
                                          : "${mapdata[0]['S_address']}",
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
                                      mapdata.isEmpty
                                          ? "Loading"
                                          : "${mapdata[0]['R_address']}",
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
                                    Row(
                                      children: [
                                        Text(
                                          "Sender's Number :",
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
                                          mapdata.isEmpty
                                              ? "Loading"
                                              : " ${mapdata[0]['S_phone']}",
                                          style: TextStyle(
                                            fontFamily: "Inter",
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                            color: Color(0xff1e2a52),
                                            height: 19 / 16,
                                          ),
                                          textAlign: TextAlign.left,
                                        ),
                                      ],
                                    ),
                                    Container(
                                      height: mq.height * 0.1,
                                      child: TextButton(
                                        onPressed: () async {
                                          pp =
                                              'tel: ${mapdata[0]['S_phone']}'; // Replace with the desired phone number
                                          if (await canLaunch(pp)) {
                                            await launch(pp);
                                          } else {
                                            print('Could not launch $pp');
                                          }
                                        },
                                        child: Container(
                                          height: mq.height * 0.060,
                                          width: mq.width * 0.86,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(7),
                                              border: Border.all(
                                                  color: const Color.fromARGB(
                                                      255, 185, 05, 05))),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              AutoSizeText(
                                                "Call Sender",
                                                minFontSize: 10,
                                                maxFontSize: 18,
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    color: Color.fromARGB(
                                                        255, 185, 05, 05)),
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
                        Padding(
                          padding: const EdgeInsets.only(left: 25, right: 25),
                          child: Container(
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
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        mapdata.isEmpty
                                            ? "Loading"
                                            : "Rs. ${mapdata[0]['Drivers_earning']}",
                                        style: TextStyle(
                                          fontFamily: "Inter",
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xff1e2a52),
                                          height: 19 / 16,
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                                      AutoSizeText(
                                        "Total Earning",
                                        minFontSize: 7,
                                        maxFontSize: 10,
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
                                  color:
                                      const Color.fromARGB(255, 207, 207, 207),
                                ),
                                Container(
                                  width: mq.width * 0.2,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        mapdata.isEmpty
                                            ? "Loading"
                                            : "Rs. ${mapdata[0]['Total_price']}",
                                        style: TextStyle(
                                          fontFamily: "Inter",
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xff1e2a52),
                                          height: 19 / 16,
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                                      AutoSizeText(
                                        "Total Billing Amount",
                                        minFontSize: 7,
                                        maxFontSize: 10,
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
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                            height: mq.height * 0.1,
                            child: TextButton(
                              onPressed: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (_) => otp1()));
                              },
                              child: Container(
                                height: mq.height * 0.060,
                                width: mq.width * 0.86,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(7),
                                    border: Border.all(
                                        color: const Color.fromARGB(
                                            255, 0, 128, 0))),
                                child: const Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Receive Order",
                                      style: TextStyle(
                                          fontSize: 18,
                                          color:
                                              Color.fromARGB(255, 0, 128, 0)),
                                    ),
                                  ],
                                ),
                              ),
                            ))
                      ]),
                    )))
          ],
        ),
      ),
    );
  }
}
