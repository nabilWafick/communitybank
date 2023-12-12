import 'package:communitybank/utils/colors/colors.util.dart';
import 'package:communitybank/views/widgets/forms/customers/customers_form.widget.dart';
import 'package:communitybank/views/widgets/forms/types/types_form.widget.dart';
import 'package:communitybank/views/widgets/globals/global.widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WidgetTest extends ConsumerWidget {
  const WidgetTest({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CBElevatedButton(
            text: 'Show dialog',
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => const AlertDialog(
                  contentPadding: EdgeInsetsDirectional.symmetric(
                    vertical: 20.0,
                    horizontal: 10.0,
                  ),
                  content: TypesForm(),
                  // CustomersForm(),
                  // FormCard(),
                ),
              );
            },
          ),
          /* FormCard(),*/
        ],
      ),
    );
  }
}

class FormCard extends ConsumerWidget {
  const FormCard({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const formCardWidth = 500.0;
    return Container(
      // color: Colors.blueGrey,
      padding: const EdgeInsets.all(20.0),
      width: formCardWidth,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const CBText(
                    text: 'Type',
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
                height: 15.0,
              ),
              CBAddButton(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => const AlertDialog(
                      contentPadding: EdgeInsetsDirectional.symmetric(
                        vertical: 20.0,
                        horizontal: 10.0,
                      ),
                      content:
                          // CustomersForm(),
                          TypeProductSelection(),
                    ),
                  );
                },
              ),
              const SizedBox(
                height: 10.0,
              ),
              Wrap(
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 10.0,
                    ),
                    width: formCardWidth,
                    child: CBTextFormField(
                      label: 'Nom',
                      hintText: 'Nom',
                      isMultilineTextForm: false,
                      obscureText: false,
                      textInputType: TextInputType.name,
                      validator: (val, ref) {
                        return null;
                      },
                      onChanged: (val, ref) {},
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 10.0,
                    ),
                    width: formCardWidth,
                    child: CBTextFormField(
                      label: 'Mise',
                      hintText: 'Mise',
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

class TypeProductSelection extends ConsumerWidget {
  const TypeProductSelection({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const formCardWidth = 500.0;
    return Container(
      // color: Colors.blueGrey,
      padding: const EdgeInsets.all(20.0),
      width: formCardWidth,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        // crossAxisAlignment: CrossAxisAlignment.center,
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
                  const CBDropdown(
                    width: formCardWidth,
                    label: 'Produit',
                    dropdownMenuEntriesLabels: [
                      '',
                      'Produit 1',
                      'Produit 2',
                      'Produit 3',
                    ],
                    dropdownMenuEntriesValues: [
                      '',
                      'Produit 1',
                      'Produit 2',
                      'Produit 3',
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 10.0,
                    ),
                    width: formCardWidth,
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
