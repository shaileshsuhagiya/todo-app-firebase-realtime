import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebasedemo/src/user_functionality/business_logic/models/task_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

import '../../../configs/app_strings.dart';
import '../../../constant/constants.dart';
import '../../services/dependency_assembler_education.dart';
import '../models/base_model.dart';
import '../utils/app_preference.dart';
import 'home_view_model.dart';

class TaskViewModel extends BaseModel {
  final FirebaseFirestore fireStore = FirebaseFirestore.instance;
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  DateTime? pickedDate;
  String selectedCategory = 'Personal';
  int selectedCategoryId = 1;

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
      clearData();
      EasyLoading.dismiss();
    });
  }

  updateTask(TaskModel? doc, int categoryType, String title, String desc,
      DateTime dueDate) {
    var uid = AppPreference.getString(PreferencesConstants.UID);

    getDocumentRefTask(doc!.id.toString()).set(<String, dynamic>{
      'categoryType': categoryType,
      'taskTitle': title,
      'description': desc,
      'userId': uid,
      'dueDate': dueDate.microsecondsSinceEpoch,
      'updatedAt': DateTime.now().millisecondsSinceEpoch
    }, SetOptions(merge: true)).then((dynamic success) {
      Fluttertoast.showToast(msg: AppStrings.taskUpdated);
    }).catchError((dynamic error) {
      debugPrint(error);
    });
  }

  markCompletedTask(
    TaskModel doc,
  ) {
    getDocumentRefTask(doc.id.toString())
        .set({"isCompleted": true}, SetOptions(merge: true));
    doc.isCompleted = true;
    Fluttertoast.showToast(msg: AppStrings.taskCompleted);
    notifyListeners();
  }

  deleteTask(
    TaskModel doc,
  ) async {
    await fireStore.runTransaction((Transaction myTransaction) async {
      getDocumentRefTask(doc.id.toString())
          .delete()
          .then((value) => Fluttertoast.showToast(msg: AppStrings.taskDeleted));
    });
  }

  DocumentReference getDocumentRefTask(String docId) {
    var uid = AppPreference.getString(PreferencesConstants.UID);
    return fireStore.collection('task').doc(uid).collection(uid).doc(docId);
  }

  void updateNotifierState() {
    notifyListeners();
  }

  final HomeViewModel homeViewModel = dependencyAssembler<HomeViewModel>();
  void onChangeCategoryValue(String value) {
    selectedCategory = value;
    selectedCategoryId = homeViewModel.category
        .firstWhere((element) => element.categoryName == selectedCategory)
        .categoryId;
    notifyListeners();
  }

  setUpdate(TaskModel taskModel) {
    selectedCategoryId = homeViewModel.category
        .firstWhere((element) => element.categoryId == taskModel.categoryType)
        .categoryId;
    selectedCategory = homeViewModel.category
        .firstWhere((element) => element.categoryId == taskModel.categoryType)
        .categoryName;
    titleController.text = taskModel.taskTitle ?? "";
    descController.text = taskModel.description ?? "";
    dateController.text = DateFormat(AppStrings.dd_mm_yyyyy)
        .format(DateTime.fromMicrosecondsSinceEpoch(taskModel.dueDate!));
    pickedDate = DateTime.fromMicrosecondsSinceEpoch(taskModel.dueDate!);
  }

  clearData() {
    selectedCategory = 'Personal';
    selectedCategoryId = 1;
    titleController.clear();
    descController.clear();
    dateController.clear();
    pickedDate = null;
  }
}
