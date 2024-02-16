import 'package:communitybank/models/response_dialog/response_dialog.model.dart';
import 'package:communitybank/models/service_response/service_response.model.dart';
import 'package:communitybank/utils/colors/colors.util.dart';
import 'package:communitybank/views/widgets/globals/global.widgets.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ResponseDialog extends StatefulHookConsumerWidget {
  const ResponseDialog({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ResponseDialogState();
}

class _ResponseDialogState extends ConsumerState<ResponseDialog> {
  @override
  void initState() {
    final responseDialogData = ref.watch(responseDialogProvider);
    if (responseDialogData.serviceResponse == ServiceResponse.success) {
      Future.delayed(const Duration(milliseconds: 1000), () {
        if (mounted) {
          Navigator.of(context).pop();
        }
      });
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final responseDialogData = ref.watch(responseDialogProvider);
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
                  child: Row(
                    children: [
                      Icon(
                        Icons.info,
                        color: responseDialogData.serviceResponse ==
                                ServiceResponse.success
                            ? CBColors.primaryColor
                            : Colors.red[700],
                        size: 30.0,
                      ),
                      const SizedBox(
                        width: 25.0,
                      ),
                      Flexible(
                        child: CBText(
                          text: responseDialogData.response,
                          fontSize: 15.0,
                          fontWeight: FontWeight.w500,
                          textOverflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(top: 15.0),
              width: 170.0,
              child: CBElevatedButton(
                text: 'Fermer',
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
