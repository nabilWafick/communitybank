import 'package:communitybank/views/widgets/registration/registration.widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RegistrationPage extends ConsumerWidget {
  const RegistrationPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      body: Row(
        children: [
          FormSide(),
          LogoSide(),
        ],
      ),
    );
  }
}
