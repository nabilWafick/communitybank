import 'package:communitybank/controllers/forms/on_changed/customer/customer.on_changed.dart';
import 'package:communitybank/controllers/forms/validators/customer/customer.validator.dart';
import 'package:communitybank/functions/common/common.function.dart';
import 'package:communitybank/functions/crud/customers/customers_crud.function.dart';
import 'package:communitybank/models/data/customer/customer.model.dart';
import 'package:communitybank/utils/colors/colors.util.dart';
import 'package:communitybank/views/widgets/definitions/customers_categories/customers_categories_list/customers_categories_list.widget.dart';
import 'package:communitybank/views/widgets/definitions/economical_activities/economical_activities_list/economical_activities_list.widget.dart';
import 'package:communitybank/views/widgets/definitions/localities/localities_list/localities_list.widget.dart';
import 'package:communitybank/views/widgets/definitions/personal_status/personal_status_list/personal_status_list.widget.dart';
import 'package:communitybank/views/widgets/globals/forms_dropdowns/customer_category_dropdown/customer_category_dropdown.widget.dart';
import 'package:communitybank/views/widgets/globals/forms_dropdowns/economical_activity_dropdown/economical_activity_dropdown.widget.dart';
import 'package:communitybank/views/widgets/globals/global.widgets.dart';
import 'package:communitybank/views/widgets/globals/forms_dropdowns/locality_dropdown/locality_dropdown.widget.dart';
import 'package:communitybank/views/widgets/globals/forms_dropdowns/personal_status_dropdown/personal_status_dropdown.widget.dart';
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
    final economicalActivitiesListStream =
        ref.watch(economicalActivityListStreamProvider);
    final customersCategoriesListStream =
        ref.watch(custumersCategoriesListStreamProvider);
    final localitiesListStream = ref.watch(localityListStreamProvider);
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
                            initialValue: widget.customer.nicNumber.toString(),
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
                            providerName: 'customer-update-form-category',
                            dropdownMenuEntriesLabels:
                                customersCategoriesListStream.when(
                              data: (data) {
                                // if customer category is undefined, return
                                // data whith undefined category in first
                                // position
                                // In first position, so as to it be setting as
                                // the default selectedItem of the dropdown

                                if (widget.customer.category.id == null) {
                                  data = [widget.customer.category, ...data];
                                }
                                //t if the customer category is defined, remove
                                // it from data and put it as the firt data
                                // element so as to it be setting as
                                // the default selectedItem of the dropdown
                                else {
                                  data.remove(widget.customer.category);
                                  data = [widget.customer.category, ...data];
                                }
                                return data;
                              },
                              error: (error, stackTrace) => [],
                              loading: () => [],
                            ),
                            dropdownMenuEntriesValues:
                                customersCategoriesListStream.when(
                              data: (data) {
                                // if customer category is undefined, return
                                // data whith undefined category in first
                                // position
                                // In first position, so as to it be setting as
                                // the default selectedItem of the dropdown

                                if (widget.customer.category.id == null) {
                                  data = [
                                    widget.customer.category,
                                    ...data,
                                  ];
                                }
                                //t if the customer category is defined, remove
                                // it from data and put it as the firt data
                                // element so as to it be setting as
                                // the default selectedItem of the dropdown
                                else {
                                  data.remove(widget.customer.category);
                                  data = [
                                    widget.customer.category,
                                    ...data,
                                  ];
                                }
                                return data;
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
                                'customer-update-form-economical-activity',
                            dropdownMenuEntriesLabels:
                                economicalActivitiesListStream.when(
                              data: (data) {
                                if (widget.customer.economicalActivity.id ==
                                    null) {
                                  data = [
                                    widget.customer.economicalActivity,
                                    ...data,
                                  ];
                                } else {
                                  data.remove(
                                      widget.customer.economicalActivity);
                                  data = [
                                    widget.customer.economicalActivity,
                                    ...data,
                                  ];
                                }
                                return data;
                              },
                              error: (error, stackTrace) => [],
                              loading: () => [],
                            ),
                            dropdownMenuEntriesValues:
                                economicalActivitiesListStream.when(
                              data: (data) {
                                if (widget.customer.economicalActivity.id ==
                                    null) {
                                  data = [
                                    widget.customer.economicalActivity,
                                    ...data,
                                  ];
                                } else {
                                  data.remove(
                                      widget.customer.economicalActivity);
                                  data = [
                                    widget.customer.economicalActivity,
                                    ...data,
                                  ];
                                }
                                return data;
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
                                'customer-update-form-personal-status',
                            dropdownMenuEntriesLabels:
                                personalStatusListStream.when(
                              data: (data) {
                                if (widget.customer.personalStatus.id == null) {
                                  data = [
                                    widget.customer.personalStatus,
                                    ...data,
                                  ];
                                } else {
                                  data.remove(widget.customer.personalStatus);
                                  data = [
                                    widget.customer.personalStatus,
                                    ...data,
                                  ];
                                }
                                return data;
                              },
                              error: (error, stackTrace) => [],
                              loading: () => [],
                            ),
                            dropdownMenuEntriesValues:
                                personalStatusListStream.when(
                              data: (data) {
                                if (widget.customer.personalStatus.id == null) {
                                  data = [
                                    widget.customer.personalStatus,
                                    ...data,
                                  ];
                                } else {
                                  data.remove(widget.customer.personalStatus);
                                  data = [
                                    widget.customer.personalStatus,
                                    ...data,
                                  ];
                                }
                                return data;
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
                            providerName: 'customer-update-form-locality',
                            dropdownMenuEntriesLabels:
                                localitiesListStream.when(
                              data: (data) {
                                if (widget.customer.locality.id == null) {
                                  data = [
                                    widget.customer.locality,
                                    ...data,
                                  ];
                                } else {
                                  data.remove(widget.customer.locality);
                                  data = [
                                    widget.customer.locality,
                                    ...data,
                                  ];
                                }
                                return data;
                              },
                              error: (error, stackTrace) => [],
                              loading: () => [],
                            ),
                            dropdownMenuEntriesValues:
                                localitiesListStream.when(
                              data: (data) {
                                if (widget.customer.locality.id == null) {
                                  data = [
                                    widget.customer.locality,
                                    ...data,
                                  ];
                                } else {
                                  data.remove(widget.customer.locality);
                                  data = [
                                    widget.customer.locality,
                                    ...data,
                                  ];
                                }
                                return data;
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
