import 'package:flutter/material.dart';

import '../configs/app_colors.dart';

class CommonTextFormField extends StatelessWidget {
  final Function(String)? onChanged;
  final Function()? onTap;
  final String? hintText;
  final TextEditingController? controller;
  final bool readOnly;
  final FormFieldValidator<String>? validator;

  const CommonTextFormField(
      {super.key,
      this.onChanged,
      this.hintText,
      this.controller,
      this.readOnly = false,
      this.onTap,this.validator});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 3),
      child: TextFormField(
        autocorrect: true,
        readOnly: readOnly,
        validator: validator,
        style: const TextStyle(
          fontSize: 14,
          color: AppColor.tileColor,
        ),
        controller: controller,
        onChanged: onChanged,
        onTap: onTap,
        decoration: InputDecoration(
          suffix: InkWell(
            onTap: () {
              controller!.clear();
            },
            child:Container(
                    height: 22,
                    width: 22,
                    decoration: const BoxDecoration(
                      color: Colors.white30,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.close,
                      size: 13,
                      color: AppColor.tileColor,
                    ),
                  )

          ),
          hintText: hintText ?? "Enter Email",
          hintStyle: const TextStyle(
            fontSize: 14,
            color: Colors.white24,
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white24, width: 1),
          ),
          disabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white24, width: 1),
          ),
          errorBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.red[900]!, width: 1),
      ),
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white24, width: 1),
          ),
        ),
      ),
    );
  }
}
