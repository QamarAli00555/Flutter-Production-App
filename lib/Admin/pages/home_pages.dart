import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../Client/pages/login_page.dart';
import '../controller/admin_home_controller.dart';
import 'add_product.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AdminHomeController>(builder: (cntrl) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Footware Admin'),
          centerTitle: true,
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
                onPressed: () {
                  GetStorage box = GetStorage();
                  box.erase();
                  Get.to(const LoginPage());
                },
                icon: const Icon(Icons.logout))
          ],
        ),
        body: ListView.builder(
            itemCount: cntrl.products.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(cntrl.products[index].name ?? ''),
                subtitle: Text((cntrl.products[index].price ?? '').toString()),
                trailing: IconButton(
                    onPressed: () {
                      cntrl.deleteProducts(cntrl.products[index].id ?? '');
                    },
                    icon: const Icon(Icons.delete)),
              );
            }),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.to(const AddProducts());
          },
          child: const Icon(Icons.add),
        ),
      );
    });
  }
}
