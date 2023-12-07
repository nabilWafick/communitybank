import 'package:communitybank/views/widgets/products/products.widgets.dart';
import 'package:communitybank/views/widgets/products/products_list/products_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductsPage extends ConsumerWidget {
  const ProductsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      margin: const EdgeInsets.only(
        top: 10.0,
      ),
      child: const Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ProductsSortOptions(),
          ProductsList(),
        ],
      ),
    );
  }
}
