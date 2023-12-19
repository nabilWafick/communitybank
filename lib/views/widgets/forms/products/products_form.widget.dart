// ignore_for_file: use_build_context_synchronously

import 'package:communitybank/controllers/forms/on_changed/product/product.on_changed.dart';
import 'package:communitybank/controllers/forms/validators/product/product.validator.dart';
import 'package:communitybank/controllers/functions/functions.contoller.dart';
import 'package:communitybank/controllers/products/products.controller.dart';
import 'package:communitybank/models/data/product/product.model.dart';
import 'package:communitybank/models/response_dialog/response_dialog.model.dart';
import 'package:communitybank/models/service_response/service_response.model.dart';
import 'package:communitybank/utils/utils.dart';
import 'package:communitybank/views/widgets/forms/response_dialog/response_dialog.widget.dart';
import 'package:communitybank/views/widgets/globals/global.widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ProductForm extends StatefulHookConsumerWidget {
  const ProductForm({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProductFormState();
}

class _ProductFormState extends ConsumerState<ProductForm> {
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final showValidatedButton = useState<bool>(true);
    const formCardWidth = 700.0;
    final productPicture = ref.watch(productPictureProvider);
    return AlertDialog(
      contentPadding: const EdgeInsetsDirectional.symmetric(
        vertical: 20.0,
        horizontal: 10.0,
      ),
      content: Container(
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
                          child: Center(
                            child: InkWell(
                              onTap: () async {
                                final imageFromGallery =
                                    await FunctionsController.pickFile();
                                ref
                                    .read(productPictureProvider.notifier)
                                    .state = imageFromGallery;
                              },
                              child: productPicture == null
                                  ? const Icon(
                                      Icons.photo,
                                      size: 150.0,
                                      color: CBColors.primaryColor,
                                    )
                                  : Image.asset(
                                      productPicture,
                                      height: 200.0,
                                      width: 200.0,
                                    ),
                            ),
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
                  showValidatedButton.value
                      ? SizedBox(
                          width: 170.0,
                          child: CBElevatedButton(
                            text: 'Valider',
                            onPressed: () async {
                              showValidatedButton.value = false;
                              final isFormValid =
                                  formKey.currentState!.validate();
                              if (isFormValid) {
                                final productName =
                                    ref.watch(productNameProvider);
                                final productPrice =
                                    ref.watch(productPurchasePriceProvider);

                                ServiceResponse newProductStatus;

                                if (productPicture == null) {
                                  final product = Product(
                                    name: productName,
                                    purchasePrice: productPrice,
                                    picture: productPicture,
                                    createdAt: DateTime.now(),
                                    updatedAt: DateTime.now(),
                                  );

                                  newProductStatus =
                                      await ProductsController.create(
                                          product: product);

                                  // debugPrint('new product: $newProductStatus');
                                } else {
                                  final productRemotePath =
                                      await ProductsController.uploadPicture(
                                          productPicturePath: productPicture);

                                  if (productRemotePath != null) {
                                    final product = Product(
                                      name: productName,
                                      purchasePrice: productPrice,
                                      picture:
                                          '${CBConstants.supabaseStorageLink}/$productRemotePath',
                                      createdAt: DateTime.now(),
                                      updatedAt: DateTime.now(),
                                    );

                                    newProductStatus =
                                        await ProductsController.create(
                                            product: product);

                                    //  debugPrint('new product: $newProductStatus');
                                  } else {
                                    newProductStatus = ServiceResponse.failed;
                                  }
                                }
                                if (newProductStatus ==
                                    ServiceResponse.success) {
                                  ref
                                      .read(responseDialogProvider.notifier)
                                      .state = ResponseDialogModel(
                                    serviceResponse: newProductStatus,
                                    response: 'Opération réussie',
                                  );
                                  Navigator.of(context).pop();
                                } else {
                                  ref
                                      .read(responseDialogProvider.notifier)
                                      .state = ResponseDialogModel(
                                    serviceResponse: newProductStatus,
                                    response: 'Opération échouée',
                                  );
                                  showValidatedButton.value = true;
                                }
                                FunctionsController.showAlertDialog(
                                  context: context,
                                  alertDialog: const ResponseDialog(),
                                );
                              }
                            },
                          ),
                        )
                      : const SizedBox(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
