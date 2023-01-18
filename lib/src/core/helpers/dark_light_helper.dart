import 'package:flutter/material.dart';
import 'package:firebasedemo/src/configs/app_colors.dart';

final kDarkTheme = ThemeData(
  brightness: Brightness.dark,
  fontFamily: 'SFProText',
  primaryColor: AppColor.kDarkPrimaryColor,
  canvasColor: AppColor.kDarkPrimaryColor,
  backgroundColor: AppColor.kDarkSecondaryColor,
  accentColor: AppColor.kAccentColor,
  iconTheme: ThemeData.dark().iconTheme.copyWith(
    color: AppColor.kLightSecondaryColor,
  ),
  textTheme: ThemeData.dark().textTheme.apply(
    fontFamily: 'SFProText',
    bodyColor: AppColor.kLightSecondaryColor,
    displayColor: AppColor.kLightSecondaryColor,
  ),
);

final kLightTheme = ThemeData(
  brightness: Brightness.light,
  fontFamily: 'SFProText',
  primaryColor: AppColor.kLightPrimaryColor,
  canvasColor: AppColor.kLightPrimaryColor,
  backgroundColor:AppColor.kLightSecondaryColor,
  accentColor: AppColor.kAccentColor,
  iconTheme: ThemeData.light().iconTheme.copyWith(
    color: AppColor.kDarkSecondaryColor,
  ),
  textTheme: ThemeData.light().textTheme.apply(
    fontFamily: 'SFProText',
    bodyColor: AppColor.kDarkSecondaryColor,
    displayColor: AppColor.kDarkSecondaryColor,
  ),
);