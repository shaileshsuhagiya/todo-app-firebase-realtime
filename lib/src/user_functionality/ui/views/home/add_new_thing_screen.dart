import 'package:firebasedemo/src/configs/app_colors.dart';
import 'package:firebasedemo/src/constant/asset.dart';
import 'package:firebasedemo/src/user_functionality/business_logic/utils/validations.dart';
import 'package:firebasedemo/src/user_functionality/business_logic/view_models/add_new_things_model.dart';
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
  final AddNewThingsModel _addNewThingsModel =
      dependencyAssembler<AddNewThingsModel>();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final _form = GlobalKey<FormState>(); //for storing form state.

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
          AppStrings.addNewThing,
          style: TextStyle(fontSize: 17, color: AppColor.subTitle),
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
                value: _addNewThingsModel,
                child: Consumer<AddNewThingsModel>(
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
                              Asset.draw,
                              color: AppColor.skyBackgroundTextColor,
                            ),
                          ),
                        ),
                        const SizedBox(height: 40),
                        CustomDropDownButton(
                            dropDownList: _homeViewModel.category,
                            dropdownValue: _addNewThingsModel.selectedCategory,
                            onChanged: (newValue) {
                              _addNewThingsModel
                                  .onChangeCategoryValue(newValue!);
                            }),
                        CommonTextFormField(
                          hintText: AppStrings.taskName,
                          controller: titleController,
                          validator: Validations().taskValidation,
                        ),
                        CommonTextFormField(
                          hintText: AppStrings.description,
                          validator: Validations().descriptionValidation,
                          controller: descController,
                        ),
                        CommonTextFormField(
                          hintText: AppStrings.date,
                          readOnly: true,
                          onTap: () async {
                            DateTime? pickedDate =
                                await customDatePicker(context);
                            if (pickedDate != null) {
                              var formattedDate =
                                  DateFormat(AppStrings.dd_mm_yyyyy)
                                      .format(pickedDate);
                              dateController.text =
                                  formattedDate; //formatted date output using intl package =>  2021-03-16
                              _homeViewModel.updateNotifierState();
                            } else {}
                          },
                          controller: dateController,
                        ),
                        UnifiedAppButton(
                            buttonTitle: AppStrings.addYourThings,
                            onPress: () {
                              if (_form.currentState!.validate()) {}
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
