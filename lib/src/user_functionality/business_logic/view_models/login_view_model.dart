import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebasedemo/src/configs/app_strings.dart';
import 'package:firebasedemo/src/user_functionality/business_logic/enums/view_state.dart';
import '../../../constant/constants.dart';
import '../../ui/views/profile/profile_screen.dart';
import '../models/base_model.dart';
import '../utils/app_preference.dart';
import '../utils/firebase_exception_utility.dart';

class LoginViewModel extends BaseModel {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final loginFormKey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  String? errorMessage;

  void signIn(context) async {

    if (loginFormKey.currentState!.validate()) {
      try {
        EasyLoading.show(status: AppStrings.loading);
        await _auth
            .signInWithEmailAndPassword(
                email: emailController.text, password: passwordController.text)
            .then((uid) => {
                  AppPreference.set(
                      PreferencesConstants.USER_EMAIL, emailController.text),
                  AppPreference.set(PreferencesConstants.UID, uid.user?.uid),
                  Fluttertoast.showToast(msg: AppStrings.loginSuccessfully),
          clearController(),
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => ProfileScreen())),
                });
        EasyLoading.dismiss();
      } on FirebaseAuthException catch (error) {
       EasyLoading.dismiss();
        firebaseCurrentFailure(error);
      }
    }
  }

  clearController(){
    emailController.clear();
    passwordController.clear();
  }
}
