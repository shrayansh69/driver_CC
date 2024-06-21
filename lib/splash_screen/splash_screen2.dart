// ignore_for_file: unused_import

import 'package:driver/auth/login_screen.dart';
import 'package:driver/dashboard/afterlogin.dart';
import 'package:driver/dashboard/map.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

import '../main.dart';
import '../welcome_screen/welcome_screen.dart';

final introdata = GetStorage();

class SplashScreen2 extends StatefulWidget {
  const SplashScreen2({super.key});

  @override
  State<SplashScreen2> createState() => _SplashScreen2State();
}

class _SplashScreen2State extends State<SplashScreen2>
    with SingleTickerProviderStateMixin {
  final AfterLogin = GetStorage();

  @override
  void initState() {
    super.initState();
    // SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    AfterLogin.writeIfNull("displayed", false);
    final loggedIN = introdata.read("loggedIN") ?? false;

    Future.delayed(Duration(seconds: 2), () {
      (loggedIN)
          ? Navigator.of(context)
              .pushReplacement(MaterialPageRoute(builder: (_) => Alogin()))
          : Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (_) => loginScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/images/fire.png",
                  width: mq.width * 0.5,
                ),
              ],
            ),
            Text(
              'Chop-Chop',
              style: TextStyle(
                fontSize: mq.height * 0.045,
                fontWeight: FontWeight.w600,
                color: Color.fromARGB(255, 185, 05, 05),
                fontFamily: "BRUSHSCI",
              ),
            ),
            SizedBox(
              height: mq.height * 0.01,
            ),
            Text(
              'Deliver Faster Than You Think',
              style: TextStyle(
                fontSize: mq.height * 0.03,
                fontWeight: FontWeight.w600,
                color: Color.fromARGB(255, 0, 128, 0),
                fontFamily: "BRUSHSCI",
              ),
            ),
          ]),
    );
  }
}
