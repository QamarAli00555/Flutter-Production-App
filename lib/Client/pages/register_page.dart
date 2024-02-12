import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:production_app/Client/controller/auth_controller.dart';
import 'package:production_app/Client/pages/login_page.dart';
import 'package:production_app/Client/pages/verify.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(builder: (cntrl) {
      return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          width: double.maxFinite,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(color: Colors.blueGrey[50]),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Create new Account',
                style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: cntrl.username,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                    prefixIcon: const Icon(Icons.person),
                    labelText: 'Your Name',
                    hintText: "Enter you name"),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: cntrl.number,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                    prefixIcon: const Icon(Icons.phone_android),
                    labelText: 'Mobile Number',
                    hintText: "Enter you mobile number"),
              ),
              const SizedBox(
                height: 20,
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () async {
                  //cntrl.setLoading(true);
                  // return;
                  await cntrl.addUser();
                  Get.to(MyVerify(
                    isLogin: false,
                    number: cntrl.number.text.toString(),
                  ));
                },
                style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.deepPurple),
                child: const Text('Send OTP'),
              ),
              TextButton(
                onPressed: () {
                  Get.to(const LoginPage());
                },
                child: const Text('Already have an acount? Login'),
              ),
            ],
          ),
        ),
      );
    });
  }
}
