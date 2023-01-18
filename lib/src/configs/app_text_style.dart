import 'package:flutter/material.dart';
import 'package:firebasedemo/src/configs/app_colors.dart';

import '../user_functionality/ui/shared/fonts.dart';

class AppTextStyle{
  final kTitleTextStyle = const TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
  );

  final kCaptionTextStyle = const TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w100,
  );

  final kButtonTextStyle = const TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w400,
    color: AppColor.tileColor,
  );

  final kFileName = const TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w400,
    color: AppColor.kDarkPrimaryColor,
  );
  final headerStyle = const TextStyle(
      color: AppColor.headerColor,
      fontFamily: Fonts.SFPROTEXT,
      fontWeight: FontWeight.bold,
      fontSize: 24);
  final headerSubTitleStyle = const TextStyle(
      height: 1.5,
      color: AppColor.subTitle,
      fontFamily: Fonts.SFPROTEXT);
  final clannRrowBold = const  TextStyle(
      color: AppColor.forgotTextColor,
      fontFamily: Fonts.CLANNARROWBOLD,
      fontWeight: FontWeight.bold);
  final clannRrowMedium = const   TextStyle(
      color: AppColor.textColor,
      fontSize: 12,
      fontFamily: Fonts.CLANNARROWMEDIUM);
}