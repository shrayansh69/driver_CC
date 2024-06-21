import 'package:driver/dashboard/afterlogin.dart';
import 'package:driver/main.dart';
import 'package:flutter/material.dart';

class processed extends StatefulWidget {
  const processed({super.key});

  @override
  State<processed> createState() => _processedState();
}

class _processedState extends State<processed> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.85,
            width: double.infinity,
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    SizedBox(
                      width: mq.width * 0.4,
                      child: Image.asset(
                        "assets/images/logo.png",
                        width: 80,
                      ),
                    ),
                    SizedBox(
                      height: 100,
                    ),
                    Text(
                      "Payment added Successfully",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 24,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w600),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: mq.width * 1,
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (_) => Alogin()));
                        },
                        child: Container(
                          height: mq.height * 0.060,
                          width: mq.width * 0.8,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7),
                              border: Border.all(
                                  color:
                                      const Color.fromARGB(255, 185, 05, 05))),
                          child: const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Return Home",
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Color.fromARGB(255, 185, 05, 05)),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
          // ? loginScreen()
          ,
        ],
      ),
    );
  }
}
