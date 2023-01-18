import 'package:firebasedemo/src/configs/app_text_style.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:firebasedemo/src/configs/app_colors.dart';
import 'package:firebasedemo/src/configs/app_strings.dart';
import 'package:firebasedemo/src/user_functionality/business_logic/utils/validations.dart';
import 'package:firebasedemo/src/user_functionality/business_logic/view_models/login_view_model.dart';
import 'package:firebasedemo/src/user_functionality/ui/shared/fonts.dart';
import 'package:firebasedemo/src/user_functionality/ui/views/register/register_screen.dart';
import '../../../services/dependency_assembler_education.dart';
import '../../shared/coty_text_field.dart';
import '../../shared/unified_app_button.dart';

class LoginScreen extends StatelessWidget {
  final LoginViewModel _auth =
      dependencyAssembler<LoginViewModel>();

   LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Form(
            key: _auth.loginFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 90,
                ),
                 Text(AppStrings.welcomeBack,
                    style: AppTextStyle().headerStyle),
                 Text(
                  AppStrings.signAContinues,
                  style: AppTextStyle().headerSubTitleStyle,
                ),
                const SizedBox(
                  height: 50,
                ),
                CotyTextField(
                  hintText: AppStrings.email,
                  prefixIconPath: Icons.mail_outline,
                  controller: _auth.emailController,
                  validator: Validations().emailValidation,
                  onSaved: (value) {
                    _auth.emailController.text = value!;
                  },
                ),
                CotyTextField(
                  hintText: AppStrings.password,
                  prefixIconPath: Icons.lock,
                  controller: _auth.passwordController,
                  validator: Validations().passwordValidation,
                  onSaved: (value) {
                    _auth.passwordController.text = value!;
                  },
                ),
                 Align(
                  alignment: Alignment.topRight,
                  child: Text(AppStrings.forgotPassword,
                      style:AppTextStyle().clannRrowBold),
                ),
                UnifiedAppButton(
                    buttonTitle: AppStrings.login,
                    onPress: () {
                      _auth.signIn(context);
                    }),
                RichText(
                    text: TextSpan(
                        text: AppStrings.dontHaveAccount,
                        style:AppTextStyle().clannRrowMedium,
                        children: [
                      TextSpan(
                        text: AppStrings.createANewAccount,
                        style:AppTextStyle().clannRrowMedium.copyWith(color:AppColor.createAccountHeading ),
                        recognizer: new TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => RegisterScreen()));
                          },
                      )
                    ])),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
