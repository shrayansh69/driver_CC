import 'package:driver/dashboard/afterlogin.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Help extends StatefulWidget {
  const Help({super.key});

  @override
  State<Help> createState() => _HelpState();
}

class _HelpState extends State<Help> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Help',
            style: TextStyle(color: Colors.black),
          ),
          elevation: 0,
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Alogin()),
              );
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              const Text(
                "We're grateful for your trust in us!",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Color(0xff056300)),
              ),
              Image.asset('assets/images/contact.gif'),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              Column(
                children: [
                  const Text(
                    "Contact Us",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  const Divider(
                    color: Colors.grey, // You can set the color of the line
                    thickness: 1,
                    endIndent: 30,
                    indent: 30, // You can set an indent from the right
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  GestureDetector(
                    onTap: () {
                      launch(
                          "tel:+918193054444"); // This will open the dial pad with the given number
                    },
                    child: const Text(
                      "+91-8193054444",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w300,
                          color: Colors.blue),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.005),
                  const Text(
                    "support@chopchoplogistic.com",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w300),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.005),
                  const Text(
                    "S-15, Pratap Palace, 410, Indira Nagar Colony, Dehradun, Pincode - 248006",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w300),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.005),
                  const Text(
                    "www.chopchoplogistic.com",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w300),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: const CircleBorder(),
                          backgroundColor: Colors.blue[600],
                          padding: const EdgeInsets.all(2),
                          shadowColor: Colors.transparent,
                        ),
                        onPressed: () {
                          // ignore: deprecated_member_use
                          launch("tel:+918193054444");
                        },
                        child: const Icon(
                          Icons.call,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ],
                  )
                ],
              )
            ],
          ),
        ));
  }
}

class SendEmailButton extends StatelessWidget {
  final String email;

  const SendEmailButton({super.key, required this.email});

  void _sendEmail() async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: email,
    );

    if (await canLaunch(emailLaunchUri.toString())) {
      await launch(emailLaunchUri.toString());
    } else {
      throw 'Could not launch email';
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: _sendEmail,
      child: const Text('Send Email'),
    );
  }
}
