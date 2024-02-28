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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CBText(
              text: 'Customers data length: $data',
            ),
            SizedBox(
              width: 500,
              child: CBElevatedButton(
                onPressed: () async {
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
