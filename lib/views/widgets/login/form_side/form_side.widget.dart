import 'package:communitybank/controllers/forms/on_changed/login/login.on_changed.dart';
import 'package:communitybank/controllers/forms/validators/login/login.validator.dart';
import 'package:communitybank/functions/auth/auth.function.dart';
import 'package:communitybank/utils/colors/colors.util.dart';
import 'package:communitybank/views/pages/registration/registration.page.dart';
import 'package:communitybank/views/widgets/globals/global.widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class FormSide extends StatefulHookConsumerWidget {
  const FormSide({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _FormSideState();
}

class _FormSideState extends ConsumerState<FormSide> {
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final showLoginButton = useState(true);
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
                const CBTextFormField(
                  label: 'Email',
                  hintText: 'Entrer votre addresse email',
                  isMultilineTextForm: false,
                  obscureText: false,
                  textInputType: TextInputType.emailAddress,
                  validator: LoginValidators.userEmail,
                  onChanged: LoginOnChanged.userEmail,
                ),
                const CBTextFormField(
                  label: 'Mot de passe',
                  hintText: 'Entrer votre mot de passe',
                  isMultilineTextForm: false,
                  obscureText: true,
                  suffixIcon: Icons.visibility_off,
                  textInputType: TextInputType.visiblePassword,
                  validator: LoginValidators.userPassword,
                  onChanged: LoginOnChanged.userPassword,
                ),
                const SizedBox(
                  height: 20.0,
                ),
                showLoginButton.value == true
                    ? CBElevatedButton(
                        text: 'Connexion',
                        onPressed: () {
                          AuthFunctions.login(
                            context: context,
                            formKey: formKey,
                            ref: ref,
                            showLoginButton: showLoginButton,
                          );
                        },
                      )
                    : CBElevatedButton(
                        text: 'Veuillez patienter ...',
                        onPressed: () {},
                      ),
                const SizedBox(
                  height: 25.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CBText(
                      text: 'Vous n\'avez pas encore un compte',
                    ),
                    const SizedBox(
                      width: 10.0,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const RegistrationPage(),
                          ),
                        );
                      },
                      child: const CBText(
                        text: 'Créer un compte',
                        fontWeight: FontWeight.w600,
                        color: CBColors.primaryColor,
                      ),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
