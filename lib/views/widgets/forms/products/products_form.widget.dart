import 'package:communitybank/controllers/forms/on_changed/product/product.on_changed.dart';
import 'package:communitybank/controllers/forms/validators/product/product.validator.dart';
import 'package:communitybank/utils/colors/colors.util.dart';
import 'package:communitybank/views/widgets/globals/global.widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductForm extends ConsumerStatefulWidget {
  const ProductForm({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProductFormState();
}

class _ProductFormState extends ConsumerState<ProductForm> {
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    const formCardWidth = 700.0;
    return Container(
      // color: Colors.blueGrey,
      padding: const EdgeInsets.all(20.0),
      width: formCardWidth,
      child: Form(
        key: formKey,
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
                Container(
                  margin: const EdgeInsets.symmetric(
                    vertical: 15.0,
                  ),
                  alignment: Alignment.center,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 25.0,
                          horizontal: 55.0,
                        ),
                        margin: const EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 15.0),
                        //width: double.infinity,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: CBColors.sidebarTextColor,
                            width: 2.0,
                          ),
                          borderRadius: BorderRadius.circular(15.0),
                          shape: BoxShape.rectangle,
                        ),
                        child: const Center(
                            child: Icon(
                          Icons.photo,
                          size: 150.0,
                          color: CBColors.primaryColor,
                        )
                            /*Image.asset(
                              '',
                              height: 200.0,
                              width: 200.0,
                            ),*/
                            ),
                      ),
                      const CBText(
                        text: 'Produit',
                        fontSize: 12.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ],
                  ),
                ),
                Wrap(
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 10.0,
                      ),
                      width: formCardWidth / 2.3,
                      child: const CBTextFormField(
                        label: 'Nom',
                        hintText: 'Nom',
                        isMultilineTextForm: false,
                        obscureText: false,
                        textInputType: TextInputType.name,
                        validator: ProductValidators.productName,
                        onChanged: ProductOnChanged.productName,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 10.0,
                      ),
                      width: formCardWidth / 2.3,
                      child: const CBTextFormField(
                        label: 'Prix d\'achat',
                        hintText: 'Prix d\'achat',
                        isMultilineTextForm: false,
                        obscureText: false,
                        textInputType: TextInputType.name,
                        validator: ProductValidators.productPurchasePrice,
                        onChanged: ProductOnChanged.productPurchasePrice,
                      ),
                    ),
                  ],
                )
              ],
            ),
            const SizedBox(
              height: 35.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  width: 170.0,
                  child: CBElevatedButton(
                    text: 'Fermer',
                    backgroundColor: CBColors.sidebarTextColor,
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
                const SizedBox(
                  width: 20.0,
                ),
                SizedBox(
                  width: 170.0,
                  child: CBElevatedButton(
                    text: 'Valider',
                    onPressed: () {
                      final isFormValid = formKey.currentState!.validate();
                      if (isFormValid) {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            contentPadding:
                                const EdgeInsetsDirectional.symmetric(
                              vertical: 20.0,
                              horizontal: 10.0,
                            ),
                            content: Container(
                              padding: const EdgeInsets.all(20.0),
                              child: const CBText(text: 'Validated Form'),
                            ),
                            // CustomersForm(),
                            // FormCard(),
                          ),
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
