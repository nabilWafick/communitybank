import 'package:communitybank/views/widgets/products/products.widgets.dart';
import 'package:communitybank/views/widgets/products/types_list/types_list.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TypesPage extends ConsumerWidget {
  const TypesPage({super.key});

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
          TypesSortOptions(),
          TypesList(),
        ],
      ),
    );
  }
}
