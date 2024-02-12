import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:production_app/Admin/controller/admin_home_controller.dart';
import 'package:production_app/Client/controller/auth_controller.dart';
import 'package:production_app/Client/controller/home_controller.dart';
import 'package:production_app/Client/controller/purchase_controller.dart';
import 'package:production_app/Client/pages/login_page.dart';
import 'package:production_app/firebase_options.dart';

Future<void> main() async {
  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: firebaseOptions);
  //? Setting my Controllers
  Get.put(AdminHomeController());
  Get.put(AuthController());
  Get.put(HomeController());
  Get.put(PurchaseController());
  runApp(const MyApp());
  configLoading();
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.wave
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.deepPurple
    ..backgroundColor = Colors.white
    ..indicatorColor = Colors.deepPurple
    ..textColor = Colors.deepPurple
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = true
    ..dismissOnTap = false;
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Footware App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const LoginPage(),
      builder: EasyLoading.init(),
    );
  }
}
