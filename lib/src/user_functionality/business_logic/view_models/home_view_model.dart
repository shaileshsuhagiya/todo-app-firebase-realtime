import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebasedemo/src/constant/asset.dart';
import 'package:firebasedemo/src/user_functionality/business_logic/utils/validations.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '../../../constant/constants.dart';
import '../models/base_model.dart';
import '../models/category_model.dart';
import '../models/task_model.dart';
import '../utils/app_preference.dart';

class HomeViewModel extends BaseModel {
  final FirebaseFirestore fireStore = FirebaseFirestore.instance;

  void updateNotifierState() {
    notifyListeners();
  }

  List<CategoryModel> category = [
    CategoryModel(
        categoryId: 1,
        categoryImage: Asset.personalCategory,
        categoryName: 'Personal'),
    CategoryModel(
        categoryId: 2,
        categoryImage: Asset.businessCategory,
        categoryName: 'Business'),
    CategoryModel(
        categoryId: 3,
        categoryImage: Asset.shoppingCategory,
        categoryName: 'Shopping'),
    CategoryModel(
        categoryId: 4,
        categoryImage: Asset.wishListCategory,
        categoryName: 'Wishlist'),
  ];

  List<TaskModel> taskList = [];
  StreamSubscription<QuerySnapshot>? streamSub;
  taskStream() {
    var uid = AppPreference.getString(PreferencesConstants.UID);
    streamSub = fireStore
        .collection('task')
        .doc(uid)
        .collection(uid!)
        .orderBy("createdAt", descending: true)
        .snapshots()
        .listen((event) {
      taskList.clear();
      for (var element in event.docs) {
        taskList.add(TaskModel.fromJson(element.id, element.data()));
      }
      notifyListeners();
    });
  }

  getCategoryCount(int categoryId) {
    return taskList
        .where((element) =>
            element.categoryType == categoryId &&
            DateTime.fromMicrosecondsSinceEpoch(element.dueDate!).isToday())
        .toList()
        .length;
  }

  getCategorySubTitle(int categoryId) {
    return taskList
        .where((element) => element.categoryType == categoryId)
        .toList()
        .map((e) => e.taskTitle)
        .join(", ")
        .toString();
  }

  getTodayPercentage() {
    int total = taskList
        .where((element) =>
            DateTime.fromMicrosecondsSinceEpoch(element.dueDate!).isToday())
        .toList()
        .length;

    int todayCompletedTotal = taskList
        .where((element) =>
            element.isCompleted &&
            DateTime.fromMicrosecondsSinceEpoch(element.dueDate!).isToday())
        .toList()
        .length;
    double percent = todayCompletedTotal / total;

    return percent.isNaN ? 0 : (percent * 100).round();
  }

  logOutCurrentUser() async {
    try {
      streamSub?.cancel();
      taskList.clear();
      await FirebaseAuth.instance.signOut();
      await AppPreference.clear();
    } catch (e) {
      EasyLoading.dismiss();
    }
  }
}
