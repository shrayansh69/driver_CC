// ignore: unused_import
import 'package:driver/auth/login_screen.dart';
import 'package:driver/dashboard/afterlogin.dart';
import 'package:flutter/material.dart';

import '../main.dart';
import '../welcome_screen/welcome_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    // SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    Future.delayed(Duration(seconds: 2), () {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (_) => frame1()));
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
