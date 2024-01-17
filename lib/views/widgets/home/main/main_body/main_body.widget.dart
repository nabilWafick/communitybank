import 'package:communitybank/views/pages/home/dashboard/dashboard.page.dart';
import 'package:communitybank/views/pages/home/definitions/agents/agents.page.dart';
import 'package:communitybank/views/pages/home/definitions/customers_cards/customers_cards.page.dart';
import 'package:communitybank/views/pages/home/definitions/cash_operations/cash_operations.page.dart';
import 'package:communitybank/views/pages/home/definitions/collectors/collectors.page.dart';
import 'package:communitybank/views/pages/home/definitions/customers/customers.page.dart';
import 'package:communitybank/views/pages/home/definitions/customers_accounts/customers_accounts.page.dart';
import 'package:communitybank/views/pages/home/definitions/customers_categories/customers_categories.page.dart';
import 'package:communitybank/views/pages/home/definitions/economical_activities/economical_activities.page.dart';
import 'package:communitybank/views/pages/home/definitions/localities/localities.page.dart';
import 'package:communitybank/views/pages/home/definitions/personal_status/personal_status.page.dart';
import 'package:communitybank/views/pages/home/definitions/products/products.page.dart';
import 'package:communitybank/views/pages/home/definitions/settlements/settlements.page.dart';
import 'package:communitybank/views/pages/home/definitions/types/types.page.dart';
import 'package:communitybank/views/pages/home/entries/entries.page.dart';
import 'package:communitybank/views/pages/home/files/files.page.dart';
import 'package:communitybank/views/pages/home/logout/logout.page.dart';
import 'package:communitybank/views/widgets/home/home.widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MainBody extends ConsumerStatefulWidget {
  const MainBody({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MainBodyState();
}

class _MainBodyState extends ConsumerState<MainBody> {
  final pages = const [
    DashboardPage(),
    ProductsPage(),
    TypesPage(),
    CollectorsPage(),
    CustomersCategoriesPage(),
    EconomicalActivitiesPage(),
    PersonnalStatusPage(),
    LocalitiesPage(),
    CustomersPage(),
    AgentsPage(),
    CustomersAccountsPage(),
    CardsPage(),
    SettlementsPage(),
    CashOperationsPage(),
    EntriesPage(),
    FilesPage(),
    LogoutPage(),
  ];
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final sidebarOptions = ref.watch(sidebarOptionsProvider);
    final selectedSidebarOption = ref.watch(selectedSidebarOptionProvider);
    final selectedSidebarSubOption =
        ref.watch(selectedSidebarSubOptionProvider);

    return SizedBox(
      // padding: const EdgeInsets.only(bottom: 200.0),

      height: screenSize.height * 6 / 7,
      child:
          // const LocalitiesPage(),
          // const PersonnalStatusPage(),
          // const EconomicalActivitiesPage(),
          // const CustomersCategoriesPage(),
          // const CollectorsPage(),
          // const CustomersPage(),
          // const ProductsPage(),
          // const TypesPage(),

          PageView(
        scrollDirection: Axis.vertical,
        physics: const NeverScrollableScrollPhysics(),
        onPageChanged: (index) {
          //  debugPrint('onPageChanged Index: $index');

          // Find the sidebarOption which contains the sidebarSubOption having index equal to pageView index
          final selectedOption = sidebarOptions.firstWhere(
            (option) =>
                option.subOptions.any((subOption) => subOption.index == index),
            orElse: () => selectedSidebarOption,
          );

          // Update sidebarOption provider
          ref.read(selectedSidebarOptionProvider.notifier).state =
              selectedOption;

          // Find sidebarSubOption having index equal to pageView index
          final selectedSubOption = selectedOption.subOptions.firstWhere(
            (subOption) => subOption.index == index,
            orElse: () => selectedSidebarSubOption,
          );

          // Update the sidebarSubOption provider
          ref.read(selectedSidebarSubOptionProvider.notifier).state =
              selectedSubOption;
        },
        children: pages
            .map(
              (page) => pages[selectedSidebarSubOption.index],
            )
            .toList(),
      ),
    );
  }
}
