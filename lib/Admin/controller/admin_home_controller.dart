import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/products/product.dart';

class AdminHomeController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  late CollectionReference productCollection;
  TextEditingController productNameCtrl = TextEditingController();
  TextEditingController productDescCtrl = TextEditingController();
  TextEditingController productImgCtrl = TextEditingController();
  TextEditingController productPriceCtrl = TextEditingController();
  String category = "general";
  String brand = 'un branded';
  bool offer = false;

  List<Product> products = [];

  @override
  Future<void> onInit() async {
    productCollection = firestore.collection('products');
    await fetchProducts();
    super.onInit();
  }

  bool checkFormvalidation() {
    if (productNameCtrl.text.isEmpty) return true;
    if (productDescCtrl.text.isEmpty) return true;
    if (productImgCtrl.text.isEmpty) return true;
    if (productPriceCtrl.text.isEmpty) return true;
    return false;
  }

  clearFields() {
    productNameCtrl.clear();
    productDescCtrl.clear();
    productImgCtrl.clear();
    productPriceCtrl.clear();
    category = 'general';
    brand = 'un branded';
    offer = false;
  }

  addProduct() {
    try {
      if (checkFormvalidation()) {
        Get.snackbar('Info', 'Please fill all fields',
            colorText: Colors.grey, snackPosition: SnackPosition.BOTTOM);
        return;
      }
      DocumentReference doc = productCollection.doc();
      Product product = Product(
          id: doc.id,
          name: productNameCtrl.text,
          category: category,
          description: productDescCtrl.text,
          price: double.tryParse(productPriceCtrl.text),
          brand: brand,
          image: productImgCtrl.text,
          offer: offer);
      final prodJson = product.toJson();
      doc.set(prodJson);
      fetchProducts();
      Get.snackbar('Success', 'Product Added Successfully',
          colorText: Colors.green);
      clearFields();
    } catch (e) {
      Get.snackbar('Error', e.toString(), colorText: Colors.red);
      // ignore: avoid_print
      print(e);
    }
  }

  fetchProducts() async {
    try {
      QuerySnapshot productSnaps = await productCollection.get();
      final List<Product> retrievedProducts = productSnaps.docs
          .map((e) => Product.fromJson(e.data() as Map<String, dynamic>))
          .toList();
      products.clear();
      products.assignAll(retrievedProducts);
    } catch (e) {
      Get.snackbar('Error', e.toString(), colorText: Colors.red);
      // ignore: avoid_print
      print(e);
    } finally {
      update();
    }
  }

  deleteProducts(String id) async {
    try {
      await productCollection.doc(id).delete();
      fetchProducts();
    } catch (e) {
      Get.snackbar('Error', e.toString(), colorText: Colors.red);
      // ignore: avoid_print
      print(e);
    }
  }
}
