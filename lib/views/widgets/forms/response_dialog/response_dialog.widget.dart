import 'package:communitybank/models/response_dialog/response_dialog.model.dart';
import 'package:communitybank/models/service_response/service_response.model.dart';
import 'package:communitybank/utils/colors/colors.util.dart';
import 'package:communitybank/views/widgets/globals/text/text.widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

class ResponseDialog extends ConsumerWidget {
  const ResponseDialog({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final responseDialogData = ref.watch(responseDialogProvider);
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
                      child: Row(
                        children: [
                          Icon(
                            Icons.info,
                            color: responseDialogData.serviceResponse ==
                                    ServiceResponse.success
                                ? CBColors.primaryColor
                                : Colors.red,
                            size: 30.0,
                          ),
                          const SizedBox(
                            width: 25.0,
                          ),
                          CBText(
                            text: responseDialogData.response,
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
