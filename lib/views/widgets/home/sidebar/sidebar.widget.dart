import 'package:communitybank/utils/utils.dart';
import 'package:communitybank/views/widgets/globals/global.widgets.dart';
import 'package:communitybank/views/widgets/home/sidebar/sidebar_option/sidebar_option.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final selectedSidebarOptionProvider = StateProvider<int>((ref) {
  return 0;
});

class Sidebar extends ConsumerWidget {
  const Sidebar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenSize = MediaQuery.of(context).size;
    return Container(
      width: screenSize.width / 7,
      color: CBColors.secondaryColor,
      child: Column(
        //  crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: screenSize.height / 6,
            width: double.infinity,
            child: const CBLogo(
              fontSize: 15.0,
              bankColor: CBColors.backgroundColor,
            ),
          ),
          SizedBox(
            height: screenSize.height * 5 / 6,
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SidebarOption(
                      index: 0,
                      icon: Icons.menu,
                      name: 'Dashboard',
                    ),
                    SidebarOption(
                      index: 1,
                      icon: Icons.group,
                      name: 'Clients',
                    ),
                    SidebarOption(
                      index: 2,
                      icon: Icons.card_giftcard,
                      name: 'Produits',
                    ),
                    SidebarOption(
                      index: 3,
                      icon: Icons.card_giftcard,
                      name: 'Types',
                    ),
                    SidebarOption(
                      index: 4,
                      icon: Icons.credit_card,
                      name: 'Cartes',
                    ),
                    SidebarOption(
                      index: 5,
                      icon: Icons.inventory,
                      name: 'Inventaire',
                    ),
                    SidebarOption(
                      index: 6,
                      icon: Icons.store,
                      name: 'Stock',
                    ),
                    SidebarOption(
                      index: 7,
                      icon: Icons.supervised_user_circle,
                      name: 'Collaborateurs',
                    ),
                    SidebarOption(
                      index: 8,
                      icon: Icons.settings,
                      name: 'Paramètre',
                    ),
                  ],
                ),
                SidebarOption(
                  index: 9,
                  icon: Icons.logout,
                  name: 'Déconnexion',
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
