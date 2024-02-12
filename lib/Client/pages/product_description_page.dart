import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:production_app/Client/controller/purchase_controller.dart';

import '../models/products/product.dart';

class ProductDescription extends StatelessWidget {
  const ProductDescription({super.key});

  @override
  Widget build(BuildContext context) {
    Product prod = Get.arguments['data'];
    return GetBuilder<PurchaseController>(builder: (ctrl) {
      return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Product Details',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRvT1G0T-1M2KBjEGJYsYxd5qA4j9vyejFL1ArtUQVBTxPVkPzoNS4g-K0M4HiOLwlzYPs&usqp=CAU',
                  fit: BoxFit.contain,
                  width: double.infinity,
                  height: 200,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                prod.name ?? 'No Name',
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                prod.description ?? 'No Description',
                style: const TextStyle(fontSize: 16, height: 1.5),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'Rs: ${prod.price ?? 0.0}',
                style: const TextStyle(
                    fontSize: 20,
                    color: Colors.green,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                maxLines: 3,
                controller: ctrl.address,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                    labelText: 'Enter your Billing Address'),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple,
                        padding: const EdgeInsets.symmetric(vertical: 15)),
                    onPressed: () {
                      ctrl.submitOrder(
                          price: prod.price!,
                          name: prod.name!,
                          description: prod.description!);
                    },
                    child: const Text(
                      'Buy Now',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    )),
              )
            ],
          ),
        ),
      );
    });
  }
}
