import 'package:communitybank/utils/colors/colors.util.dart';
import 'package:communitybank/views/widgets/globals/text/text.widget.dart';
import 'package:communitybank/views/widgets/home/sidebar/sidebar.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MainAppbar extends ConsumerStatefulWidget {
  const MainAppbar({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MainAppbarState();
}

class _MainAppbarState extends ConsumerState<MainAppbar> {
  final pages = [
    'Dashbaord',
    'Clients',
    'Produits',
    'Types',
    'Cartes',
    'Inventaires',
    'Stock',
    'Collaborateurs',
    'Paramètre',
    'Déconnexion'
  ];

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final currentPage = ref.watch(selectedSidebarOptionProvider);
    return Container(
      height: screenSize.height / 10,
      padding: const EdgeInsets.symmetric(vertical: 25.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CBText(
            text: pages[currentPage],
            //   color: CBColors.sidebarTextColor,
            fontSize: 25.0,
            fontWeight: FontWeight.w600,
          ),
          const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.notifications,
                size: 25.0,
                color: CBColors.tertiaryColor,
              ),
              SizedBox(
                width: 30.0,
              ),
              CBText(
                text: 'TEST User',
                fontSize: 15.0,
                fontWeight: FontWeight.w600,
              ),
              /*   SizedBox(
                width: 20.0,
              ),
              Card(
                color: CBColors.primaryColor,
                elevation: 5.0,
                child: SizedBox(
                  height: 25.0,
                  width: 25.0,
                ),
              )*/
            ],
          )
        ],
      ),
    );
  }
}
