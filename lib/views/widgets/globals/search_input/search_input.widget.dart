import 'package:communitybank/utils/colors/colors.util.dart';
import 'package:communitybank/views/widgets/definitions/products/products_sort_options/products_sort_options.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CBSearchInput extends ConsumerStatefulWidget {
  final String hintText;
  final String familyName;
  final StateProvider<String> searchProvider;
  final double? width;
  const CBSearchInput({
    super.key,
    required this.familyName,
    required this.hintText,
    required this.searchProvider,
    this.width,
  });
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CBSearchInputState();
}

class _CBSearchInputState extends ConsumerState<CBSearchInput> {
  TextEditingController textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    textEditingController.text = ref.watch(searchProvider(widget.familyName));
    return SizedBox(
      width: widget.width ?? 350.0,
      child: Form(
        child: TextFormField(
          //  initialValue: initialValue != '' ? initialValue : null,
          controller: textEditingController,
          onChanged: (value) {
            ref.read(widget.searchProvider.notifier).state = value;
          },
          style: const TextStyle(
            fontSize: 12.0,
          ),
          decoration: InputDecoration(
            // contentPadding: const EdgeInsets.symmetric(vertical: 10.0),
            hintStyle: const TextStyle(
              fontSize: 12.0,
            ),
            hintText: widget.hintText,
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide.none,
            ),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide.none,
            ),
            prefixIcon: const Icon(
              Icons.search,
              color: CBColors.primaryColor,
            ),
            suffixIcon: IconButton(
              onPressed: () {
                ref.read(widget.searchProvider.notifier).state = '';
                textEditingController.text = '';
              },
              icon: const Icon(
                Icons.close,
                color: CBColors.primaryColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
