import 'package:communitybank/utils/colors/colors.util.dart';
import 'package:communitybank/views/widgets/globals/global.widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FormSide extends ConsumerStatefulWidget {
  const FormSide({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _FormSideState();
}

class _FormSideState extends ConsumerState<FormSide> {
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Container(
      height: screenSize.height,
      width: screenSize.width / 2,
      padding: const EdgeInsets.symmetric(horizontal: 130.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            alignment: Alignment.centerLeft,
            margin: const EdgeInsetsDirectional.symmetric(vertical: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                const CBText(
                  text: 'Bienvenue sur',
                  fontSize: 25.0,
                ),
                const SizedBox(
                  width: 15.0,
                ),
                const CBText(
                  text: 'Community',
                  fontSize: 35.0,
                  fontWeight: FontWeight.w600,
                  color: CBColors.primaryColor,
                ),
                const SizedBox(
                  width: 5.0,
                ),
                CBText(
                  text: 'Bank',
                  fontSize: 35.0,
                  fontWeight: FontWeight.w600,
                  color: CBColors.tertiaryColor.withOpacity(.5),
                ),
              ],
            ),
          ),
          Form(
            key: formKey,
            child: Column(
              children: [
                CBTextFormField(
                  label: 'Email',
                  hintText: 'Entrer votre addresse email',
                  isMultilineTextForm: false,
                  obscureText: false,
                  textInputType: TextInputType.emailAddress,
                  validator: (val, ref) {
                    return null;
                  },
                  onChanged: (val, ref) => {},
                ),
                CBTextFormField(
                  label: 'Mot de passe',
                  hintText: 'Entrer votre mot de passe',
                  isMultilineTextForm: false,
                  obscureText: true,
                  suffixIcon: Icons.visibility_off,
                  textInputType: TextInputType.visiblePassword,
                  validator: (val, ref) {
                    return null;
                  },
                  onChanged: (val, ref) => {},
                ),
                const SizedBox(
                  height: 20.0,
                ),
                CBElevatedButton(
                  text: 'Connexion',
                  onPressed: () => {},
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
