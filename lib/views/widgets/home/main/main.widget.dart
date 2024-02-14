import 'package:communitybank/views/widgets/home/main/main_app_bar/main_app_bar.dart';
import 'package:communitybank/views/widgets/home/main/main_body/main_body.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Main extends ConsumerStatefulWidget {
  const Main({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MainState();
}

class _MainState extends ConsumerState<Main> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 25.0,
      ),
      width: MediaQuery.of(context).size.width * 7 / 8,
      child: const Column(
        children: [
          MainAppbar(),
          MainBody(),
        ],
      ),
    );
  }
}
