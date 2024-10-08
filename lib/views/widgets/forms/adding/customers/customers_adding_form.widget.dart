// ignore_for_file: use_build_context_synchronously

//import 'package:communitybank/controllers/customers/customers.controller.dart';
import 'package:communitybank/controllers/customers/customers.controller.dart';
import 'package:communitybank/controllers/forms/on_changed/customer/customer.on_changed.dart';
import 'package:communitybank/controllers/forms/validators/customer/customer.validator.dart';
import 'package:communitybank/functions/common/common.function.dart';
import 'package:communitybank/functions/crud/customers/customers_crud.function.dart';
import 'package:communitybank/models/data/customer/customer.model.dart';
//import 'package:communitybank/models/data/customer/customer.model.dart';
import 'package:communitybank/models/data/customers_category/customers_category.model.dart';
import 'package:communitybank/models/data/economical_activity/economical_activity.model.dart';
import 'package:communitybank/models/data/personal_status/personal_status.model.dart';
import 'package:communitybank/utils/colors/colors.util.dart';
import 'package:communitybank/views/widgets/definitions/customers_categories/customers_categories_list/customers_categories_list.widget.dart';
import 'package:communitybank/views/widgets/definitions/economical_activities/economical_activities_list/economical_activities_list.widget.dart';
import 'package:communitybank/views/widgets/definitions/localities/localities_list/localities_list.widget.dart';
import 'package:communitybank/views/widgets/definitions/personal_status/personal_status_list/personal_status_list.widget.dart';
import 'package:communitybank/views/widgets/forms/adding_confirmation_dialog/customers/customers_adding_confirmation_dialog.widget.dart';
//import 'package:communitybank/views/widgets/forms/adding_confirmation_dialog/customers/customers.adding_confirmation_dialog.widget.dart';
import 'package:communitybank/views/widgets/globals/forms_dropdowns/customer_category/customer_category_dropdown.widget.dart';
import 'package:communitybank/views/widgets/globals/forms_dropdowns/economical_activity/economical_activity_dropdown.widget.dart';
import 'package:communitybank/views/widgets/globals/global.widgets.dart';
import 'package:communitybank/views/widgets/globals/forms_dropdowns/locality/locality_dropdown.widget.dart';
import 'package:communitybank/views/widgets/globals/forms_dropdowns/personal_status/personal_status_dropdown.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
//import 'package:text_similarity/implementation/text_similarity.dart';

// used for check if there is customers
// with similar name or firstnames
// that will help for knowing
// if Navigator.of(context).pop()
// will be used two times in customer
// creation crud function in order to close
// similar customers list and customer
// adding alert dialog
final isThereSimilarCustomersProvider = StateProvider<bool>((ref) {
  return false;
});

