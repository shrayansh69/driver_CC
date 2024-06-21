import 'package:driver/auth/login_screen.dart';
import 'package:driver/main.dart';
import 'package:driver/welcome_screen/welcome2.dart';

import 'package:flutter/material.dart';

class frame1 extends StatelessWidget {
  const frame1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: mq.height * 0.4,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Image.asset("assets/images/testing.png"),
              ],
            ),
          ),
          SizedBox(
            height: mq.height * 0.4,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Become a',
                    style: TextStyle(
                        fontSize: mq.height * 0.05,
                        fontWeight: FontWeight.w800),
                  ),
                  Text(
                    'Chop-Chop',
                    style: TextStyle(
                      fontSize: mq.height * 0.08,
                      fontWeight: FontWeight.w800,
                      color: const Color.fromARGB(255, 185, 05, 05),
                      fontFamily: "BRUSHSCI",
                    ),
                  ),
                  Text(
                    'Delivery Partner:',
                    style: TextStyle(
                        fontSize: mq.height * 0.05,
                        fontWeight: FontWeight.w300,
                        color: Color.fromARGB(255, 0, 128, 0)),
                  ),
                  Text(
                    'Register & Earn Now',
                    style: TextStyle(
                      fontSize: mq.height * 0.04,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: mq.height * 0.2,
            child: Padding(
              padding: const EdgeInsets.all(40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => loginScreen()));
                    },
                    child: Text(
                      "Skip",
                      style: TextStyle(
                          fontSize: mq.height * 0.025,
                          color: Color.fromARGB(255, 185, 05, 05),
                          decoration: TextDecoration.underline),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context, MaterialPageRoute(builder: (_) => frame2()));
                    },
                    child: Container(
                      height: 45,
                      width: mq.height * 0.15,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7),
                          border: Border.all(
                              color: const Color.fromARGB(255, 185, 05, 05))),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Next",
                            style: TextStyle(
                                fontSize: 18,
                                color: Color.fromARGB(255, 185, 05, 05)),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
