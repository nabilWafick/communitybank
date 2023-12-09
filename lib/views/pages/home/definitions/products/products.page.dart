import 'package:communitybank/views/widgets/definitions/products/products.widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductsPage extends ConsumerWidget {
  const ProductsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Column(
      children: [
        ProductsSortOptions(),
        ProductsList(),
      ],
    );
  }
}