class CustomerAddingForm extends StatefulHookConsumerWidget {
  const CustomerAddingForm({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CustomerAddingFormState();
}

class _CustomerAddingFormState extends ConsumerState<CustomerAddingForm> {
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    const formCardWidth = 700.0;
    final economicalActivitiesListStream =
        ref.watch(economicalActivitiesListStreamProvider);
    final customersCategoriesListStream =
        ref.watch(customersCategoriesListStreamProvider);
    final localitiesListStream = ref.watch(localitiesListStreamProvider);
    final personalStatusListStream =
        ref.watch(personalStatusListStreamProvider);
    final customerProfilePicture = ref.watch(customerProfilePictureProvider);
    final customerSignaturePicture =
        ref.watch(customerSignaturePictureProvider);
    final showValidatedButton = useState<bool>(true);
    return AlertDialog(
      contentPadding: const EdgeInsetsDirectional.symmetric(
        vertical: 20.0,
        horizontal: 10.0,
      ),
      content: SingleChildScrollView(
        child: Container(
          // color: Colors.blueGrey,
          padding: const EdgeInsets.all(20.0),
          width: formCardWidth,
          child: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const CBText(
                          text: 'Client',
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
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
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
                                          .read(customerProfilePictureProvider
                                              .notifier)
                                          .state = imageFromGallery;
                                    },
                                    child: customerProfilePicture == null
                                        ? const Icon(
                                            Icons.photo,
                                            size: 150.0,
                                            color: CBColors.primaryColor,
                                          )
                                        : Image.asset(
                                            customerProfilePicture,
                                            height: 190.0,
                                            width: 190.0,
                                          ),
                                  ),
                                ),
                              ),
                              const CBText(
                                text: 'Profil',
                                fontSize: 12.0,
                                fontWeight: FontWeight.w500,
                              ),
                            ],
                          ),
                          Column(
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
                                          .read(customerSignaturePictureProvider
                                              .notifier)
                                          .state = imageFromGallery;
                                    },
                                    child: customerSignaturePicture == null
                                        ? const Icon(
                                            Icons.photo,
                                            size: 150.0,
                                            color: CBColors.primaryColor,
                                          )
                                        : Image.asset(
                                            customerSignaturePicture,
                                            height: 190.0,
                                            width: 190.0,
                                          ),
                                  ),
                                ),
                              ),
                              const CBText(
                                text: 'Signature',
                                fontSize: 12.0,
                                fontWeight: FontWeight.w500,
                              )
                            ],
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
                            validator: CustomerValidators.customerName,
                            onChanged: CustomerOnChanged.customerName,
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(
                            horizontal: 10.0,
                          ),
                          width: formCardWidth / 2.3,
                          child: const CBTextFormField(
                            label: 'Prénoms',
                            hintText: 'Prénoms',
                            isMultilineTextForm: false,
                            obscureText: false,
                            textInputType: TextInputType.name,
                            validator: CustomerValidators.customerFirstnames,
                            onChanged: CustomerOnChanged.customerFirstnames,
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(
                            horizontal: 10.0,
                          ),
                          width: formCardWidth / 2.3,
                          child: const CBTextFormField(
                            label: 'Téléphone',
                            hintText: '+229|00229XXXXXXXX',
                            isMultilineTextForm: false,
                            obscureText: false,
                            textInputType: TextInputType.name,
                            validator: CustomerValidators.customerPhoneNumber,
                            onChanged: CustomerOnChanged.customerPhoneNumber,
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(
                            horizontal: 10.0,
                          ),
                          width: formCardWidth / 2.3,
                          child: const CBTextFormField(
                            label: 'Adresse',
                            hintText: 'Adresse',
                            isMultilineTextForm: false,
                            obscureText: false,
                            textInputType: TextInputType.name,
                            validator: CustomerValidators.customerAddress,
                            onChanged: CustomerOnChanged.customerAddress,
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(
                            horizontal: 10.0,
                          ),
                          width: formCardWidth / 2.3,
                          child: const CBTextFormField(
                            label: 'Profession',
                            hintText: 'Profession',
                            isMultilineTextForm: false,
                            obscureText: false,
                            textInputType: TextInputType.name,
                            validator: CustomerValidators.customerProfession,
                            onChanged: CustomerOnChanged.customerProfession,
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(
                            horizontal: 10.0,
                          ),
                          width: formCardWidth / 2.3,
                          child: const CBTextFormField(
                            label: 'Numéro CNI',
                            hintText: 'Numéro CNI',
                            isMultilineTextForm: false,
                            obscureText: false,
                            textInputType: TextInputType.name,
                            validator: CustomerValidators.customerNicNumber,
                            onChanged: CustomerOnChanged.customerNicNumber,
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(
                            vertical: 10.0,
                            horizontal: 5.0,
                          ),
                          child: CBFormCustomerCategoryDropdown(
                            width: formCardWidth / 2.3,
                            label: 'Catégorie',
                            providerName: 'customer-adding-form-category',
                            dropdownMenuEntriesLabels:
                                customersCategoriesListStream.when(
                              data: (data) {
                                return [
                                  CustomerCategory(
                                    name: 'Non définie',
                                    createdAt: DateTime.now(),
                                    updatedAt: DateTime.now(),
                                  ),
                                  ...data
                                ];
                              },
                              error: (error, stackTrace) => [],
                              loading: () => [],
                            ),
                            dropdownMenuEntriesValues:
                                customersCategoriesListStream.when(
                              data: (data) {
                                return [
                                  CustomerCategory(
                                    name: 'Non définie',
                                    createdAt: DateTime.now(),
                                    updatedAt: DateTime.now(),
                                  ),
                                  ...data
                                ];
                              },
                              error: (error, stackTrace) => [],
                              loading: () => [],
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(
                            vertical: 10.0,
                            horizontal: 5.0,
                          ),
                          child: CBFormEconomicalActivityDropdown(
                            width: formCardWidth / 2.3,
                            label: 'Activité économique',
                            providerName:
                                'customer-adding-form-economical-activity',
                            dropdownMenuEntriesLabels:
                                economicalActivitiesListStream.when(
                              data: (data) {
                                return [
                                  EconomicalActivity(
                                    name: 'Non définie',
                                    createdAt: DateTime.now(),
                                    updatedAt: DateTime.now(),
                                  ),
                                  ...data
                                ];
                              },
                              error: (error, stackTrace) => [],
                              loading: () => [],
                            ),
                            dropdownMenuEntriesValues:
                                economicalActivitiesListStream.when(
                              data: (data) {
                                return [
                                  EconomicalActivity(
                                    name: 'Non définie',
                                    createdAt: DateTime.now(),
                                    updatedAt: DateTime.now(),
                                  ),
                                  ...data
                                ];
                              },
                              error: (error, stackTrace) => [],
                              loading: () => [],
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(
                            vertical: 10.0,
                            horizontal: 5.0,
                          ),
                          child: CBFormPersonalStatusDropdown(
                            width: formCardWidth / 2.3,
                            label: 'Statut Personnel',
                            providerName:
                                'customer-adding-form-personal-status',
                            dropdownMenuEntriesLabels:
                                personalStatusListStream.when(
                              data: (data) {
                                return [
                                  PersonalStatus(
                                    name: 'Non défini',
                                    createdAt: DateTime.now(),
                                    updatedAt: DateTime.now(),
                                  ),
                                  ...data
                                ];
                              },
                              error: (error, stackTrace) => [],
                              loading: () => [],
                            ),
                            dropdownMenuEntriesValues:
                                personalStatusListStream.when(
                              data: (data) {
                                return [
                                  PersonalStatus(
                                    name: 'Non défini',
                                    createdAt: DateTime.now(),
                                    updatedAt: DateTime.now(),
                                  ),
                                  ...data
                                ];
                              },
                              error: (error, stackTrace) => [],
                              loading: () => [],
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(
                            vertical: 10.0,
                            horizontal: 5.0,
                          ),
                          child: CBFormLocalityDropdown(
                            width: formCardWidth / 2.3,
                            label: 'Localité',
                            providerName: 'customer-adding-form-locality',
                            dropdownMenuEntriesLabels:
                                localitiesListStream.when(
                              data: (data) {
                                return data;
                                /*[
                                  Locality(
                                    name: 'Non définie',
                                    createdAt: DateTime.now(),
                                    updatedAt: DateTime.now(),
                                  ),
                                  ...data
                                ];*/
                              },
                              error: (error, stackTrace) => [],
                              loading: () => [],
                            ),
                            dropdownMenuEntriesValues:
                                localitiesListStream.when(
                              data: (data) {
                                return data;
                                /* [
                                  Locality(
                                    name: 'Non définie',
                                    createdAt: DateTime.now(),
                                    updatedAt: DateTime.now(),
                                  ),
                                  ...data
                                ];*/
                              },
                              error: (error, stackTrace) => [],
                              loading: () => [],
                            ),
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
                                /*   await CustomerCRUDFunctions.create(
                                  context: context,
                                  formKey: formKey,
                                  ref: ref,
                                  showValidatedButton: showValidatedButton,
                                );*/
                                final isFormValid =
                                    formKey.currentState!.validate();
                                if (isFormValid) {
                                  showValidatedButton.value = false;
                                  // get customer name and firstnames
                                  final customerName =
                                      ref.watch(customerNameProvider);
                                  final customerFirstnames =
                                      ref.watch(customerFirstnamesProvider);

                                  // check if the customer name or firstnames
                                  // isn't already in the database

                                  // get all registered customers zhich have a
                                  // name or a firstame equal to the inputs

                                  final registeredCustomers =
                                      await CustomersController.getAll(
                                    selectedCustomerCategoryId: 0,
                                    selectedCustomerEconomicalActivityId: 0,
                                    selectedCustomerLocalityId: 0,
                                    selectedCustomerPersonalStatusId: 0,
                                  ).first;

                                  List<Customer> similarCustomers = [];

                                  similarCustomers = registeredCustomers
                                      .where(
                                        (customer) =>
                                            customer.firstnames.toLowerCase() ==
                                                customerFirstnames
                                                    .toLowerCase() ||
                                            customer.firstnames.toLowerCase() ==
                                                customerName.toLowerCase() ||
                                            customer.name.toLowerCase() ==
                                                customerFirstnames
                                                    .toLowerCase() ||
                                            customer.name.toLowerCase() ==
                                                customerName.toLowerCase(),
                                      )
                                      .toList();

                                  // filter cutomers list
                                  similarCustomers =
                                      similarCustomers.toSet().toList();

                                  if (similarCustomers.isEmpty) {
                                    await CustomerCRUDFunctions.create(
                                      context: context,
                                      formKey: formKey,
                                      ref: ref,
                                      showValidatedButton: showValidatedButton,
                                    );
                                  } else {
                                    // used for check if there is customers
                                    // with similar name or firstnames
                                    // that will help for knowing
                                    // if Navigator.of(context).pop()
                                    // will be used two times in customer
                                    // creation crud function in order to close
                                    // similar customers list and customer
                                    // adding alert dialog
                                    ref
                                        .read(isThereSimilarCustomersProvider
                                            .notifier)
                                        .state = true;
                                    await FunctionsController.showAlertDialog(
                                      context: context,
                                      alertDialog:
                                          CustomerAddingConfirmationDialog(
                                        formKey: formKey,
                                        similarCustomers: similarCustomers,
                                        context: context,
                                        showValidatedButton:
                                            showValidatedButton,
                                        confirmToAdd:
                                            CustomerCRUDFunctions.create,
                                      ),
                                    );
                                  }
                                }
                              },
                            ),
                          )
                        : const SizedBox()
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
