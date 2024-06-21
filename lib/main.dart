import 'package:driver/dashboard/afterlogin.dart';
import 'package:driver/splash_screen/splash_screen.dart';
import 'package:driver/splash_screen/splash_screen2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';

late Size mq;
void main() async {
  await GetStorage.init();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  await WidgetsFlutterBinding.ensureInitialized();

  // await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final introdata = GetStorage();
  final AfterLogin = GetStorage();
  MyApp({super.key});
  // ignore: override_on_non_overriding_member
  void initState() {
    introdata.writeIfNull("displayed", false);
    introdata.writeIfNull("loggedIN", false);
  }

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
      ),
      home: (introdata.read("displayed") ?? false)
          ? ((AfterLogin.read("displayed") ?? false)
              ? SplashScreen2()
              : Alogin())
          : const SplashScreen(),

      // home: loginScreen(),
    );
  }
}
