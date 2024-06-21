import 'package:driver/dashboard/afterlogin.dart';
import 'package:driver/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(OrderPlaced());
}

class OrderPlaced extends StatefulWidget {
  const OrderPlaced({super.key});

  @override
  State<OrderPlaced> createState() => _OrderPlacedState();
}

class _OrderPlacedState extends State<OrderPlaced> {
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
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.8,
                height: MediaQuery.of(context).size.height * 0.4,
                child: Image.asset(
                  "assets/images/p.png",
                ),
              ),
            ),
            const Text(
              "Order Delivered Successfully.",
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w400),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.008,
            ),
            const Text(
              "A big thank you for successfully delivering the order.",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            Container(
              height: mq.height * 0.2,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: mq.width * 1,
                    child: TextButton(
                      onPressed: () async {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (_) => Alogin()));
                        // checkOtp(phoneNumberC, otppp);
                      },
                      child: Container(
                        height: mq.height * 0.060,
                        width: mq.width * 0.86,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(7),
                            border: Border.all(
                                color: Color.fromARGB(255, 0, 128, 0))),
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Back to Dashboard",
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Color.fromARGB(255, 0, 128, 0)),
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
    );
  }
}
