import 'package:driver/auth/login_screen.dart';
import 'package:driver/main.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class frame3 extends StatelessWidget {
  frame3({super.key});
  final introdata = GetStorage();

  @override
  Widget build(BuildContext context) {
    introdata.write("displayed", true);
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: mq.height * 0.1,
          ),
          Container(
            height: mq.height * 0.3,
            decoration: const BoxDecoration(
              color: Colors.blue,
              image: DecorationImage(
                image: AssetImage("assets/images/step.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            height: mq.height * 0.4,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Register with Chop-Chop",
                    style: TextStyle(
                        fontSize: mq.width * 0.045,
                        fontWeight: FontWeight.w700),
                  ),
                  Text(
                    "Upload your PAN & AADHAR to get registered.",
                    style: TextStyle(
                        fontSize: mq.width * 0.04,
                        color: const Color.fromARGB(255, 87, 87, 87)),
                  ),
                  SizedBox(
                    height: mq.width * 0.05,
                  ),
                  Text(
                    "Complete the Delivery Partner Training",
                    style: TextStyle(
                        fontSize: mq.width * 0.045,
                        fontWeight: FontWeight.w700),
                  ),
                  Text(
                    "Get a training order to our nearest onboarding centre.Deliver it & complete your training.",
                    style: TextStyle(
                        fontSize: mq.width * 0.04,
                        color: const Color.fromARGB(255, 87, 87, 87)),
                  ),
                  SizedBox(
                    height: mq.width * 0.05,
                  ),
                  Text(
                    "Start Earning Now!",
                    style: TextStyle(
                        fontSize: mq.width * 0.045,
                        fontWeight: FontWeight.w700),
                  ),
                  Text(
                    "Book a delivery slot of your choice to go\nonline & get your first order.Get paid\nfor every order.",
                    style: TextStyle(
                        fontSize: mq.width * 0.04,
                        color: const Color.fromARGB(255, 87, 87, 87)),
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: mq.height * 0.2,
            child: Padding(
              padding: const EdgeInsets.all(40),
              child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                GestureDetector(
                  onTap: () {
                    introdata.write("displayed", true);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => loginScreen()));
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
                          "Login",
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
        ],
      ),
    );
  }
}
