import 'package:communitybank/models/data/product/product.model.dart';
import 'package:communitybank/utils/colors/colors.util.dart';
import 'package:communitybank/views/widgets/globals/global.widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class MultipleImageShower extends ConsumerWidget {
  final List<Product> products;
  const MultipleImageShower({
    super.key,
    required this.products,
  });
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const formCardWidth = 500.0;
    return AlertDialog(
      contentPadding: const EdgeInsetsDirectional.symmetric(
        vertical: 20.0,
        horizontal: 10.0,
      ),
      content: Container(
        // color: Colors.blueGrey,
        padding: const EdgeInsets.all(20.0),
        width: formCardWidth,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const CBText(
                      text: 'Produit',
                      fontSize: 20.0,
                      fontWeight: FontWeight.w600,
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(
                        Icons.close_rounded,
                        color: CBColors.primaryColor,
                        size: 30.0,
                      ),
                    ),
                  ],
                ),
                StaggeredGrid.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: 2,
                  crossAxisSpacing: 2,
                  children: products
                      .map((product) => Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                margin: const EdgeInsets.only(
                                  top: 25.0,
                                  bottom: 10.0,
                                ),
                                child: product.picture != null
                                    ? Image.network(
                                        product.picture!,
                                        //  height: 400.0,
                                        //  width: 400.0,
                                      )
                                    : Container(
                                        padding: const EdgeInsets.all(30.0),
                                        child: const Icon(
                                          Icons.photo,
                                          size: 70.0,
                                          color: CBColors.primaryColor,
                                        ),
                                      ),
                              ),
                              CBText(
                                text: product.name,
                                fontWeight: FontWeight.w500,
                              ),
                              const SizedBox(
                                height: 10.0,
                              )
                            ],
                          ))
                      .toList(),
                )
              ],
            ),
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(top: 17.0),
              width: 170.0,
              child: CBElevatedButton(
                text: 'OK',
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
