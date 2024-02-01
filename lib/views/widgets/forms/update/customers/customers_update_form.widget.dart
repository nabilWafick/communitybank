import 'package:communitybank/controllers/forms/on_changed/customer/customer.on_changed.dart';
import 'package:communitybank/controllers/forms/validators/customer/customer.validator.dart';
import 'package:communitybank/functions/common/common.function.dart';
import 'package:communitybank/functions/crud/customers/customers_crud.function.dart';
import 'package:communitybank/models/data/customer/customer.model.dart';
import 'package:communitybank/models/data/customers_category/customers_category.model.dart';
import 'package:communitybank/models/data/economical_activity/economical_activity.model.dart';
import 'package:communitybank/models/data/locality/locality.model.dart';
import 'package:communitybank/models/data/personal_status/personal_status.model.dart';
import 'package:communitybank/utils/colors/colors.util.dart';
import 'package:communitybank/views/widgets/definitions/customers_categories/customers_categories_list/customers_categories_list.widget.dart';
import 'package:communitybank/views/widgets/definitions/economical_activities/economical_activities_list/economical_activities_list.widget.dart';
import 'package:communitybank/views/widgets/definitions/localities/localities_list/localities_list.widget.dart';
import 'package:communitybank/views/widgets/definitions/personal_status/personal_status_list/personal_status_list.widget.dart';
import 'package:communitybank/views/widgets/globals/forms_dropdowns/customer_category/customer_category_dropdown.widget.dart';
import 'package:communitybank/views/widgets/globals/forms_dropdowns/economical_activity/economical_activity_dropdown.widget.dart';
import 'package:communitybank/views/widgets/globals/forms_dropdowns/locality/locality_dropdown.widget.dart';
import 'package:communitybank/views/widgets/globals/forms_dropdowns/personal_status/personal_status_dropdown.widget.dart';
import 'package:communitybank/views/widgets/globals/global.widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CustomerUpdateForm extends StatefulHookConsumerWidget {
  final Customer customer;
  const CustomerUpdateForm({super.key, required this.customer});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CustomerUpdateFormState();
}

