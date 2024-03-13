import 'package:communitybank/utils/colors/colors.util.dart';
import 'package:communitybank/views/pages/home/dashboard/dashboard.page.dart';
import 'package:communitybank/views/widgets/dashboard/customers_products_data_view/customers_products/customers_products.widget.dart';
import 'package:communitybank/views/widgets/globals/text/text.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DashboardProductsDataView extends ConsumerStatefulWidget {
  const DashboardProductsDataView({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _DashboardProductsDataViewState();
}

class _DashboardProductsDataViewState
    extends ConsumerState<DashboardProductsDataView> {
  @override
  Widget build(BuildContext context) {
    final productsTotal = ref.watch(productsTotalProvider);
    final customersTotal = ref.watch(customersTotalProvider);
    final customersAccountsTotal = ref.watch(customersAccountsTotalProvider);
    return Container(
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
                  text: 'Produits',
                  fontSize: 14.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                child: CBText(
                  text: productsTotal.when(
                    data: (data) {
                      return data.isEmpty
                          ? '0'
                          : data.first.totalNumber.ceil().toString();
                    },
                    error: (error, stackTrace) => '0',
                    loading: () => '0',
                  ),
                  fontSize: 15.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                child: const CBText(
                  text: 'Comptes Clients',
                  fontSize: 14.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                child: CBText(
                  text: customersAccountsTotal.when(
                    data: (data) {
                      return data.isEmpty
                          ? '0'
                          : data.first.totalNumber.ceil().toString();
                    },
                    error: (error, stackTrace) => '0',
                    loading: () => '0',
                  ),
                  fontSize: 15.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                child: const CBText(
                  text: 'Clients',
                  fontSize: 14.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                child: CBText(
                  text: customersTotal.when(
                    data: (data) {
                      return data.isEmpty
                          ? '0'
                          : data.first.totalNumber.ceil().toString();
                    },
                    error: (error, stackTrace) => '0',
                    loading: () => '0',
                  ),
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
            //  color: CBColors.primaryColor.withOpacity(.7),
            margin: const EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 30.0,
            ),
            height: 1100.0,
            //  width: MediaQuery.of(context).size.width * .8,
            child: const CustomersProductsDataView(),
          ),
        ],
      ),
    );
  }
}
