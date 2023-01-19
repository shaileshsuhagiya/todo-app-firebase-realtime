import 'package:flutter/material.dart';

import '../../../configs/app_colors.dart';
import '../../business_logic/models/category_model.dart';

class CustomDropDownButton extends StatelessWidget {
  String? dropdownValue;
  Function(String?)? onChanged;
  List<CategoryModel>? dropDownList;
  CustomDropDownButton({super.key, this.dropdownValue, this.onChanged,this.dropDownList});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 50,
        child: DropdownButton<String>(
          value: dropdownValue,
          isExpanded: true,
          dropdownColor: AppColor.backGroundColor,
          hint: const Text('Work type',
              style: TextStyle(
                fontSize: 14,
                color: Colors.white24,
              )),
          icon: const Icon(Icons.arrow_drop_down),
          onChanged: onChanged!,
          items: dropDownList!
              .map<DropdownMenuItem<String>>((CategoryModel value) {
            return DropdownMenuItem<String>(
              value: value.categoryName,
              child: Text(value.categoryName,
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppColor.tileColor,
                  )),
            );
          }).toList(),
        ));
  }
}
