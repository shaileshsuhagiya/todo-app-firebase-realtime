import 'package:flutter/material.dart';

import '../../../configs/app_colors.dart';

Future<DateTime?> customDatePicker(context) async {
  DateTime? pickedDate = await showDatePicker(
      context: context,
      builder: (context, child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: const ColorScheme.dark(
              primary: AppColor.backGroundColor,
              onPrimary: Colors.white,
              surface: AppColor.backGroundColor,
              onSurface: AppColor.kDarkPrimaryColor,
            ),
            dialogBackgroundColor: Colors.white,
          ),
          child: child!,
        );
      },
      initialDate: DateTime.now(),
      firstDate:  DateTime.now(),
      //DateTime.now() - not to allow to choose before today.
      lastDate: DateTime(2100));
  return pickedDate;
}
