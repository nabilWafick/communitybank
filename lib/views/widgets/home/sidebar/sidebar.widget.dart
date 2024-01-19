import 'package:communitybank/models/views/sidear_suboption/sidebar_suboption.model.dart';
import 'package:communitybank/models/views/sidebar_option/sidebar_option.model.dart';
import 'package:communitybank/utils/utils.dart';
import 'package:communitybank/views/widgets/globals/global.widgets.dart';
import 'package:communitybank/views/widgets/home/sidebar/sidebar_option/sidebar_option.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final sidebarOptionsProvider = Provider<List<SidebarOptionModel>>((ref) {
  return [
    SidebarOptionModel(
      icon: Icons.stacked_bar_chart,
      name: 'Dashboard',
      subOptions: [
        SidebarSubOptionModel(
          index: 0,
          icon: Icons.stacked_bar_chart,
          name: 'Dashboard',
        ),
      ],
      showSubOptions: false,
    ),
    SidebarOptionModel(
      icon: Icons.dataset,
      name: 'Définitions',
      subOptions: [
        /* SidebarSubOptionModel(
                  index: 25,
                  icon: Icons.account_balance,
                  name: 'Agences',
                ),*/
        SidebarSubOptionModel(
          index: 1,
          icon: Icons.inventory,
          name: 'Produits',
        ),
        SidebarSubOptionModel(
          index: 2,
          icon: Icons.cases_rounded,
          name: 'Types',
        ),
        SidebarSubOptionModel(
          index: 3,
          icon: Icons.supervised_user_circle,
          name: 'Chargé de comptes',
        ),
        SidebarSubOptionModel(
          index: 4,
          icon: Icons.group,
          name: 'Catégorie de clients',
        ),
        SidebarSubOptionModel(
          index: 5,
          icon: Icons.work,
          name: 'Activités économiques',
        ),
        SidebarSubOptionModel(
          index: 6,
          icon: Icons.person,
          name: 'Statuts Personnels',
        ),
        SidebarSubOptionModel(
          index: 7,
          icon: Icons.location_city,
          name: 'Localités',
        ),
        SidebarSubOptionModel(
          index: 8,
          icon: Icons.account_circle,
          name: 'Clients',
        ),
        SidebarSubOptionModel(
          index: 9,
          icon: Icons.admin_panel_settings,
          name: 'Agents',
        ),
        SidebarSubOptionModel(
          index: 10,
          icon: Icons.account_box,
          name: 'Comptes Clients',
        ),
        SidebarSubOptionModel(
          index: 11,
          icon: Icons.payment,
          name: 'Cartes',
        ),
        SidebarSubOptionModel(
          index: 12,
          icon: Icons.money,
          name: 'Règlements',
        ),
        SidebarSubOptionModel(
          index: 13,
          icon: Icons.account_balance,
          name: 'Opérations caisse',
        ),
      ],
      showSubOptions: true,
    ),
    SidebarOptionModel(
      icon: Icons.keyboard,
      name: 'Saisies',
      subOptions: [
        SidebarSubOptionModel(
          index: 9,
          icon: Icons.keyboard,
          name: 'Saisie',
        ),
      ],
      showSubOptions: true,
    ),
    SidebarOptionModel(
      icon: Icons.file_present,
      name: 'Fichier',
      subOptions: [
        SidebarSubOptionModel(
          index: 10,
          icon: Icons.file_present,
          name: 'Fichier',
        )
      ],
      showSubOptions: true,
    ),
    /* SidebarOptionModel(
      icon: Icons.logout,
      name: 'Déconnexion',
      subOptions: [
        SidebarSubOptionModel(
          index: 11,
          icon: Icons.logout,
          name: 'Déconnexion',
        )
      ],
      showSubOptions: true,
    ),*/
  ];
});

final selectedSidebarOptionProvider = StateProvider<SidebarOptionModel>((ref) {
  final sidebarOption = ref.watch(sidebarOptionsProvider)[0];
  return sidebarOption;
});

final selectedSidebarSubOptionProvider =
    StateProvider<SidebarSubOptionModel>((ref) {
  final sidebarSubOption = ref.watch(sidebarOptionsProvider)[0].subOptions[0];
  return sidebarSubOption;
});

class Sidebar extends ConsumerStatefulWidget {
  const Sidebar({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SidebarState();
}

class _SidebarState extends ConsumerState<Sidebar> {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final sidebarOptions = ref.watch(sidebarOptionsProvider);
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: sidebarOptions
                      .map(
                        (sidebarOption) =>
                            SidebarOption(sidebarOptionData: sidebarOption),
                      )
                      .toList(),
                ),
                SidebarOption(
                  sidebarOptionData: SidebarOptionModel(
                    icon: Icons.logout,
                    name: 'Déconnexion',
                    subOptions: [
                      SidebarSubOptionModel(
                          index: 11, icon: Icons.logout, name: 'Déconnexion')
                    ],
                    showSubOptions: true,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