class _CustomerUpdateFormState extends ConsumerState<CustomerUpdateForm> {
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    const formCardWidth = 700.0;
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
                                    child: customerProfilePicture == null &&
                                            widget.customer.profile != null
                                        ? Image.network(
                                            widget.customer.profile!,
                                            width: 190.0,
                                            height: 190.0,
                                          )
                                        : customerProfilePicture == null
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
                                    child: customerSignaturePicture == null &&
                                            widget.customer.signature != null
                                        ? Image.network(
                                            widget.customer.signature!,
                                            width: 190.0,
                                            height: 190.0,
                                          )
                                        : customerSignaturePicture == null
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
                          child: CBTextFormField(
                            label: 'Nom',
                            hintText: 'Nom',
                            initialValue: widget.customer.name,
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
                          child: CBTextFormField(
                            label: 'Prénoms',
                            hintText: 'Prénoms',
                            initialValue: widget.customer.firstnames,
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
                          child: CBTextFormField(
                            label: 'Téléphone',
                            hintText: '+229|00229--------',
                            initialValue: widget.customer.phoneNumber,
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
                          child: CBTextFormField(
                            label: 'Adresse',
                            hintText: 'Adresse',
                            initialValue: widget.customer.address,
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
                          child: CBTextFormField(
                            label: 'Profession',
                            hintText: 'Profession',
                            initialValue: widget.customer.profession,
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
                          child: CBTextFormField(
                            label: 'Numéro CNI',
                            hintText: 'Numéro CNI',
                            initialValue:
                                widget.customer.nicNumber?.toString() ?? '',
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
                          child: Consumer(
                            builder: (context, ref, child) {
                              final customersCategoriesListStream = ref
                                  .watch(custumersCategoriesListStreamProvider);

                              return customersCategoriesListStream.when(
                                data: (data) {
                                  CustomerCategory customerCategory =
                                      CustomerCategory(
                                    name: 'Non définie',
                                    createdAt: DateTime.now(),
                                    updatedAt: DateTime.now(),
                                  );

                                  for (CustomerCategory customerCategoryData
                                      in data) {
                                    if (customerCategoryData.id ==
                                        widget.customer.categoryId) {
                                      customerCategory = customerCategoryData;
                                      break;
                                    }
                                  }

                                  data = {customerCategory, ...data}.toList();

                                  return CBFormCustomerCategoryDropdown(
                                    width: formCardWidth / 2.3,
                                    label: 'Catégorie',
                                    providerName:
                                        'customer-update-form-category',
                                    dropdownMenuEntriesLabels: data,
                                    dropdownMenuEntriesValues: data,
                                  );
                                },
                                error: (error, stackTrace) => const SizedBox(
                                  width: formCardWidth / 2.3,
                                ),
                                loading: () => const SizedBox(
                                  width: formCardWidth / 2.3,
                                ),
                              );
                            },
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(
                            vertical: 10.0,
                            horizontal: 5.0,
                          ),
                          child: Consumer(
                            builder: (context, ref, child) {
                              final economicalActivitiesListStream = ref
                                  .watch(economicalActivityListStreamProvider);

                              return economicalActivitiesListStream.when(
                                data: (data) {
                                  EconomicalActivity
                                      customerEconomicalActivity =
                                      EconomicalActivity(
                                    name: 'Non définie',
                                    createdAt: DateTime.now(),
                                    updatedAt: DateTime.now(),
                                  );

                                  for (EconomicalActivity economicalActivityData
                                      in data) {
                                    if (economicalActivityData.id ==
                                        widget.customer.economicalActivityId) {
                                      customerEconomicalActivity =
                                          economicalActivityData;
                                      break;
                                    }
                                  }

                                  data = {customerEconomicalActivity, ...data}
                                      .toList();

                                  return CBFormEconomicalActivityDropdown(
                                    width: formCardWidth / 2.3,
                                    label: 'Acitivité Économique',
                                    providerName:
                                        'customer-update-form-economical-activity',
                                    dropdownMenuEntriesLabels: data,
                                    dropdownMenuEntriesValues: data,
                                  );
                                },
                                error: (error, stackTrace) => const SizedBox(
                                  width: formCardWidth / 2.3,
                                ),
                                loading: () => const SizedBox(
                                  width: formCardWidth / 2.3,
                                ),
                              );
                            },
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(
                            vertical: 10.0,
                            horizontal: 5.0,
                          ),
                          child: Consumer(
                            builder: (context, ref, child) {
                              final personalStatusListStream =
                                  ref.watch(personalStatusListStreamProvider);

                              return personalStatusListStream.when(
                                data: (data) {
                                  PersonalStatus customerPersonalStatus =
                                      PersonalStatus(
                                    name: 'Non défini',
                                    createdAt: DateTime.now(),
                                    updatedAt: DateTime.now(),
                                  );

                                  for (PersonalStatus personalStatusData
                                      in data) {
                                    if (personalStatusData.id ==
                                        widget.customer.personalStatusId) {
                                      customerPersonalStatus =
                                          personalStatusData;
                                      break;
                                    }
                                  }

                                  data = {customerPersonalStatus, ...data}
                                      .toList();

                                  return CBFormPersonalStatusDropdown(
                                    width: formCardWidth / 2.3,
                                    label: 'Status Personel',
                                    providerName:
                                        'customer-update-form-personal-status',
                                    dropdownMenuEntriesLabels: data,
                                    dropdownMenuEntriesValues: data,
                                  );
                                },
                                error: (error, stackTrace) => const SizedBox(
                                  width: formCardWidth / 2.3,
                                ),
                                loading: () => const SizedBox(
                                  width: formCardWidth / 2.3,
                                ),
                              );
                            },
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(
                            vertical: 10.0,
                            horizontal: 5.0,
                          ),
                          child: Consumer(
                            builder: (context, ref, child) {
                              final localitiesListStream =
                                  ref.watch(localityListStreamProvider);

                              return localitiesListStream.when(
                                data: (data) {
                                  Locality customerLocality = Locality(
                                    name: 'Non définie',
                                    createdAt: DateTime.now(),
                                    updatedAt: DateTime.now(),
                                  );

                                  for (Locality localityData in data) {
                                    if (localityData.id ==
                                        widget.customer.localityId) {
                                      customerLocality = localityData;
                                      break;
                                    }
                                  }

                                  data = {customerLocality, ...data}.toList();

                                  return CBFormLocalityDropdown(
                                    width: formCardWidth / 2.3,
                                    label: 'Localité',
                                    providerName:
                                        'customer-update-form-locality',
                                    dropdownMenuEntriesLabels: data,
                                    dropdownMenuEntriesValues: data,
                                  );
                                },
                                error: (error, stackTrace) => const SizedBox(
                                  width: formCardWidth / 2.3,
                                ),
                                loading: () => const SizedBox(
                                  width: formCardWidth / 2.3,
                                ),
                              );
                            },
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
                                CustomerCRUDFunctions.update(
                                  context: context,
                                  formKey: formKey,
                                  ref: ref,
                                  customer: widget.customer,
                                  showValidatedButton: showValidatedButton,
                                );
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
