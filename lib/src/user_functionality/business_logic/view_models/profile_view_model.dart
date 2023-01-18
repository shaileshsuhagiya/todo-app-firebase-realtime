import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebasedemo/src/user_functionality/business_logic/models/base_model.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebasedemo/src/user_functionality/business_logic/models/user_entity_model.dart';
import '../../../configs/app_strings.dart';
import '../../../constant/constants.dart';
import '../../ui/widgets/profile/upload_profile_pic.dart';
import '../utils/app_preference.dart';

class ProfileViewModel extends BaseModel {
  FirebaseStorage storage = FirebaseStorage.instance;
  UserModel? _userData;
  UserModel? get userData => _userData;

  void onUpload(context) {
    UploadProfilePic.onUploadTaped(
      context: context,
      getImageFromCamera: () => _getImage(context, ImageSource.camera),
      getImageFromGallary: () => _getImage(context, ImageSource.gallery),
    );
  }

  Future<void> _getImage(
    context,
    ImageSource imageSource,
  ) async {
    try{

      final _picker = ImagePicker();

      final pickedFile =
      await _picker.pickImage(source: imageSource, imageQuality: 25);
      if (pickedFile == null) return;

      Navigator.of(context).pop();

      final originalFile = File(pickedFile.path);
      List<int> imageBytes = await originalFile.readAsBytes();
      EasyLoading.show(status: AppStrings.loading);
      imageBytes = await FlutterImageCompress.compressWithList(
          Uint8List.fromList(imageBytes),
          quality: 25,
          rotate: 0);

      File fixedImage = File(pickedFile.path);
      String profileUrl = await uploadFile(fixedImage);
      EasyLoading.dismiss();
      uploadToFirebase(profileUrl);
    }catch(e){
      EasyLoading.dismiss();
    }

  }

  Future uploadToFirebase(profileUrl) async {
    EasyLoading.show(status: AppStrings.loading);
    var uid = AppPreference.getString(PreferencesConstants.UID);
    await FirebaseFirestore.instance
        .collection(AppStrings.user)
        .doc(uid)
        .update({'profile_url': profileUrl.toString()});
    EasyLoading.dismiss();
    getProfileData();
    notifyListeners();
  }

  getProfileData() async {
    EasyLoading.show(status: AppStrings.loading);
    var uid = AppPreference.getString(PreferencesConstants.UID);
    final snapshot = await FirebaseFirestore.instance
        .collection(AppStrings.user)
        .where('uid', isEqualTo: uid)
        .get();
    _userData = UserModel.fromMap(snapshot.docs.first);
    EasyLoading.dismiss();
    notifyListeners();
  }

  Future<String> uploadFile(File _image) async {
    FirebaseStorage storage = FirebaseStorage.instance;
    Reference ref = storage.ref().child("image1${DateTime.now()}");
    UploadTask uploadTask = ref.putFile(_image);
    return await uploadTask.then((res) {
      return res.ref.getDownloadURL();
    });
  }

  logOutCurrentUser()async{
    EasyLoading.show(status: AppStrings.loading);
    await FirebaseAuth.instance.signOut();
   await AppPreference.clear();

    EasyLoading.dismiss();
  }
}
