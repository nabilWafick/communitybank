import 'package:communitybank/views/widgets/globals/text/text.widget.dart';
import 'package:communitybank/views/widgets/home/sidebar/sidebar.widget.dart';
import 'package:communitybank/views/widgets/home/sidebar/sidebar_suboption/sidebar_suboption.widget.dart';
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
    'Définitions',
    'Saisie',
    'Fichier',
    'Déconnexion',
  ];

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final currentPage = ref.watch(selectedSidebarOptionProvider);
    return Container(
      height: screenSize.height / 7,
      padding: const EdgeInsets.only(top: 25.0),
      //  color: Colors.grey,
      child: Column(
        children: [
          Row(
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
                  /*  Icon(
                    Icons.notifications,
                    size: 25.0,
                    color: CBColors.tertiaryColor,
                  ),
                  SizedBox(
                    width: 30.0,
                  ),*/
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
          const SizedBox(
            height: 15.0,
          ),
          const SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                /* SidebarSubOption(
                  index: 25,
                  icon: Icons.account_balance,
                  name: 'Agences',
                ),*/
                SidebarSubOption(
                  index: 25,
                  icon: Icons.square_outlined,
                  name: 'Produits',
                ),
                SidebarSubOption(
                  index: 25,
                  icon: Icons.cases_rounded,
                  name: 'Types',
                ),
                SidebarSubOption(
                  index: 25,
                  icon: Icons.supervised_user_circle,
                  name: 'Chargé de comptes',
                ),
                SidebarSubOption(
                  index: 25,
                  icon: Icons.group,
                  name: 'Catégorie de clients',
                ),
                SidebarSubOption(
                  index: 25,
                  icon: Icons.work,
                  name: 'Activités économiques',
                ),
                SidebarSubOption(
                  index: 25,
                  icon: Icons.account_box,
                  name: 'Statut Personnel',
                ),
                SidebarSubOption(
                  index: 25,
                  icon: Icons.location_city,
                  name: 'Localités',
                ),
                SidebarSubOption(
                  index: 25,
                  icon: Icons.account_circle,
                  name: 'Clients',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
