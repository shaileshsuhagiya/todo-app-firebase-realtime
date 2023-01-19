import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebasedemo/src/user_functionality/business_logic/models/category_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../../configs/app_strings.dart';
import '../../../constant/constants.dart';
import '../models/base_model.dart';
import '../utils/app_preference.dart';

class TaskController extends BaseModel {
  final FirebaseFirestore fireStore = FirebaseFirestore.instance;
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descController = TextEditingController();
  final TextEditingController dateController = TextEditingController();

  addNewThing(
      int categoryType, String title, String desc, DateTime dueDate) async {
    EasyLoading.show(status: AppStrings.loading);
    var uid = AppPreference.getString(PreferencesConstants.UID);
    final DocumentReference documentReference = fireStore
        .collection("task")
        .doc(uid)
        .collection(uid)
        .doc(DateTime.now().microsecondsSinceEpoch.toString());

    fireStore.runTransaction((transaction) async {
      transaction.set(documentReference, <String, dynamic>{
        'categoryType': categoryType,
        'taskTitle': title,
        'description': desc,
        'userId': uid,
        'dueDate': dueDate.microsecondsSinceEpoch,
        'createdAt': DateTime.now().millisecondsSinceEpoch
      });
    }).then((value) {
      EasyLoading.dismiss();
    });
  }

  updateTask(CategoryModel doc, int categoryType, String title, String desc,
      DateTime dueDate) {
    var uid = AppPreference.getString(PreferencesConstants.UID);
    final DocumentReference documentReference = fireStore
        .collection('task')
        .doc(uid)
        .collection(uid)
        .doc(doc.categoryId.toString());

    documentReference
        .set(<String, dynamic>{
          'categoryType': categoryType,
          'taskTitle': title,
          'description': desc,
          'userId': uid,
          'dueDate': dueDate.microsecondsSinceEpoch,
          'updatedAt': DateTime.now().millisecondsSinceEpoch
        }, SetOptions(merge: true))
        .then((dynamic success) {})
        .catchError((dynamic error) {
          debugPrint(error);
        });
  }

  deleteTask(
    CategoryModel doc,
  ) async {
    var uid = AppPreference.getString(PreferencesConstants.UID);
    await fireStore.runTransaction((Transaction myTransaction) async {
      final DocumentReference documentReference = fireStore
          .collection('task')
          .doc(uid)
          .collection(uid)
          .doc(doc.categoryId.toString());

      documentReference.delete();
    });
  }
}
