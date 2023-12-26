import 'package:communitybank/views/widgets/globals/product_selection_dropdown/product_selection_dropdown.widget.dart';
import 'package:communitybank/views/widgets/globals/product_selection_textformfield/product_selection_textformfield.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TypeProductSelection extends ConsumerWidget {
  final double formCardWidth;
  const TypeProductSelection({
    super.key,
    required this.formCardWidth,
  });
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const formCardWidth = 450.0;
    return Row(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(
            // horizontal: 5.0,
            vertical: 10.0,
          ),
          child: const CBProductSelectionDropdown(
            width: formCardWidth / 2.05,
            label: 'Produit',
            providerName: 'types-selection-adding-product',
            dropdownMenuEntriesLabels: [
              //  '',
              'Produit 1',
              'Produit 2',
              'Produit 3',
            ],
            dropdownMenuEntriesValues: [
              //     '',
              'Produit 1',
              'Produit 2',
              'Produit 3',
            ],
          ),
        ),
        SizedBox(
          width: formCardWidth / 2.05,
          child: CBProductSelectionTextFormField(
            label: 'Nombre',
            hintText: 'Nombre de produit',
            isMultilineTextForm: false,
            obscureText: false,
            textInputType: TextInputType.number,
            validator: (val, ref) {
              return null;
            },
            onChanged: (val, ref) {},
          ),
        ),
      ],
    );
  }
}
