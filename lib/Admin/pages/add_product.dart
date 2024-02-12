import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/admin_home_controller.dart';
import 'Widgets/dropdown_button.dart';

class AddProducts extends StatelessWidget {
  const AddProducts({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AdminHomeController>(builder: (cntrl) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Add Product'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.all(10),
            width: double.maxFinite,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text('Add Product'),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: cntrl.productNameCtrl,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      label: const Text('Product Name'),
                      hintText: 'Enter Product Name'),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: cntrl.productDescCtrl,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      label: const Text('Product Description'),
                      hintText: 'Enter Product Description'),
                  maxLines: 4,
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: cntrl.productImgCtrl,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      label: const Text('Image URL'),
                      hintText: 'Enter Image URL'),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: cntrl.productPriceCtrl,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      label: const Text('Product Price'),
                      hintText: 'Enter Product Price'),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Flexible(
                        child: DropdownBtn(
                      items: const [
                        'Boots',
                        'Shoe',
                        'Beach Shoe',
                        'High Heels'
                      ],
                      selectedItemText: cntrl.category,
                      onSelecteed: (String? val) {
                        cntrl.category = val ?? 'general';
                        cntrl.update();
                      },
                    )),
                    Flexible(
                        child: DropdownBtn(
                      items: const ['Puma', 'Sketcher', 'Adidas', 'Clarks'],
                      selectedItemText: cntrl.brand,
                      onSelecteed: (String? val) {
                        cntrl.brand = val ?? 'un branded';
                        cntrl.update();
                      },
                    )),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text('Offer Product?'),
                const SizedBox(
                  height: 10,
                ),
                DropdownBtn(
                  items: const ['true', 'false'],
                  selectedItemText: cntrl.offer.toString(),
                  onSelecteed: (String? val) {
                    cntrl.offer = bool.tryParse(val ?? 'false') ?? false;
                    cntrl.update();
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 60),
                        backgroundColor: Colors.indigo,
                        foregroundColor: Colors.white),
                    onPressed: () {
                      cntrl.addProduct();
                    },
                    child: const Text('Add '))
              ],
            ),
          ),
        ),
      );
    });
  }
}
