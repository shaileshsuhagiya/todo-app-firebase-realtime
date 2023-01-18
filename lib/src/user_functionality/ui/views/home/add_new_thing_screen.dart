import 'package:firebasedemo/src/configs/app_colors.dart';
import 'package:flutter/material.dart';

import '../../../../configs/app_strings.dart';
import '../../../../constant/common_text_form_field.dart';
import '../../shared/unified_app_button.dart';

class AddNewThingScreen extends StatelessWidget {
  const AddNewThingScreen({Key? key}) : super(key: key);

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
              child: Column(
                children: [
                  /*    Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Icon(
                            Icons.arrow_back_rounded,
                            color: AppColor.skyBackgroundTextColor,
                            size: 25,
                          )),
                      const Text(
                        'Add new thing',
                        style:
                            TextStyle(fontSize: 17, color: AppColor.subTitle),
                      ),
                      Image.asset(
                        'assets/images/filter_icon.png',
                        height: 20,
                        width: 20,
                        color: AppColor.skyBackgroundTextColor,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),*/
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColor.textColor, width: 0.5),
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
                  const CommonTextFormField(
                    hintText: "Workshop",
                  ),
                  const CommonTextFormField(
                    hintText: "Place",
                  ),
                  const CommonTextFormField(
                    hintText: "Time",
                  ),
                  const CommonTextFormField(
                    hintText: "Notification",
                  ),
                  UnifiedAppButton(
                      buttonTitle: AppStrings.addYourThings, onPress: () {}),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
