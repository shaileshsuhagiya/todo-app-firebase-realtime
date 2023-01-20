import 'package:flutter/material.dart';
import 'package:firebasedemo/src/configs/app_colors.dart';
import 'fonts.dart';

class CotyTextField extends StatelessWidget {
  final String? hintText;
  final bool isDisable;
  final TextEditingController? controller;
  final GestureTapCallback? onTap;

  final Function(String value)? onChanged;
  final Function? updateVlidationState;
  final Widget? suffixIcon;
  final Widget? suffixWidget;
  final IconData? prefixIconPath;
  final FormFieldValidator<String>? validator;
  final FormFieldSetter<String>? onSaved;

  const CotyTextField(
      {super.key, this.onChanged,
      this.updateVlidationState,
      this.isDisable = false,
      this.controller,
      this.hintText,
      this.suffixIcon,
      this.onTap,
      this.suffixWidget,
      this.prefixIconPath,
      this.validator,
      this.onSaved});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        autocorrect: true,
        autovalidateMode:AutovalidateMode.onUserInteraction ,
        onTap: onTap,
        readOnly: isDisable,
        enabled: !isDisable,
        onChanged: onChanged,
        controller: controller,
        onSaved: onSaved,
        validator: validator,
        style: const TextStyle(
            color: AppColor.textColor,
            fontSize: 14,
            fontFamily: Fonts.CLANNARROWNEWS),
        decoration: InputDecoration(
          border: const OutlineInputBorder(
              borderSide: BorderSide(color: AppColor.textFieldBorder)),
          labelText: hintText!.toUpperCase(),
          labelStyle: const TextStyle(
            color: Color(0xFFACACAC),
            fontFamily: Fonts.CLANNARROWNEWS,
            wordSpacing: 1.5,
            fontSize: 12,
          ),
          prefixIcon: Icon(prefixIconPath, color: AppColor.iconColor, size: 20),
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: AppColor.textFieldBorder)),
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: AppColor.textFieldBorder)),
          suffixIcon: suffixIcon,
        ),
      ),
    );
  }
}
