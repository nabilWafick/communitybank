import 'package:communitybank/utils/colors/colors.util.dart';
import 'package:communitybank/views/widgets/globals/global.widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductCard extends ConsumerWidget {
  const ProductCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      margin: const EdgeInsetsDirectional.symmetric(
          vertical: 14.5, horizontal: 10.0),
      elevation: 7.0,
      color: Colors.white,
      child: SizedBox(
        height: 400.0,
        width: 290,
        child: Column(
          children: [
            const Card(
              elevation: .0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(14.5),
                  topRight: Radius.circular(14.5),
                ),
              ),
              color: CBColors.sidebarTextColor,
              child: SizedBox(
                height: 200.0,
                width: double.maxFinite,
                child: Icon(
                  Icons.image,
                  size: 100.0,
                  color:
                      // Colors.white,
                      CBColors.backgroundColor,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 25.0,
                vertical: 14.5,
              ),
              height: 200.0,
              width: double.maxFinite,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 5.0),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CBText(
                              text: 'ID',
                              fontSize: 14.5,
                              fontWeight: FontWeight.w500,
                            ),
                            CBText(
                              text: 'P-1',
                              fontSize: 14.5,
                              fontWeight: FontWeight.w500,
                            )
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 5.0),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CBText(
                              text: 'Nom',
                              fontSize: 14.5,
                              fontWeight: FontWeight.w500,
                            ),
                            CBText(
                              text: 'Produit 1',
                              fontSize: 14.5,
                              fontWeight: FontWeight.w500,
                            )
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 5.0),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CBText(
                              text: 'Prix',
                              fontSize: 14.5,
                              fontWeight: FontWeight.w500,
                            ),
                            CBText(
                              text: '1500f',
                              fontSize: 14.5,
                              fontWeight: FontWeight.w500,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 18.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CBEditButton(
                          onTap: () {},
                        ),
                        CBDeleteButton(
                          onTap: () {},
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
