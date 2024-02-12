import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:production_app/Admin/pages/Widgets/dropdown_button_multiselect.dart';
import 'package:production_app/Admin/pages/Widgets/product_card.dart';
import 'package:production_app/Client/controller/home_controller.dart';
import 'package:production_app/Client/pages/login_page.dart';
import 'package:production_app/Client/pages/product_description_page.dart';

import '../../Admin/pages/Widgets/dropdown_button.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (ctrl) {
      return RefreshIndicator(
        onRefresh: () async {
          ctrl.fetchProducts();
        },
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            title: const Text('Footwear Store'),
            automaticallyImplyLeading: false,
            centerTitle: true,
            actions: [
              IconButton(
                  onPressed: () {
                    GetStorage box = GetStorage();
                    box.erase();
                    Get.offAll(const LoginPage());
                  },
                  icon: const Icon(Icons.logout))
            ],
          ),
          body: SizedBox(
            width: double.maxFinite,
            child: Column(
              children: [
                SizedBox(
                  height: 50,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: ctrl.productCategories.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: InkWell(
                            onTap: () {
                              ctrl.filterByCategory(
                                  ctrl.productCategories[index].name!);
                            },
                            child: Chip(
                                label:
                                    Text(ctrl.productCategories[index].name!)),
                          ),
                        );
                      }),
                ),
                SizedBox(
                  height: 50,
                  child: Row(
                    children: [
                      Flexible(
                          child: DropdownBtn(
                              items: const [
                            'Rs: Low to High',
                            'Rs: High to Low'
                          ],
                              selectedItemText: 'Sort',
                              onSelecteed: (String? val) {
                                ctrl.sortByPrice(
                                    val == 'Rs: Low to High' ? true : false);
                              })),
                      Flexible(
                          child: DropdownBtnMultiSelect(
                        items: const [
                          'Addidas',
                          'Puma',
                          'Sketchers',
                        ],
                        onselectionChange: (selectedItems) {
                          ctrl.filterByBrand(selectedItems);
                        },
                      )),
                    ],
                  ),
                ),
                Expanded(
                  child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 0.8,
                              crossAxisSpacing: 8,
                              mainAxisSpacing: 8),
                      itemCount: ctrl.UiProducts.length,
                      itemBuilder: (context, index) {
                        return ProductCard(
                          name: ctrl.UiProducts[index].name ?? 'No Name',
                          price: ctrl.UiProducts[index].price ?? 0.0,
                          offertag: '20% off',
                          image:
                              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRvT1G0T-1M2KBjEGJYsYxd5qA4j9vyejFL1ArtUQVBTxPVkPzoNS4g-K0M4HiOLwlzYPs&usqp=CAU',
                          onPressed: () {
                            Get.to(const ProductDescription(),
                                arguments: {'data': ctrl.UiProducts[index]});
                          },
                        );
                      }),
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}
