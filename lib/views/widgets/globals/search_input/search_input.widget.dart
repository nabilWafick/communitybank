import 'package:communitybank/utils/colors/colors.util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CBSearchInput extends ConsumerStatefulWidget {
  final String hintText;
  final StateProvider searchProvider;
  const CBSearchInput({
    super.key,
    required this.hintText,
    required this.searchProvider,
  });
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CBSearchInputState();
}

class _CBSearchInputState extends ConsumerState<CBSearchInput> {
  TextEditingController textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 350.0,
      child: Form(
        child: TextFormField(
          controller: textEditingController,
          onChanged: (value) {
            ref.read(widget.searchProvider.notifier).state = value;
          },
          decoration: InputDecoration(
              hintText: widget.hintText,
              prefixIcon: const Icon(
                Icons.search,
                color: CBColors.primaryColor,
              ),
              suffixIcon: IconButton(
                onPressed: () {
                  ref.read(widget.searchProvider.notifier).state = '';
                  textEditingController.clear();
                },
                icon: const Icon(
                  Icons.close,
                  color: CBColors.primaryColor,
                ),
              )),
        ),
      ),
    );
  }
}
