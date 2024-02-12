import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:production_app/Client/controller/auth_controller.dart';
import 'package:production_app/Client/models/user.dart';
import 'package:production_app/Client/pages/home_page.dart';

class PurchaseController extends GetxController {
  double orderPrice = 0;
  String itemName = '';
  String orderAddress = '';
  TextEditingController address = TextEditingController();

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  late CollectionReference orderCollection;
  @override
  Future<void> onInit() async {
    orderCollection = firestore.collection('orders');

    super.onInit();
  }

  submitOrder(
      {required double price,
      required String name,
      required String description}) {
    orderPrice = price;
    itemName = name;
    orderAddress = address.text.toString();
    if (address.text.isEmpty) {
      EasyLoading.showToast('Address is Reuired*',
          toastPosition: EasyLoadingToastPosition.bottom);
      return;
    }
    orderSuccess(transactionId: '');
  }

  String generateTransactionId() {
    // Define a prefix for the transaction ID
    String prefix = 'TXN';

    // Generate a random number of length 6
    int randomNumber = Random().nextInt(999999);

    // Pad the random number with leading zeros to ensure it has 6 digits
    String paddedRandomNumber = randomNumber.toString().padLeft(6, '0');

    // Concatenate the prefix and random number to form the transaction ID
    String transactionId = '$prefix$paddedRandomNumber';

    return transactionId;
  }

  Future<void> orderSuccess({required String? transactionId}) async {
    User? loginUser = Get.find<AuthController>().loginUser;
    try {
      transactionId = generateTransactionId();
      if (transactionId != '') {
        DocumentReference docRef = await orderCollection.add({
          'customer': loginUser?.name ?? '',
          'phone': loginUser?.number ?? '',
          'item': itemName,
          'price': orderPrice,
          'address': orderAddress,
          'transaction': transactionId,
          'datetime': DateTime.now().toString()
        });
        // ignore: avoid_print
        print('Order Created Successfully: ${docRef.id}');
        EasyLoading.showToast('Order Created Successfully',
            toastPosition: EasyLoadingToastPosition.bottom);
        address.clear();
        Get.to(const Home());
      } else {
        EasyLoading.showToast('Failed Transaction',
            toastPosition: EasyLoadingToastPosition.bottom);
      }
    } catch (e) {
      EasyLoading.showToast('Failed Transaction',
          toastPosition: EasyLoadingToastPosition.bottom);
    }
  }
}
