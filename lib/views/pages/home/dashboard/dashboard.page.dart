import 'package:communitybank/utils/utils.dart';
import 'package:communitybank/views/widgets/dashboard/charts/line_chart2/line_chart2.widget.dart';
import 'package:communitybank/views/widgets/dashboard/dashboard_card/dashboard_card.widget.dart';
import 'package:communitybank/views/widgets/globals/text/text.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DashboardPage extends ConsumerWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        //   crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // *** GLOBAL VIEW ***
          Container(
            margin: const EdgeInsets.symmetric(
              vertical: 30.0,
            ),
            child: Column(
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  child: const CBText(
                    text: 'Vue d\'ensemble',
                    fontSize: 14.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Container(
                  height: .5,
                  width: double.infinity,
                  color: CBColors.sidebarTextColor,
                  margin: const EdgeInsets.only(
                    top: 10.0,
                    bottom: 17.0,
                  ),
                ),
                const Wrap(
                  runSpacing: 10.0,
                  spacing: 20.0,
                  runAlignment: WrapAlignment.center,
                  alignment: WrapAlignment.center,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    DashboardCard(
                      label: 'Collectes',
                      value: 1500000,
                      ceil: true,
                    ),
                    DashboardCard(
                      label: 'Règlements',
                      value: 4500,
                      ceil: true,
                    ),
                    DashboardCard(
                      label: 'Clients',
                      value: 1000,
                      ceil: true,
                    ),
                    DashboardCard(
                      label: 'Comptes Clients',
                      value: 1200,
                      ceil: true,
                    ),
                    DashboardCard(
                      label: 'Cartes',
                      value: 1500,
                      ceil: true,
                    ),
                    DashboardCard(
                      label: 'Agents',
                      value: 10,
                      ceil: true,
                    ),
                    DashboardCard(
                      label: 'Collecteurs',
                      value: 10,
                      ceil: true,
                    ),
                    DashboardCard(
                      label: 'Types',
                      value: 100,
                      ceil: true,
                    ),
                    DashboardCard(
                      label: 'Produits',
                      value: 100,
                      ceil: true,
                    ),
                  ],
                )
              ],
            ),
          ),
          // *** COLLECTION ***
          Container(
            margin: const EdgeInsets.symmetric(
              vertical: 20.0,
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      child: const CBText(
                        text: 'Collectes',
                        fontSize: 14.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: const CBText(
                        text: '1750925',
                        fontSize: 15.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                Container(
                  height: .5,
                  width: double.infinity,
                  color: CBColors.sidebarTextColor,
                  margin: const EdgeInsets.only(
                    top: 10.0,
                    bottom: 17.0,
                  ),
                ),
                Container(
                  color: CBColors.primaryColor.withOpacity(.7),
                  margin: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                  ),
                  height: 500.0,

                  //  width: MediaQuery.of(context).size.width * .8,
                  child: const DashboardLineChart2(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
