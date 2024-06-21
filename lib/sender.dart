import 'package:flutter/material.dart';

void main() async {
  await WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(); // await the initialization
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: OTPSender(),
    );
  }
}

class OTPSender extends StatefulWidget {
  @override
  _OTPSenderState createState() => _OTPSenderState();
}

class _OTPSenderState extends State<OTPSender> {
  final TextEditingController phoneNumberController = TextEditingController();
  String verificationId = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('OTP Sender with Firebase'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: phoneNumberController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(labelText: 'Phone Number'),
            ),
            ElevatedButton(
              onPressed: _verifyPhoneNumber,
              child: Text('Send OTP'),
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Enter OTP'),
            ),
            ElevatedButton(
              onPressed: _signInWithPhoneNumber,
              child: Text('Verify OTP'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _verifyPhoneNumber() async {
    // String phoneNumber = phoneNumberController.text;

    // await _auth.verifyPhoneNumber(
    //   phoneNumber: '+91$phoneNumber',
    //   // phoneNumber: '+919304837716',
    //   verificationCompleted: (PhoneAuthCredential credential) {},
    //   verificationFailed: (FirebaseAuthException e) {
    //     print("Verification failed: ${e.message}");
    //   },
    //   codeSent: (String verificationId, int? resendToken) {
    //     setState(() {
    //       this.verificationId = verificationId;
    //     });
    //     ScaffoldMessenger.of(context).showSnackBar(
    //       SnackBar(
    //         content: Text('OTP Sent to $phoneNumber'),
    //       ),
    //     );
    //   },
    //   codeAutoRetrievalTimeout: (String verificationId) {},
    // );
  }

  Future<void> _signInWithPhoneNumber() async {
    // String otp = "791504"; // Get the OTP from the user input

    // try {
    //   PhoneAuthCredential credential = PhoneAuthProvider.credential(
    //     verificationId: verificationId,
    //     smsCode: otp,
    //   );
    //   await _auth.signInWithCredential(credential);

    //   // You can now access the signed-in user
    //   User? user = _auth.currentUser;
    //   if (user != null) {
    //     print("User logged in: ${user.uid}");
    //   }
    // } catch (e) {
    //   print("Failed to sign in: $e");
    // }
  }
}
