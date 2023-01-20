import 'package:firebasedemo/src/configs/app_colors.dart';
import 'package:firebasedemo/src/user_functionality/business_logic/models/task_model.dart';
import 'package:firebasedemo/src/user_functionality/business_logic/view_models/task_view_model.dart';
import 'package:firebasedemo/src/constant/asset.dart';
import 'package:firebasedemo/src/user_functionality/business_logic/utils/validations.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../../../configs/app_strings.dart';
import '../../../../constant/common_text_form_field.dart';
import '../../../business_logic/view_models/home_view_model.dart';
import '../../../services/dependency_assembler_education.dart';
import '../../shared/unified_app_button.dart';
import '../../widgets/custom_date_picker.dart';
import '../../widgets/custom_drop_down.dart';

class AddNewThingScreen extends StatelessWidget {
  final HomeViewModel _homeViewModel = dependencyAssembler<HomeViewModel>();
  final TaskViewModel _taskViewModel = dependencyAssembler<TaskViewModel>();
  final _form = GlobalKey<FormState>(); //for storing form state.

  final TaskViewModel taskViewModel = dependencyAssembler<TaskViewModel>();
  TaskModel? taskModel;

  AddNewThingScreen({
    super.key,
    this.taskModel,
  });
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
        title: Text(
          taskModel == null
              ? AppStrings.addNewThing
              : AppStrings.updateYourThingsS,
          style: const TextStyle(fontSize: 17, color: AppColor.subTitle),
        ),
        automaticallyImplyLeading: false,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Image.asset(
              Asset.filterIcon,
              height: 20,
              width: 20,
              color: AppColor.skyBackgroundTextColor,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Hero(
          tag: AppStrings.floatingTag,
          child: SingleChildScrollView(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 25.0, vertical: 20),
              child: ChangeNotifierProvider.value(
                value: _taskViewModel,
                child: Consumer<TaskViewModel>(
                  builder: (context, value, child) => Form(
                    key: _form,
                    child: Column(
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                                color: AppColor.textColor, width: 0.5),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(14.0),
                            child: Image.asset(
                              _homeViewModel.category
                                  .firstWhere((element) =>
                                      element.categoryId ==
                                      _taskViewModel.selectedCategoryId)
                                  .categoryImage,
                              color: AppColor.skyBackgroundTextColor,
                            ),
                          ),
                        ),
                        const SizedBox(height: 40),
                        CustomDropDownButton(
                            dropDownList: _homeViewModel.category,
                            dropdownValue: _taskViewModel.selectedCategory,
                            onChanged: (newValue) {
                              _taskViewModel.onChangeCategoryValue(newValue!);
                            }),
                        CommonTextFormField(
                          hintText: AppStrings.taskName,
                          controller: _taskViewModel.titleController,
                          validator: Validations().taskValidation,
                        ),
                        CommonTextFormField(
                          hintText: AppStrings.description,
                          validator: Validations().descriptionValidation,
                          controller: _taskViewModel.descController,
                        ),
                        CommonTextFormField(
                          hintText: AppStrings.dueDate,
                          readOnly: true,
                          validator: Validations().dateValidation,
                          onTap: () async {
                            _taskViewModel.pickedDate =
                                await customDatePicker(context);
                            if (_taskViewModel.pickedDate != null) {
                              var formattedDate =
                                  DateFormat(AppStrings.dd_mm_yyyyy)
                                      .format(_taskViewModel.pickedDate!);
                              _taskViewModel.dateController.text =
                                  formattedDate; //formatted date output using intl package =>  2021-03-16
                              _homeViewModel.updateNotifierState();
                            } else {}
                          },
                          controller: _taskViewModel.dateController,
                        ),
                        UnifiedAppButton(
                            buttonTitle: taskModel == null
                                ? AppStrings.addYourThings
                                : AppStrings.updateYourThings,
                            onPress: () {
                              if (_form.currentState!.validate()) {
                                if (taskModel != null) {
                                  taskViewModel.updateTask(
                                      taskModel,
                                      _taskViewModel.selectedCategoryId,
                                      taskViewModel.titleController.text,
                                      taskViewModel.descController.text,
                                      taskViewModel.pickedDate!);
                                  Navigator.pop(context);
                                } else {
                                  taskViewModel.addNewThing(
                                      _taskViewModel.selectedCategoryId,
                                      taskViewModel.titleController.text,
                                      taskViewModel.descController.text,
                                      taskViewModel.pickedDate!);
                                }
                              }
                            }),
                      ],
                    ),
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
