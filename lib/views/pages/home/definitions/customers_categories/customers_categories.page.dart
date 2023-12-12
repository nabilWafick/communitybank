import 'package:communitybank/views/widgets/definitions/customers_categories/customers_catgeories.widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomersCategoriesPage extends ConsumerWidget {
  const CustomersCategoriesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Column(
      children: [
        CustomersCategoriesSortOptions(),
        CustomersCategoriesList(),
      ],
    );
  }
}
