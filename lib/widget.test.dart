import 'package:communitybank/utils/colors/colors.util.dart';
import 'package:communitybank/views/widgets/globals/global.widgets.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:super_tooltip/super_tooltip.dart';

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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SuperTooltip(
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(
                      vertical: 5.0,
                    ),
                    width: 120.0,
                    child: const Row(
                      children: [
                        Icon(
                          Icons.file_open,
                          size: 20.0,
                          color: CBColors.primaryColor,
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        CBText(
                          text: 'Détails',
                          fontSize: 12.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                      vertical: 5.0,
                    ),
                    width: 120.0,
                    child: const Row(
                      children: [
                        Icon(
                          Icons.edit,
                          size: 20.0,
                          //  color: Colors.green.shade700,
                          color: CBColors.primaryColor,
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        CBText(
                          text: 'Éditer',
                          fontSize: 12.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                      vertical: 5.0,
                    ),
                    width: 120.0,
                    child: const Row(
                      children: [
                        Icon(
                          Icons.delete,
                          size: 20.0,
                          //  color: Colors.red.shade700,
                          color: CBColors.primaryColor,
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        CBText(
                          text: 'Supprimer',
                          fontSize: 12.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                      vertical: 5.0,
                    ),
                    width: 120.0,
                    child: const Row(
                      children: [
                        Icon(
                          Icons.close,
                          size: 20.0,
                          //  color: CBColors.sidebarTextColor,
                          color: CBColors.primaryColor,
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        CBText(
                          text: 'Fermer',
                          fontSize: 12.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              hideTooltipOnTap: true,
              arrowLength: 10,
              showBarrier: false,
              borderColor: CBColors.primaryColor,
              shadowColor: CBColors.primaryColor,
              shadowBlurRadius: 1,
              shadowSpreadRadius: .5,
              elevation: 5.0,
              arrowTipDistance: 10,
              popupDirection: TooltipDirection.right,
              child: const Icon(
                Icons.more_vert,
              ),
            ),
            SizedBox(
              width: 500,
              child: CBElevatedButton(
                onPressed: () async {
                  /*
                    final supabase = Supabase.instance.client;
                    var query = /*
                        supabase.from('clients').stream(primaryKey: ['id']).order(
                      'id',
                      ascending: true,
                    );*/
                        await supabase
                            .from('clients')
                            .select<List<Map<String, dynamic>>>()
                            .order('id');

                    final response = query;

                    debugPrint('response: $response');

                    setState(
                      () {
                        data = response.length;
                      },
                    );
                    debugPrint('Customers data length: $data');
                 */
                },
                text: 'Press',
              ),
            )
          ],
        ),
      ),
    );
  }
}
