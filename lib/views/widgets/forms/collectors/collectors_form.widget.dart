import 'package:communitybank/utils/colors/colors.util.dart';
import 'package:communitybank/views/widgets/globals/global.widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CollectorsForm extends ConsumerWidget {
  const CollectorsForm({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const formCardWidth = 700.0;
    return Container(
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
                    text: 'Chargé de compte',
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
                      text: 'Profil',
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
                      isMultilineTextForm: false,
                      obscureText: false,
                      textInputType: TextInputType.name,
                      validator: (val, ref) {
                        return null;
                      },
                      onChanged: (val, ref) {},
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
                      isMultilineTextForm: false,
                      obscureText: false,
                      textInputType: TextInputType.name,
                      validator: (val, ref) {
                        return null;
                      },
                      onChanged: (val, ref) {},
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 10.0,
                    ),
                    width: formCardWidth / 2.3,
                    child: CBTextFormField(
                      label: 'Téléphone',
                      hintText: 'Téléphone',
                      isMultilineTextForm: false,
                      obscureText: false,
                      textInputType: TextInputType.name,
                      validator: (val, ref) {
                        return null;
                      },
                      onChanged: (val, ref) {},
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 10.0,
                    ),
                    width: formCardWidth / 2.3,
                    child: CBTextFormField(
                      label: 'Addresse',
                      hintText: 'Addresse',
                      isMultilineTextForm: false,
                      obscureText: false,
                      textInputType: TextInputType.name,
                      validator: (val, ref) {
                        return null;
                      },
                      onChanged: (val, ref) {},
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
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
