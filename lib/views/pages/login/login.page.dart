import 'package:communitybank/views/widgets/login/login.widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginPage extends ConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      body: Row(
        children: [
          LogoSide(),
          FormSide(),
        ],
      ),
    );
  }
}
