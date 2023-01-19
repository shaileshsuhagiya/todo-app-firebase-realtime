import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebasedemo/src/configs/app_colors.dart';
import 'package:firebasedemo/src/user_functionality/business_logic/view_models/task_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../configs/app_strings.dart';
import '../../../../constant/common_text_form_field.dart';
import '../../../business_logic/view_models/home_view_model.dart';
import '../../../services/dependency_assembler_education.dart';
import '../../shared/unified_app_button.dart';
import '../../widgets/custom_drop_down.dart';

class AddNewThingScreen extends StatelessWidget {
  final HomeViewModel _homeViewModel = dependencyAssembler<HomeViewModel>();
  final TaskController taskController = dependencyAssembler<TaskController>();

  AddNewThingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: AppColor.backGroundColor,
      appBar: AppBar(
        backgroundColor: AppColor.backGroundColor,
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.arrow_back_rounded,
              color: AppColor.skyBackgroundTextColor,
              size: 25,
            )),
        centerTitle: true,
        title: const Text(
          'Add new thing',
          style: TextStyle(fontSize: 17, color: AppColor.subTitle),
        ),
        automaticallyImplyLeading: false,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Image.asset(
              'assets/images/filter_icon.png',
              height: 20,
              width: 20,
              color: AppColor.skyBackgroundTextColor,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Hero(
          tag: 'FloatingTag',
          child: SingleChildScrollView(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 25.0, vertical: 20),
              child: ChangeNotifierProvider.value(
                value: _homeViewModel,
                child: Consumer<HomeViewModel>(
                  builder: (context, value, child) => Column(
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border:
                              Border.all(color: AppColor.textColor, width: 0.5),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(14.0),
                          child: Image.asset(
                            'assets/images/draw.png',
                            color: AppColor.skyBackgroundTextColor,
                          ),
                        ),
                      ),
                      const SizedBox(height: 40),
                      CustomDropDownButton(
                          dropDownList: _homeViewModel.category,
                          dropdownValue: _homeViewModel.selectedCategory,
                          onChanged: (newValue) {
                            _homeViewModel.onChangeCategoryValue(newValue!);
                          }),
                      CommonTextFormField(
                        hintText: "Task Name",
                        controller: taskController.titleController,
                      ),
                      CommonTextFormField(
                        hintText: "Description",
                        controller: taskController.descController,
                      ),
                      CommonTextFormField(
                        hintText: "Due Date",
                        readOnly: true,
                        controller: taskController.dateController,
                      ),
                      UnifiedAppButton(
                          buttonTitle: AppStrings.addYourThings,
                          onPress: () {
                            taskController.addNewThing(
                                _homeViewModel.selectedCategoryId,
                                taskController.titleController.text,
                                taskController.descController.text,
                                DateTime.now());
                          }),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
