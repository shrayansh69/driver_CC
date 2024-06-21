import 'package:driver/main.dart';
import 'package:driver/welcome_screen/welcome3.dart';
import 'package:flutter/material.dart';

import '../auth/login_screen.dart';

class frame2 extends StatelessWidget {
  const frame2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        SizedBox(
          height: mq.height * 0.1,
        ),
        Container(
          height: mq.height * 0.3,
          decoration: const BoxDecoration(
            color: Colors.blue,
            image: DecorationImage(
              image: AssetImage("assets/images/cash.png"),
              fit: BoxFit.cover,
            ),
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
                  'Why Choose Us to become a Delivery Partner?',
                  style: TextStyle(
                      fontSize: mq.height * 0.03, fontWeight: FontWeight.w800),
                ),
                const SizedBox(
                  height: 10,
                ),
                RichText(
                  text: TextSpan(
                    children: [
                      const WidgetSpan(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 2.0),
                          child: Icon(Icons.watch_later,
                              color: Color.fromARGB(255, 0, 128, 0)),
                        ),
                      ),
                      TextSpan(
                          text: ' Full-time and Part-time Delivery Jobs',
                          style: TextStyle(
                              fontSize: mq.height * 0.025,
                              fontWeight: FontWeight.w300,
                              color: const Color.fromARGB(255, 0, 128, 0))),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                RichText(
                  text: TextSpan(
                    children: [
                      const WidgetSpan(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 2.0),
                          child: Icon(Icons.phone,
                              color: Color.fromARGB(255, 0, 128, 0)),
                        ),
                      ),
                      TextSpan(
                          text: ' Assistance on 2-wheeler renting',
                          style: TextStyle(
                              fontSize: mq.height * 0.025,
                              fontWeight: FontWeight.w300,
                              color: const Color.fromARGB(255, 0, 128, 0))),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                RichText(
                  text: TextSpan(
                    children: [
                      const WidgetSpan(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 2.0),
                          child: Icon(Icons.delivery_dining,
                              color: Color.fromARGB(255, 0, 128, 0)),
                        ),
                      ),
                      TextSpan(
                          text: ' Pick-up & deliver anything in',
                          style: TextStyle(
                              fontSize: mq.height * 0.025,
                              fontWeight: FontWeight.w300,
                              color: const Color.fromARGB(255, 0, 128, 0))),
                    ],
                  ),
                ),
                RichText(
                  text: TextSpan(
                    children: [
                      const WidgetSpan(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 2.0),
                          child:
                              Icon(Icons.delivery_dining, color: Colors.white),
                        ),
                      ),
                      TextSpan(
                          text: ' hyperlocal geography',
                          style: TextStyle(
                              fontSize: mq.height * 0.025,
                              fontWeight: FontWeight.w300,
                              color: const Color.fromARGB(255, 0, 128, 0))),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                RichText(
                  text: TextSpan(
                    children: [
                      const WidgetSpan(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 2.0),
                          child: Icon(Icons.money,
                              color: Color.fromARGB(255, 0, 128, 0)),
                        ),
                      ),
                      TextSpan(
                          text: ' Join Chop-Chop and earn upto',
                          style: TextStyle(
                              fontSize: mq.height * 0.025,
                              fontWeight: FontWeight.w300,
                              color: const Color.fromARGB(255, 0, 128, 0))),
                    ],
                  ),
                ),
                RichText(
                  text: TextSpan(
                    children: [
                      const WidgetSpan(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 2.0),
                          child: Icon(Icons.money, color: Colors.white),
                        ),
                      ),
                      TextSpan(
                          text: ' 35,000₹ per month.',
                          style: TextStyle(
                              fontSize: mq.height * 0.025,
                              fontWeight: FontWeight.w300,
                              color: const Color.fromARGB(255, 0, 128, 0))),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(
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
                    child: const Text(
                      "Skip",
                      style: TextStyle(
                          fontSize: 18,
                          color: Color.fromARGB(255, 185, 05, 05),
                          decoration: TextDecoration.underline),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context, MaterialPageRoute(builder: (_) => frame3()));
                    },
                    child: Container(
                      height: 45,
                      width: mq.width * 0.3,
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
                ]),
          ),
        )
      ]),
    );
  }
}
