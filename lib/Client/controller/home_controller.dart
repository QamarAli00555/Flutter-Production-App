import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:production_app/Client/models/products-category/product_cartegory.dart';

import '../models/products/product.dart';

class HomeController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  late CollectionReference productCollection;
  late CollectionReference productCategoryCollection;
  List<Product> products = [];
  List<Product> UiProducts = [];
  List<ProductCategory> productCategories = [];

  @override
  Future<void> onInit() async {
    productCollection = firestore.collection('products');
    productCategoryCollection = firestore.collection('category');
    await fetchProducts();
    await fetchProductsCategory();
    super.onInit();
  }

  fetchProducts() async {
    try {
      QuerySnapshot productSnaps = await productCollection.get();
      final List<Product> retrievedProducts = productSnaps.docs
          .map((e) => Product.fromJson(e.data() as Map<String, dynamic>))
          .toList();
      products.clear();
      products.assignAll(retrievedProducts);
      UiProducts.assignAll(retrievedProducts);
      // EasyLoading.showToast('Products Fetched Successfully.',
      //     toastPosition: EasyLoadingToastPosition.bottom);
    } catch (e) {
      EasyLoading.showToast('Error ${e.toString()}',
          toastPosition: EasyLoadingToastPosition.bottom);
      // ignore: avoid_print
      print(e);
    } finally {
      update();
    }
  }

  fetchProductsCategory() async {
    try {
      QuerySnapshot productSnaps = await productCategoryCollection.get();
      final List<ProductCategory> retrievedProducts = productSnaps.docs
          .map(
              (e) => ProductCategory.fromJson(e.data() as Map<String, dynamic>))
          .toList();
      productCategories.clear();
      productCategories.assignAll(retrievedProducts);
      // EasyLoading.showToast('Products Categories Fetched Successfully.',
      //     toastPosition: EasyLoadingToastPosition.bottom);
    } catch (e) {
      EasyLoading.showToast('Error ${e.toString()}',
          toastPosition: EasyLoadingToastPosition.bottom);
      // ignore: avoid_print
      print(e);
    } finally {
      update();
    }
  }

  filterByCategory(String category) async {
    UiProducts.clear();
    UiProducts =
        products.where((element) => element.category == category).toList();
    update();
  }

  sortByPrice(bool ascending) async {
    List<Product> sortedProd = List<Product>.from(products);
    sortedProd.sort((a, b) => ascending
        ? a.price!.compareTo(b.price!)
        : b.price!.compareTo(a.price!));
    UiProducts.assignAll(sortedProd);
    update();
  }

  filterByBrand(List<String> brands) {
    if (brands.isEmpty) {
      UiProducts.clear();
      UiProducts.assignAll(products);
    }
    List<String> lowerBrands = brands.map((e) => e.toLowerCase()).toList();
    UiProducts = products
        .where((e) => lowerBrands.contains(e.brand?.toString()))
        .toList();
    update();
  }
}
