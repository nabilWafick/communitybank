import 'package:communitybank/controllers/forms/validators/customer_card/customer_card.validator.dart';
import 'package:communitybank/functions/common/common.function.dart';
import 'package:communitybank/utils/colors/colors.util.dart';
import 'package:communitybank/views/widgets/forms/adding/settlement/settlement_adding_form.widget.dart';
import 'package:communitybank/views/widgets/globals/global.widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class CashOperationsCustomerCardInfos extends ConsumerStatefulWidget {
  final double width;
  const CashOperationsCustomerCardInfos({super.key, required this.width});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CashOperationsCustomerCardInfosState();
}

class _CashOperationsCustomerCardInfosState
    extends ConsumerState<CashOperationsCustomerCardInfos> {
  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 100), () {
      ref.read(isCustomerCardSatisfiedProvider.notifier).state = false;

      ref.read(isCustomerCardRepaidProvider.notifier).state = false;

      ref.read(customerCardSatisfactionDateProvider.notifier).state = null;

      ref.read(customerCardRepaymentDateProvider.notifier).state = null;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final isSatisfied = ref.watch(isCustomerCardSatisfiedProvider);
    final isRepaid = ref.watch(isCustomerCardRepaidProvider);
    return Container(
      padding: const EdgeInsets.all(15.0),
      width: widget.width,
      height: 440.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          15.0,
        ),
        border: Border.all(
          color: CBColors.sidebarTextColor.withOpacity(.5),
          width: 1.5,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const CBText(
                text: 'Cartes: ',
                fontSize: 14.0,
                fontWeight: FontWeight.w600,
              ),
              SizedBox(
                width: widget.width * .88,
                child: const SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      CustomerCardCard(),
                      CustomerCardCard(),
                      CustomerCardCard(),
                      CustomerCardCard(),
                      CustomerCardCard(),
                      CustomerCardCard(),
                      CustomerCardCard(),
                      CustomerCardCard(),
                      CustomerCardCard(),
                      CustomerCardCard(),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            /*  margin: const EdgeInsetsDirectional.symmetric(
              vertical: 25.0,
            ),*/
            width: widget.width,
            //  color: CBColors.sidebarTextColor,
            child: StaggeredGrid.count(
              mainAxisSpacing: 7.0,
              crossAxisCount: 3,
              children: const [
                CustomerCardInfos(
                  label: 'Type',
                  value: 'Type AAAA',
                ),
                CustomerCardInfos(
                  label: 'Mise',
                  value: '500',
                ),
                CustomerCardInfos(
                  label: 'Total Mise',
                  value: '372',
                ),
                CustomerCardInfos(
                  label: 'Mises Effectuées',
                  value: '300',
                ),
                CustomerCardInfos(
                  label: 'Montant Payé',
                  value: '150000',
                ),
                CustomerCardInfos(
                  label: 'Mises Restantes',
                  value: '300',
                ),
                SizedBox(),
                CustomerCardInfos(
                  label: 'Reste à Payer',
                  value: '36000',
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 250.0,
                    child: SwitchListTile(
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: .0,
                        vertical: 5.0,
                      ),
                      splashRadius: .0,
                      value: isRepaid,
                      title: const CBText(
                        text: 'Remboursé',
                        fontSize: 12.0,
                        fontWeight: FontWeight.w500,
                      ),
                      onChanged: (value) {
                        isSatisfied == false
                            ? ref
                                .read(isCustomerCardRepaidProvider.notifier)
                                .state = value
                            : () {};
                      },
                    ),
                  ),
                  const CustomerCardInfosDate(
                    label: 'Date de Remboursement',
                    value: '',
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 250.0,
                    child: SwitchListTile(
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: .0,
                        vertical: 5.0,
                      ),
                      value: isSatisfied,
                      title: const CBText(
                        text: 'Satisfait',
                        fontSize: 12.0,
                        fontWeight: FontWeight.w500,
                      ),
                      onChanged: (value) {
                        isRepaid == false
                            ? ref
                                .read(isCustomerCardSatisfiedProvider.notifier)
                                .state = value
                            : () {};
                      },
                    ),
                  ),
                  const CustomerCardInfosDate(
                    label: 'Date de Satisfaction',
                    value: '',
                  ),
                ],
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CBIconButton(
                icon: Icons.book,
                text: 'Situation du client',
                onTap: () {},
              ),
              CBIconButton(
                icon: Icons.add_circle,
                text: 'Ajouter un règlement',
                onTap: () {
                  FunctionsController.showAlertDialog(
                    context: context,
                    alertDialog: const SettlementAddingForm(),
                  );
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}

class CustomerCardCard extends ConsumerWidget {
//  final String cutomerCardName;
  const CustomerCardCard({
    super.key,
//    required this.cutomerCardName,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final selectedSidebarSubOption =
    //     ref.watch(selectedSidebarSubOptionProvider);
    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: 10.0,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
        side: const BorderSide(
          color: CBColors.primaryColor,
        ),
      ),
      elevation: 7.0,
      color: CBColors.primaryColor,
      /* selectedSidebarSubOption == sidebarSubOptionData
          ? Colors.white
          : CBColors.primaryColor,
          */
      child: InkWell(
        onTap: () {
          //   ref.read(selectedSidebarSubOptionProvider.notifier).state =
          //       sidebarSubOptionData;
        },
        child: const Padding(
          padding: EdgeInsets.symmetric(
            vertical: 10.0,
            horizontal: 15.0,
          ),
          child: Row(
            children: [
              CBText(
                text: 'C0001',
                // sidebarSubOptionData.name,
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: Colors.white,
                /* selectedSidebarSubOption == sidebarSubOptionData
                    ? CBColors.primaryColor
                    : Colors.white,
                    */
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CustomerCardInfos extends ConsumerWidget {
  final String label;
  final String value;
  const CustomerCardInfos({
    super.key,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      // width: 240.0,
      child: Row(
        children: [
          CBText(
            text: '$label: ',
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
          CBText(
            text: value,
            fontSize: 14,
            fontWeight: FontWeight.w600,
            //  color: CBColors.tertiaryColor,
          )
        ],
      ),
    );
  }
}

class CustomerCardInfosDate extends ConsumerWidget {
  final String label;
  final String value;
  const CustomerCardInfosDate({
    super.key,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      // width: 240.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CBText(
            text: label,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
          CBText(
            text: value,
            fontSize: 14,
            fontWeight: FontWeight.w600,
            //  color: CBColors.tertiaryColor,
          )
        ],
      ),
    );
  }
}

class CBIconButton extends ConsumerWidget {
  final IconData icon;
  final String text;
  final Function() onTap;

  const CBIconButton({
    super.key,
    required this.icon,
    required this.text,
    required this.onTap,
  });
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.symmetric(
          //   vertical: 10.0,
          ),
      child: InkWell(
        onTap: onTap,
        child: Card(
          elevation: 5.0,
          color: CBColors.primaryColor,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 10.0,
              horizontal: 15.0,
            ),
            child: Row(mainAxisSize: MainAxisSize.min, children: [
              Icon(
                icon,
                color: CBColors.backgroundColor,
              ),
              const SizedBox(
                width: 15.0,
              ),
              CBText(
                text: text,
                fontSize: 12.0,
                fontWeight: FontWeight.w500,
                color: CBColors.backgroundColor,
              )
            ]),
          ),
        ),
      ),
    );
  }
}

class CBAddSettlementButton extends ConsumerWidget {
  final Function() onTap;
  const CBAddSettlementButton({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.symmetric(
          //   vertical: 10.0,
          ),
      child: InkWell(
        onTap: onTap,
        child: const Card(
          elevation: 5.0,
          color: CBColors.primaryColor,
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: 10.0,
              horizontal: 15.0,
            ),
            child: Row(mainAxisSize: MainAxisSize.min, children: [
              Icon(
                Icons.add_circle,
                color: CBColors.backgroundColor,
              ),
              SizedBox(
                width: 15.0,
              ),
              CBText(
                text: 'Ajouter un règlement',
                fontSize: 12.0,
                fontWeight: FontWeight.w500,
                color: CBColors.backgroundColor,
              )
            ]),
          ),
        ),
      ),
    );
  }
}
