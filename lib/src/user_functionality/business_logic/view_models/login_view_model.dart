import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebasedemo/src/configs/app_strings.dart';
import 'package:firebasedemo/src/user_functionality/business_logic/enums/view_state.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../../constant/constants.dart';
import '../../ui/views/home/home_screen.dart';
import '../../ui/views/profile/profile_screen.dart';
import '../models/base_model.dart';
import '../models/user_entity_model.dart';
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
                      MaterialPageRoute(builder: (context) => HomeScreen())),
                });
        EasyLoading.dismiss();
      } on FirebaseAuthException catch (error) {
        EasyLoading.dismiss();
        firebaseCurrentFailure(error);
      }
    }
  }


  signInWithGoogle(BuildContext context) async {
    EasyLoading.show(status: AppStrings.loading);
    try {

      final GoogleSignIn googleSignIn = GoogleSignIn();
      await googleSignIn.signOut();
      GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();

      GoogleSignInAuthentication? googleSignInAuthentication =
          await googleSignInAccount?.authentication;
      AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication?.accessToken,
        idToken: googleSignInAuthentication?.idToken,
      );
      UserCredential authResult = await _auth.signInWithCredential(credential);
      EasyLoading.dismiss();
      await postDetailsToFirestore(context, authResult.user);
    } on FirebaseAuthException catch (error) {
      EasyLoading.dismiss();
      firebaseCurrentFailure(error);
    } catch (e) {
      EasyLoading.dismiss();
      Fluttertoast.showToast(msg: AppStrings.googleCreatedFailed);
    }
  }

  postDetailsToFirestore(BuildContext context, User? user) async {
    EasyLoading.show(status: AppStrings.loading);
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    UserModel userModel = UserModel();
    // writing all the values
    userModel.email = user!.email;
    userModel.uid = user.uid;
    userModel.name = user.email;
    userModel.profileUrl = user.photoURL;

    await firebaseFirestore
        .collection(AppStrings.user)
        .doc(user.uid)
        .set(userModel.toMap());
    Fluttertoast.showToast(msg: AppStrings.googleCreated);

    clearController();
    EasyLoading.dismiss();
    Navigator.pushAndRemoveUntil(
        (context),
        MaterialPageRoute(builder: (context) => HomeScreen()),
        (route) => false);
  }

  clearController() {
    emailController.clear();
    passwordController.clear();
  }
}
