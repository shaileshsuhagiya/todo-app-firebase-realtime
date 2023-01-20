import 'package:firebasedemo/src/user_functionality/business_logic/models/task_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import '../../../../../configs/app_colors.dart';
import '../../../../../configs/app_strings.dart';
import '../../../../business_logic/view_models/home_view_model.dart';
import '../../../../business_logic/view_models/task_view_model.dart';
import '../../../../services/dependency_assembler_education.dart';
import '../../add_new_thing/add_new_thing_screen.dart';

class TaskTile extends StatelessWidget {
  final TaskViewModel _taskViewModel = dependencyAssembler<TaskViewModel>();
  final HomeViewModel _homeViewModel = dependencyAssembler<HomeViewModel>();
  final TaskModel taskModel;
  final bool hideEdit;
  TaskTile(
    this.taskModel, {
    Key? key,
    this.hideEdit = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 10, top: 5, bottom: 5),
      child: Slidable(
        key: const ValueKey(0),
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          children: [
            if (!hideEdit)
              SlidableAction(
                // An action can be bigger than the others.
                onPressed: (context) {
                  _taskViewModel.setUpdate(taskModel);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            AddNewThingScreen(taskModel: taskModel),
                      ));
                },
                flex: 1,
                backgroundColor: AppColor.btnColor,
                foregroundColor: AppColor.tileColor,
                icon: Icons.edit,
                label: AppStrings.edit,
              ),
            SlidableAction(
              onPressed: (context) {
                _taskViewModel.deleteTask(taskModel);
              },
              flex: 1,
              backgroundColor: AppColor.redColor,
              foregroundColor: AppColor.tileColor,
              icon: Icons.delete,
              label: AppStrings.delete,
            ),
          ],
        ),
        child: IntrinsicHeight(
          child: Row(
            children: [
              const VerticalDivider(
                thickness: 5,
                width: 5,
                color: AppColor.btnColor,
              ),
              Expanded(
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.grey[50],
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Transform.scale(
                        scale: 1.2,
                        child: Checkbox(
                          visualDensity:
                              const VisualDensity(horizontal: -4, vertical: 0),
                          checkColor: Colors.white,
                          side:
                              BorderSide(color: Colors.grey[400]!, width: 1.4),
                          activeColor: taskModel.isCompleted
                              ? Colors.grey[300]
                              : Colors.transparent,
                          value: taskModel.isCompleted,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          onChanged: (bool? value) async {
                            if (value!) {
                              taskModel.isCompleted = value;
                              _taskViewModel.markCompletedTask(taskModel);
                              _homeViewModel.updateNotifierState();
                            }
                          },
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              taskModel.taskTitle ?? "",
                              textAlign: TextAlign.start,
                              style: const TextStyle(
                                  color: AppColor.kDarkPrimaryColor,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              taskModel.description ?? "",
                              textAlign: TextAlign.start,
                              style: const TextStyle(
                                  color: AppColor.textColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w300),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              DateFormat('dd-MM-yyyy').format(
                                  DateTime.fromMicrosecondsSinceEpoch(
                                      taskModel.dueDate!)),
                              style: const TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w300,
                                  color: AppColor.textColor),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
