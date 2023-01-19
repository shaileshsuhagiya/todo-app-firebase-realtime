import 'package:firebasedemo/src/configs/app_colors.dart';
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
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
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
                        controller: titleController,
                      ),
                      CommonTextFormField(
                        hintText: "Description",
                        controller: descController,
                      ),
                      CommonTextFormField(
                        hintText: "Description",
                        readOnly: true,
                        controller: dateController,
                      ),
                      UnifiedAppButton(
                          buttonTitle: AppStrings.addYourThings,
                          onPress: () {}),
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
