import 'package:communitybank/controllers/forms/on_changed/product/product.on_changed.dart';
import 'package:communitybank/controllers/forms/validators/product/product.validator.dart';
import 'package:communitybank/functions/common/common.function.dart';
import 'package:communitybank/functions/crud/products/products_crud.function.dart';
import 'package:communitybank/models/data/product/product.model.dart';
import 'package:communitybank/utils/utils.dart';
import 'package:communitybank/views/widgets/globals/global.widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ProductUpdateForm extends StatefulHookConsumerWidget {
  final Product product;

  const ProductUpdateForm({
    super.key,
    required this.product,
  });
  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ProductUpdateFormState();
}

class _ProductUpdateFormState extends ConsumerState<ProductUpdateForm> {
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
                          showValidatedButton.value
                              ? Navigator.of(context).pop()
                              : () {};
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
                              child: productPicture == null &&
                                      widget.product.picture != null
                                  ? Image.network(
                                      widget.product.picture!,
                                      height: 250.0,
                                      width: 250.0,
                                    )
                                  : productPicture == null
                                      ? const Icon(
                                          Icons.photo,
                                          size: 150.0,
                                          color: CBColors.primaryColor,
                                        )
                                      : Image.asset(
                                          productPicture,
                                          height: 250.0,
                                          width: 250.0,
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
                        child: CBTextFormField(
                          label: 'Nom',
                          hintText: 'Nom',
                          initialValue: widget.product.name,
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
                        child: CBTextFormField(
                          label: 'Prix d\'achat',
                          hintText: 'Prix d\'achat',
                          initialValue: widget.product.purchasePrice.toString(),
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
                        showValidatedButton.value
                            ? Navigator.of(context).pop()
                            : () {};
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
                              await ProductCRUDFunctions.update(
                                context: context,
                                formKey: formKey,
                                ref: ref,
                                product: widget.product,
                                showValidatedButton: showValidatedButton,
                              );
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
