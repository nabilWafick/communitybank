import 'package:communitybank/views/widgets/globals/global.widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CashOperationsCard extends ConsumerWidget {
  const CashOperationsCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      height: 640.0,
      child: Center(
        child: Row(
          children: [
            const CBText(
              text: 'Cash Operations',
            ),
            SizedBox(
              width: 100.0,
              child: CBTextFormField(
                hintText: 'hintText',
                initialValue: 5.toString(),
                isMultilineTextForm: false,
                obscureText: false,
                enabled: false,
                textInputType: TextInputType.text,
                validator: (val, ref) {
                  return null;
                },
                onChanged: (val, ref) {},
              ),
            )
          ],
        ),
      ),
    );
  }
}
