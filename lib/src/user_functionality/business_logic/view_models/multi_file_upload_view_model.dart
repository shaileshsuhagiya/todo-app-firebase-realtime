import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:firebasedemo/src/user_functionality/business_logic/models/base_model.dart';

import '../../../configs/app_strings.dart';
import '../../../constant/constants.dart';
import '../utils/app_preference.dart';

class MultiFileUploadViewModel extends BaseModel {
  final List<String> _allFileCurrentUser = [];
  List<String> get allFileCurrentUser => _allFileCurrentUser;

  fileSelect() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(allowMultiple: true);
    EasyLoading.show(status: AppStrings.loading);
    if (result != null) {
      List<File> files = result.paths.map((path) => File(path!)).toList();
      await Future.wait(files.map((_file) => uploadFile(_file)));
    } else {}
    getCurrentUserAllFile();
    EasyLoading.dismiss();
  }

  Future<String> uploadFile(File _file) async {
    var uid = AppPreference.getString(PreferencesConstants.UID);
    FirebaseStorage storage = FirebaseStorage.instance;
    Reference ref = storage
        .ref()
        .child("file/$uid/${_file.path.split('/').last}_${DateTime.now()}");
    UploadTask uploadTask = ref.putFile(_file);
    return await uploadTask.then((res) {
      return res.ref.getDownloadURL();
    });
  }

  getCurrentUserAllFile() {
    EasyLoading.show(status: AppStrings.loading);
    var uid = AppPreference.getString(PreferencesConstants.UID);
    FirebaseStorage storage = FirebaseStorage.instance;
    Reference ref = storage.ref().child("file").child(uid);

    ref.getDownloadURL();
    ref.listAll().then((result) {
      _allFileCurrentUser.clear();
      result.items.forEach((element) async {
        _allFileCurrentUser.add(element.name);
      });
      EasyLoading.dismiss();
      notifyListeners();
    });
    EasyLoading.dismiss();
  }
}
