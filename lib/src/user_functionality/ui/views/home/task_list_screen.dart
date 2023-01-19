import 'package:firebasedemo/src/configs/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import '../../../../configs/app_strings.dart';
import '../../../business_logic/view_models/home_view_model.dart';
import '../../../services/dependency_assembler_education.dart';

class TaskListScreen extends StatelessWidget {
  final String taskCategory;
  final HomeViewModel _homeViewModel = dependencyAssembler<HomeViewModel>();

  TaskListScreen({required this.taskCategory, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          title: Text(
            '$taskCategory ${AppStrings.task}',
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
      body: Column(
        children: [
          ChangeNotifierProvider.value(
            value: _homeViewModel,
            child: Consumer<HomeViewModel>(
              builder: (context, value, child) => ListView.builder(
                shrinkWrap: true,
                itemCount: _homeViewModel.taskList.length,
                padding: const EdgeInsets.only(top: 10),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      _homeViewModel.taskList[index].isCompleted =
                          !_homeViewModel.taskList[index].isCompleted;
                      _homeViewModel.updateNotifierState();
                    },
                    child: Container(
                      padding:
                          const EdgeInsets.only(left: 10, top: 5, bottom: 5),
                      child: Slidable(
                        key: const ValueKey(0),
                        endActionPane: ActionPane(
                          motion: const ScrollMotion(),
                          children: [
                            SlidableAction(
                              // An action can be bigger than the others.
                              onPressed: (context) {},
                              flex: 1,
                              backgroundColor: AppColor.btnColor,
                              foregroundColor: AppColor.tileColor,
                              icon: Icons.edit,
                              label: AppStrings.edit,
                            ),
                            SlidableAction(
                              onPressed: (context) {},
                              flex: 1,
                              backgroundColor: AppColor.redColor,
                              foregroundColor: AppColor.tileColor,
                              icon: Icons.delete,
                              label: AppStrings.delete,
                            ),
                          ],
                        ),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          decoration: BoxDecoration(
                            color: Colors.grey[50],
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Row(
                            children: [
                              Transform.scale(
                                scale: 1.2,
                                child: Checkbox(
                                  visualDensity: const VisualDensity(
                                      horizontal: -4, vertical: 0),
                                  checkColor: Colors.white,
                                  side: BorderSide(
                                      color: Colors.grey[400]!, width: 1.4),
                                  activeColor:
                                      _homeViewModel.taskList[index].isCompleted
                                          ? Colors.grey[300]
                                          : Colors.transparent,
                                  value: _homeViewModel
                                      .taskList[index].isCompleted,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  onChanged: (bool? value) {
                                    _homeViewModel.taskList[index].isCompleted =
                                        value!;
                                    _homeViewModel.updateNotifierState();
                                  },
                                ),
                              ),
                              const SizedBox(width: 12),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    _homeViewModel.taskList[index].taskTitle??"",
                                    style: const TextStyle(
                                        color: AppColor.kDarkPrimaryColor,
                                        fontSize: 11,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    DateTime.fromMillisecondsSinceEpoch(
                                            _homeViewModel
                                                .taskList[index].dueDate!)
                                        .toString(),
                                    style: const TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w300,
                                        color: AppColor.textColor),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
