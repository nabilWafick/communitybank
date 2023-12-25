import 'package:communitybank/utils/colors/colors.util.dart';
import 'package:communitybank/views/widgets/globals/global.widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TypeProductSelection extends ConsumerWidget {
  const TypeProductSelection({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const formCardWidth = 450.0;
    return Container(
      // color: Colors.blueGrey,
      padding: const EdgeInsets.all(20.0),
      width: formCardWidth,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const CBText(
                    text: 'Produit',
                    fontSize: 20.0,
                    fontWeight: FontWeight.w600,
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(
                      Icons.close_rounded,
                      color: CBColors.primaryColor,
                      size: 30.0,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 35.0,
              ),
              Wrap(
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 5.0,
                      vertical: 5.0,
                    ),
                    child: const CBDropdown(
                      //  width: formCardWidth / 1.2,
                      label: 'Produit',
                      providerName: 'types-selection-update-product',
                      dropdownMenuEntriesLabels: [
                        //      '',
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
                  Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 10.0,
                    ),
                    width: formCardWidth / 1.2,
                    child: CBTextFormField(
                      label: 'Nombre',
                      hintText: 'Nombre de produit',
                      isMultilineTextForm: false,
                      obscureText: false,
                      textInputType: TextInputType.name,
                      validator: (val, ref) {
                        return null;
                      },
                      onChanged: (val, ref) {},
                    ),
                  ),
                ],
              )
            ],
          ),
          const SizedBox(
            height: 35.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(
                width: 170.0,
                child: CBElevatedButton(
                  text: 'Fermer',
                  backgroundColor: CBColors.sidebarTextColor,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
              const SizedBox(
                width: 20.0,
              ),
              SizedBox(
                width: 170.0,
                child: CBElevatedButton(
                  text: 'Valider',
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
