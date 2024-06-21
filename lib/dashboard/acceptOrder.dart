import 'package:driver/dashboard/afterlogin.dart';
import 'package:driver/dashboard/history.dart';
import 'package:driver/main.dart';
import 'package:flutter/material.dart';

class success extends StatefulWidget {
  const success({super.key});

  @override
  State<success> createState() => _successState();
}

class _successState extends State<success> {
  @override
  void initState() {
    super.initState();
    // SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    Future.delayed(Duration(seconds: 3), () {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (_) => history()));
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Text(
              "Order Accepted Successfully",
              style: TextStyle(
                color: Colors.black,
                fontSize: 24,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w700,
                height: 0,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(20.0),
            child: Text(
              'Thank you for choosing CHOP-CHOP. Visit history section to deliver your parcel.',
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w400,
                height: 0,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Container(child: Image.asset("assets/images/success.png")),
        ],
      ),
    );
  }
}
