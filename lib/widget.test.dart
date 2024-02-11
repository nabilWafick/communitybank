import 'package:communitybank/functions/common/common.function.dart';
import 'package:communitybank/utils/colors/colors.util.dart';
import 'package:communitybank/views/widgets/forms/response_dialog/response_dialog.widget.dart';
import 'package:communitybank/views/widgets/globals/global.widgets.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final settlementsCollectionDateProvider = StateProvider<DateTime?>((ref) {
  return;
});

class WidgetTest extends StatefulHookConsumerWidget {
  const WidgetTest({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _WidgetTestState();
}

class _WidgetTestState extends ConsumerState<WidgetTest> {
  @override
  void initState() {
    super.initState();
    initializeDateFormatting('fr');
  }

  dynamic data;

  @override
  Widget build(BuildContext context) {
    //  final heigth = MediaQuery.of(context).size.height;
    //  final width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CBText(
              text: data.toString(),
            ),
            const SizedBox(
              height: 200,
            ),
            Container(
              alignment: Alignment.center,
              width: 500.0,
              child: CBElevatedButton(
                text: 'Show dialog',
                onPressed: () async {
                  final supabase = Supabase.instance.client;
                  final result = await supabase.rpc(
                    'get_all_customer_card_settlements',
                    params: {
                      'customer_card_id': '84',
                    },
                  );
                  setState(
                    () {
                      data = result;
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FormCard extends ConsumerWidget {
  const FormCard({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const formCardWidth = 500.0;
    return AlertDialog(
      contentPadding: const EdgeInsetsDirectional.symmetric(
        vertical: 20.0,
        horizontal: 10.0,
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
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
                          text: 'Status',
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
                    Container(
                      margin: const EdgeInsets.symmetric(
                        vertical: 25.0,
                      ),
                      child: const Row(
                        children: [
                          Icon(
                            Icons.info,
                            color: CBColors.primaryColor,
                            size: 30.0,
                          ),
                          SizedBox(
                            width: 25.0,
                          ),
                          CBText(
                            text: 'Opération réussie',
                            fontSize: 15.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/*
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
                    //  width: formCardWidth,

                    label: 'Produit',
                    providerName: 'product-selection-ui-test-product',
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
*/