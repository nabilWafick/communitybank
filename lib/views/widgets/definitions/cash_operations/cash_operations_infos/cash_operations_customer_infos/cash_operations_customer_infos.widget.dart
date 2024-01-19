import 'package:communitybank/utils/colors/colors.util.dart';
import 'package:communitybank/views/widgets/globals/global.widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class CashOperationsCustomerInfos extends ConsumerWidget {
  final double width;
  const CashOperationsCustomerInfos({
    super.key,
    required this.width,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.all(
        15.0,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          15.0,
        ),
        border: Border.all(
          color: CBColors.sidebarTextColor.withOpacity(.5),
          width: 1.5,
        ),
      ),
      height: 440.0,
      width: width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              UserInfos(),
              UserInfos(),
            ],
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 15.0),
            width: width,
            child: StaggeredGrid.count(
              crossAxisCount: 2,
              mainAxisSpacing: 7.0,
              // crossAxisSpacing: 2.0,
              children: const [
                OtherInfos(
                  label: 'Profession',
                  value: 'Profession',
                ),
                OtherInfos(
                  label: 'CIP',
                  value: '1234567890',
                ),
                OtherInfos(
                  label: 'Categorie',
                  value: 'Categorie',
                ),
                OtherInfos(
                  label: 'Activité Économique',
                  value: 'Activity',
                ),
                OtherInfos(
                  label: 'Statut Personnel',
                  value: 'Personnel',
                ),
                OtherInfos(
                  label: 'Localité',
                  value: 'Locality',
                ),
              ],
            ),
          ),
          Container(
            height: 80.0,
            width: 80.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(
                color: CBColors.sidebarTextColor.withOpacity(.5),
                width: 1.5,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class UserInfos extends ConsumerWidget {
  const UserInfos({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        Container(
          height: 80.0,
          width: 80.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              50.0,
            ),
            border: Border.all(
              color: CBColors.sidebarTextColor.withOpacity(.5),
              width: 1.5,
            ),
          ),
        ),
        const SizedBox(
          width: 20.0,
        ),
        const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CBText(
              text: 'Person Test',
              fontWeight: FontWeight.w500,
              fontSize: 15.0,
            ),
            CBText(
              text: '+22994444444',
              fontSize: 12.0,
            ),
          ],
        ),
      ],
    );
  }
}

class OtherInfos extends ConsumerWidget {
  final String label;
  final String value;
  const OtherInfos({
    super.key,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      //  width: 240.0,
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
          )
        ],
      ),
    );
  }
}
