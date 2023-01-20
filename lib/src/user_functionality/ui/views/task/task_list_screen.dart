import 'package:firebasedemo/src/configs/app_colors.dart';
import 'package:firebasedemo/src/user_functionality/business_logic/models/task_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../configs/app_strings.dart';
import '../../../business_logic/view_models/home_view_model.dart';
import '../../../services/dependency_assembler_education.dart';
import 'widget/task_tile.dart';

class TaskListScreen extends StatelessWidget {
  final String taskCategory;
  final int taskCategoryId;
  final HomeViewModel _homeViewModel = dependencyAssembler<HomeViewModel>();
  TaskListScreen(
      {required this.taskCategory, super.key, required this.taskCategoryId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          title: Text(
            taskCategoryId != 0
                ? '$taskCategory ${AppStrings.task}'
                : 'All ${AppStrings.task}',
            style: const TextStyle(
                color: AppColor.backGroundColor,
                fontSize: 17,
                fontWeight: FontWeight.w700),
          ),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back,
                color: AppColor.backGroundColor, size: 25),
          )),
      body: Hero(
        tag: taskCategoryId,
        child: ChangeNotifierProvider.value(
          value: _homeViewModel,
          child: Consumer<HomeViewModel>(
            builder: (context, value, child) => SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (_homeViewModel.taskList
                      .where((element) =>
                          (taskCategoryId == 0
                              ? true
                              : element.categoryType == taskCategoryId) &&
                          !element.isCompleted)
                      .toList()
                      .isNotEmpty)
                    const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                      child: Text(
                        AppStrings.pending,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 13,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _homeViewModel.taskList
                        .where((element) =>
                            (taskCategoryId == 0
                                ? true
                                : element.categoryType == taskCategoryId) &&
                            !element.isCompleted)
                        .toList()
                        .length,
                    padding: const EdgeInsets.only(top: 10),
                    itemBuilder: (context, index) {
                      List<TaskModel> data = _homeViewModel.taskList
                          .where((element) =>
                              (taskCategoryId == 0
                                  ? true
                                  : element.categoryType == taskCategoryId) &&
                              !element.isCompleted)
                          .toList();
                      TaskModel taskModel = data[index];
                      return TaskTile(
                        taskModel,
                      );
                    },
                  ),
                  const SizedBox(height: 5,),
                  if (_homeViewModel.taskList
                      .where((element) =>
                          (taskCategoryId == 0
                              ? true
                              : element.categoryType == taskCategoryId) &&
                          element.isCompleted)
                      .toList()
                      .isNotEmpty)
                    const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                      child: Text(
                        AppStrings.completed,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 13,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _homeViewModel.taskList
                        .where((element) =>
                            (taskCategoryId == 0
                                ? true
                                : element.categoryType == taskCategoryId) &&
                            element.isCompleted)
                        .toList()
                        .length,
                    padding: const EdgeInsets.only(top: 10),
                    itemBuilder: (context, index) {
                      List<TaskModel> data = _homeViewModel.taskList
                          .where((element) =>
                              (taskCategoryId == 0
                                  ? true
                                  : element.categoryType == taskCategoryId) &&
                              element.isCompleted)
                          .toList();
                      TaskModel taskModel = data[index];
                      return TaskTile(
                        taskModel,
                        hideEdit: true,
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
