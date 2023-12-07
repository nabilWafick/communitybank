import 'package:communitybank/views/widgets/products/products.widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TypesList extends ConsumerWidget {
  const TypesList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        /*  const CBText(
          text: 'Liste des produits',
          fontSize: 20.0,
        ),
        const SizedBox(
          height: 30.0,
        ),*/
        SizedBox(
          height: 670.0,
          child: SingleChildScrollView(
            child: Wrap(
              children: [
                for (int i = 0; i < 20; ++i) const TypeCard(),
              ],
            ),
          ),
        )
      ],
    );
  }
}
