import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:firebasedemo/src/constant/constants.dart';
import 'package:firebasedemo/src/core/helpers/dark_light_helper.dart';
import 'package:firebasedemo/src/user_functionality/business_logic/utils/app_preference.dart';
import 'package:firebasedemo/src/user_functionality/services/dependency_assembler_education.dart'
    as user;
import 'package:firebasedemo/src/user_functionality/ui/views/profile/profile_screen.dart';
import 'src/user_functionality/ui/views/login/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppPreference.init();
  await Firebase.initializeApp();
  await user.setupDependencyAssemblerEducation();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  var email = AppPreference.getString(PreferencesConstants.USER_EMAIL);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final isPlatformDark =
        WidgetsBinding.instance.window.platformBrightness == Brightness.dark;
    final initTheme = isPlatformDark ? kDarkTheme : kLightTheme;
    return ThemeProvider(
      initTheme: kDarkTheme,
      child: ThemeProvider(
        initTheme: initTheme,
        builder: (_, myTheme) {
          return MaterialApp(
            builder: EasyLoading.init(),
            debugShowCheckedModeBanner: false,
            theme: myTheme,
            home:email==null? LoginScreen():ProfileScreen(),
          );
        },
      ),
    );
  }
}
