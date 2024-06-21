import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:driver/dashboard/history.dart';
import 'package:driver/dashboard/notification.dart';
import 'package:driver/dashboard/profile.dart';
import 'package:driver/dashboard/test.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

final introdata = GetStorage();
int value1 = 0;
int value2 = 0;

class Alogin extends StatefulWidget {
  const Alogin({super.key});

  @override
  State<Alogin> createState() => _AloginState();
}

class _AloginState extends State<Alogin> {
  NotoficationsServices notoficationsServices = NotoficationsServices();
  final AfterLogin = GetStorage();
  int screenn = 0;
  void initState() {
    introdata.write("loggedIN", true);
    notoficationsServices.initialiseNotification();
    Timer.periodic(Duration(seconds: 3), (Timer timer) {
      fetchDataFromAPI1();
    });
  }

  Future<void> fetchDataFromAPI1() async {
    try {
      final response = await http.get(Uri.parse(
          'https://chopchoplogistic.com/orderCounter/api/order-counter'));

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final int orderCount = jsonData['count'] as int;
        print(orderCount);
        value1 = orderCount;
        fetchDataFromAPI2();
      } else {
        print('Request failed with status: ${response.statusCode}');
        // Return a default value or throw an exception as needed
        // or throw Exception('Failed to fetch data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching data: $e');
      // Return a default value or throw an exception as needed
      // or throw Exception('Failed to fetch data: $e');
    }
  }

  Future<void> fetchDataFromAPI2() async {
    try {
      final response = await http.get(Uri.parse(
          'https://chopchoplogistic.com/orderCounter/api/total-entries'));

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final int orderCount = jsonData['total_entries'] as int;
        print(orderCount);
        value2 = orderCount;
        if (value1 < value2) {
          print('noti');
          // print(data1[0]['UID']);
          fetchDataFromAPI3();
        }
      } else {
        print('Request failed with status: ${response.statusCode}');
        // Return a default value or throw an exception as needed
        // or throw Exception('Failed to fetch data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  Future<void> fetchDataFromAPI3() async {
    try {
      final response = await http.get(Uri.parse(
          'https://chopchoplogistic.com/orderIncre/api/chop/$value2'));

      if (response.statusCode == 200) {
        print(response.body);
        notoficationsServices.sendNotification();
      } else {
        print('Request failed with status1: ${response.statusCode}');
        // Return a default value or throw an exception as needed
        // or throw Exception('Failed to fetch data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching data: $e');
      // Return a default value or throw an exception as needed
      // or throw Exception('Failed to fetch data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    AfterLogin.write("displayed", true);
    introdata.write("loggedIN", true);
    return Scaffold(
      body: PageView(
        children: [
          if (screenn == 0) test(),
          if (screenn == 1) history(),
          if (screenn == 2) profile()
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.dashboard_outlined),
              label: 'Dashboard',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.history),
              label: 'History',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_rounded),
              label: 'Profile',
            ),
          ],
          currentIndex: screenn,
          selectedItemColor: const Color.fromARGB(255, 0, 128, 0),
          onTap: (index) {
            switch (index) {
              case 0:
                setState(() {
                  screenn = 0;
                });
              case 1:
                setState(() {
                  screenn = 1;
                });
              case 2:
                setState(() {
                  screenn = 2;
                });
            }
          }),
    );
  }
}
