import 'package:driver/dashboard/ReceiveOTP2.dart';
import 'package:driver/dashboard/map2.dart';
import 'package:driver/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:slide_action/slide_action.dart';
import 'package:slider_button/slider_button.dart';

class cashR extends StatefulWidget {
  const cashR({super.key});

  @override
  State<cashR> createState() => _cashRState();
}

class _cashRState extends State<cashR> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        SizedBox(
          height: mq.height * 0.2,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: mq.width * 1,
              height: mq.height * 0.4,
              child: Image.asset("assets/images/cashh.png"),
            ),
          ],
        ),
        SizedBox(
          height: mq.height * 0.05,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Row(
            children: [
              Text(
                "Receive cash",
                style: const TextStyle(
                  fontFamily: "Inter",
                  fontSize: 36,
                  fontWeight: FontWeight.w600,
                  color: Color(0xff000000),
                  height: 44 / 36,
                ),
                textAlign: TextAlign.start,
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Row(
            children: [
              Text(
                "Order ID : ",
                style: const TextStyle(
                  fontFamily: "Inter",
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Color(0xff000000),
                ),
                textAlign: TextAlign.left,
              ),
              Text(
                "${mapdata2[0]['order_ID'].toString().substring(0, 7)}",
                style: const TextStyle(
                  fontFamily: "Inter",
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Color(0xff000000),
                ),
                textAlign: TextAlign.left,
              ),
            ],
          ),
        ),
        SizedBox(
          height: mq.height * 0.02,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Row(
            children: [
              Text(
                "Bill Amount : ",
                style: const TextStyle(
                  fontFamily: "Inter",
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Color(0xff000000),
                ),
                textAlign: TextAlign.left,
              ),
              Text(
                "₹ ${mapdata2[0]['Total_price']}",
                style: const TextStyle(
                  fontFamily: "Inter",
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Color(0xff000000),
                ),
                textAlign: TextAlign.left,
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: SlideAction(
            trackBuilder: (context, state) {
              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 8,
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    // Show loading if async operation is being performed
                    state.isPerformingAction
                        ? "Payment Received Successfully"
                        : "Receive Payment",
                  ),
                ),
              );
            },
            thumbBuilder: (context, state) {
              return Container(
                margin: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 0, 128, 0),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Center(
                  // Show loading indicator if async operation is being performed
                  child: state.isPerformingAction
                      ? const CupertinoActivityIndicator(
                          color: Colors.white,
                        )
                      : const Icon(
                          Icons.chevron_right,
                          color: Colors.white,
                        ),
                ),
              );
            },
            action: () async {
              // Async operation
              await Future.delayed(
                  const Duration(seconds: 2),
                  () => Navigator.push(
                      context, MaterialPageRoute(builder: (_) => otp2())));
            },
          ),
        ),
      ]),
    );
  }
}
