import 'package:communitybank/views/pages/customers/customers.page.dart';
import 'package:communitybank/views/pages/products/products.page.dart';
import 'package:communitybank/views/pages/types/types.page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MainBody extends ConsumerStatefulWidget {
  const MainBody({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MainBodyState();
}

class _MainBodyState extends ConsumerState<MainBody> {
  final pages = [
    'Dashbaord',
    'Clients',
    'Produits',
    'Cartes',
    'Inventaires',
    'Stock',
    'Collaborateurs',
    'Paramètre',
    'Déconnexion'
  ];
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    // final currentPage = ref.watch(selectedSidebarOptionProvider);

    return SizedBox(
      height: screenSize.height * 9 / 10,
      child: const CustomersPage(),
      //    const ProductsPage(),
      // const TypesPage(),

      /*PageView(
        scrollDirection: Axis.vertical,
        onPageChanged: (index) =>
            {ref.read(selectedSidebarOptionProvider.notifier).state = index},
        children: pages
            .map(
              (page) => Center(
                child: CBText(
                  text: pages[currentPage],
                  fontSize: 25.0,
                ),
              ),
            )
            .toList(),
      ),*/
    );
  }
}
