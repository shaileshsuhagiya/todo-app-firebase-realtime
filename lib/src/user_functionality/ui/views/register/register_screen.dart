import 'package:firebasedemo/src/configs/app_text_style.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:firebasedemo/src/configs/app_strings.dart';
import 'package:firebasedemo/src/user_functionality/business_logic/view_models/register_view_model.dart';
import 'package:firebasedemo/src/user_functionality/ui/shared/fonts.dart';
import '../../../../configs/app_colors.dart';
import '../../../business_logic/utils/validations.dart';
import '../../../services/dependency_assembler_education.dart';
import '../../shared/coty_text_field.dart';
import '../../shared/unified_app_button.dart';

class RegisterScreen extends StatelessWidget {
  final RegisterViewModel _auth =
      dependencyAssembler<RegisterViewModel>();

   RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: SingleChildScrollView(
          child: Form(
            key: _auth.formKey,
            child: Column(
              children: [
                const SizedBox(
                  height: 90,
                ),
                 Text(AppStrings.createAccount,
                    style: AppTextStyle().headerStyle),
                 Text(
                  AppStrings.createANewAccount,
                  style:AppTextStyle().headerSubTitleStyle.copyWith( color: AppColor.registerSubTitle,),
                ),
                const SizedBox(
                  height: 50,
                ),
                CotyTextField(
                    hintText: AppStrings.name,
                    prefixIconPath: Icons.person,
                    controller: _auth.nameController, validator:Validations().nameValidation,
                  onSaved: (value) {
                    _auth.nameController.text = value!;
                  },),
                CotyTextField(
                    hintText: AppStrings.email,
                    prefixIconPath: Icons.mail_outline,
                    controller: _auth.emailController,validator:Validations().emailValidation,
                  onSaved: (value) {
                    _auth.emailController.text = value!;
                  },),
                CotyTextField(
                    hintText: AppStrings.password,
                    prefixIconPath: Icons.lock,
                    controller: _auth.passwordController, validator:Validations().passwordValidation,
                  onSaved: (value) {
                    _auth.passwordController.text = value!;
                  },),
                CotyTextField(
                    hintText: AppStrings.confirmPassword,
                    prefixIconPath: Icons.lock,
                    controller: _auth.confirmPasswordController, validator: (value) {
                  RegExp regex = new RegExp(r'^.{6,}$');
                  if (value!.isEmpty) {
                    return ("Confirm Password is required for register");
                  }
                  if (!regex.hasMatch(value)) {
                    return ("Enter Valid Confirm Password(Min. 6 Character)");
                  }if(_auth.passwordController.text!=value.toString()){
                    return ('Password must be same as above');
                  }
                },
                  onSaved: (value) {
                    _auth.confirmPasswordController.text = value!;
                  },),
                UnifiedAppButton(buttonTitle: AppStrings.createAccount,onPress: (){
                  _auth.signUp(context);
                }),
                RichText(
                    text: TextSpan(
                        text: AppStrings.alreadyHaveAAccount,
                        style: AppTextStyle().clannRrowMedium,
                        children: [
                      TextSpan(
                        text: AppStrings.login,
                        style:AppTextStyle().clannRrowMedium.copyWith(color:AppColor.createAccountHeading ),
                        recognizer: new TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.pushReplacement(context, MaterialPageRoute(builder:(_)=> RegisterScreen()));
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
