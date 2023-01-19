import 'package:firebasedemo/src/constant/asset.dart';
import 'package:flutter/cupertino.dart';

import '../models/base_model.dart';
import '../models/category_model.dart';
import '../models/task_model.dart';

class HomeViewModel extends BaseModel {
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

  List<TaskModel> taskList = [
    TaskModel(taskName: 'Task1', isChecked: false, date: '18-01'),
    TaskModel(taskName: 'Task2', isChecked: false, date: ''),
    TaskModel(taskName: 'Task3', isChecked: false, date: ''),
    TaskModel(taskName: 'Task4', isChecked: false, date: '26-01'),
    TaskModel(taskName: 'Task5', isChecked: false, date: ''),
  ];
}
