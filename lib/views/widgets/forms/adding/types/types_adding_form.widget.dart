import 'package:communitybank/utils/utils.dart';
import 'package:communitybank/views/widgets/globals/global.widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'types_product_selection_adding_form.widget.dart';

class TypesAddingForm extends ConsumerWidget {
  const TypesAddingForm({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const formCardWidth = 500.0;
    return AlertDialog(
      contentPadding: const EdgeInsetsDirectional.symmetric(
        vertical: 20.0,
        horizontal: 10.0,
      ),
      content: Container(
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
                        content: TypeProductSelection(),
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
      ),
    );
  }
}
