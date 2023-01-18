

import 'package:flutter/material.dart';
import 'package:firebasedemo/src/configs/app_colors.dart';

import 'fonts.dart';

class UnifiedAppButton extends StatelessWidget {
  final Function? onPress;
  final String? buttonTitle;
  final double? width;
  final EdgeInsets? padding;
   const UnifiedAppButton({Key? key, this.buttonTitle, this.onPress, this.width,this.padding}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30.0),
      child: Container(
        height: 45,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
          color: AppColor.btnColor
        ),
        child: GestureDetector(
          onTap: () {
            if (onPress != null) onPress!();
          },
          child: Material(
            color: Colors.transparent,
            child: Center(
              child: Text(
                buttonTitle!,
                style: const TextStyle(
                  fontFamily: Fonts.NORMAL,
                  color: AppColor.tileColor,
                  letterSpacing: 1.2,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
