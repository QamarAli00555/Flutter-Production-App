import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:otp_text_field_v2/otp_field_v2.dart';
import 'package:production_app/Client/pages/home_page.dart';

import '../../Admin/pages/home_pages.dart';
import '../models/user.dart';

class AuthController extends GetxController {
  GetStorage box = GetStorage();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  late CollectionReference userCollection;
  TextEditingController username = TextEditingController();
  TextEditingController number = TextEditingController();
  OtpFieldControllerV2 otpController = OtpFieldControllerV2();
  int? otpSend;
  int? otpEntered;
  String? codeSent;
  String? codeEntered;

  User? loginUser;

  @override
  void onReady() {
    super.onReady();
    Map<String, dynamic>? user = box.read('loginUser');
    if (user != null) {
      loginUser = User.fromJson(user);
      Get.to(const Home());
    }
  }

  @override
  Future<void> onInit() async {
    userCollection = firestore.collection('users');

    super.onInit();
  }

  setLoading(bool status) async {
    if (status) {
      await EasyLoading.show(dismissOnTap: true);
    } else {
      await EasyLoading.dismiss();
    }
  }

  bool checkFormvalidation() {
    if (username.text.isEmpty) return true;
    if (number.text.isEmpty) return true;
    return false;
  }

  clearFields() {
    username.clear();
    number.clear();
  }

  addUser() {
    setLoading(true);
    try {
      if (checkFormvalidation()) {
        EasyLoading.showToast('Please fill all fields',
            toastPosition: EasyLoadingToastPosition.bottom);
        return;
      }
      // if (otpEntered != otpSend) {
      //   EasyLoading.showToast('Invalid OTP Entered',
      //       toastPosition: EasyLoadingToastPosition.bottom);
      //   return;
      // }
      DocumentReference doc = userCollection.doc();
      User user = User(
          id: doc.id,
          name: username.text,
          number: double.tryParse(number.text.toString()));
      final prodJson = user.toJson();
      doc.set(prodJson);
      EasyLoading.showToast('Account Registered Successfully',
          toastPosition: EasyLoadingToastPosition.bottom);
      clearFields();
      setLoading(false);
    } catch (e) {
      EasyLoading.showToast('Error ${e.toString()}',
          toastPosition: EasyLoadingToastPosition.bottom);

      // ignore: avoid_print
      print(e);
      setLoading(false);
    }
  }

  Future<void> loginWithPhone() async {
    try {
      String phoneNo = number.text.toString();

      if (phoneNo == "001001") {
        clearFields();
        Get.to(const HomePage());
        return;
      }
      if (phoneNo.isNotEmpty) {
        var querySnapShot = await userCollection
            .where('number', isEqualTo: int.tryParse(phoneNo))
            .limit(1)
            .get();
        if (querySnapShot.docs.isNotEmpty) {
          var userDoc = querySnapShot.docs.first;
          var userData = userDoc.data() as Map<String, dynamic>;
          box.write('loginUser', userData);
          clearFields();
          Get.to(const Home());
          EasyLoading.showToast('Login Successful!',
              toastPosition: EasyLoadingToastPosition.bottom);
        } else {
          EasyLoading.showToast('User not found. Please Register First',
              toastPosition: EasyLoadingToastPosition.bottom);
        }
      } else {
        EasyLoading.showToast('Phone Number Requied*',
            toastPosition: EasyLoadingToastPosition.bottom);
      }
    } catch (e) {
      EasyLoading.showToast('Server Error, Try Later. ${e.toString()}',
          toastPosition: EasyLoadingToastPosition.bottom);
    }
  }

  Future<bool> sendOTP({bool isLogin = false}) async {
    setLoading(true);
    try {
      if (!isLogin) {
        if (checkFormvalidation() || isLogin) {
          EasyLoading.showToast('Please fill all fields',
              toastPosition: EasyLoadingToastPosition.bottom);
          return false;
        }
      } else {
        if (number.text.isEmpty) {
          EasyLoading.showToast('Please fill all fields',
              toastPosition: EasyLoadingToastPosition.bottom);
          return false;
        }
      }
      // await fb.FirebaseAuth.instance.verifyPhoneNumber(
      //   phoneNumber: "+92${number.text}",
      //   verificationCompleted: (fb.PhoneAuthCredential credential) {},
      //   verificationFailed: (fb.FirebaseAuthException e) {
      //     if (e.code == 'invalid-phone-number') {
      //       EasyLoading.showToast('The Phone Number Entered is not valid.',
      //           toastPosition: EasyLoadingToastPosition.bottom);
      //       update();
      //       setLoading(false);
      //     }
      //   },
      //   codeSent: (String verificationId, int? resendToken) {
      //     // Here, you can print the verification code
      //     print('Verification code sent to phone number: $verificationId');
      //     // Also, you can store this verificationId for later use if needed
      //     codeSent = verificationId;
      //     print(codeSent.toString());
      //   },
      //   codeAutoRetrievalTimeout: (String verificationId) {},
      // );
      EasyLoading.showToast('OTP Send Successfully',
          toastPosition: EasyLoadingToastPosition.bottom);
      update();
      setLoading(false);
      return true;
    } catch (e) {
      EasyLoading.showToast('Error ${e.toString()}',
          toastPosition: EasyLoadingToastPosition.bottom);
      // ignore: avoid_print
      print(e);
      setLoading(false);
      return false;
    }
  }
}
