import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CBSearchInput extends ConsumerStatefulWidget {
  final String hintText;
  final void Function(String, WidgetRef) onChanged;
  const CBSearchInput({
    super.key,
    required this.hintText,
    required this.onChanged,
  });
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CBSearchInputState();
}

class _CBSearchInputState extends ConsumerState<CBSearchInput> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 350.0,
      child: Form(
        child: TextFormField(
          onChanged: (newValue) {
            widget.onChanged(newValue, ref);
          },
          decoration: InputDecoration(
            hintText: widget.hintText,
            prefixIcon: const Icon(
              Icons.search,
            ),
          ),
        ),
      ),
    );
  }
}
