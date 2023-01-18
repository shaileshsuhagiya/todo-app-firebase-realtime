import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebasedemo/src/user_functionality/business_logic/view_models/profile_view_model.dart';
import 'package:firebasedemo/src/user_functionality/ui/views/profile/profile_list_item.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:firebasedemo/src/configs/app_colors.dart';
import 'package:firebasedemo/src/configs/app_text_style.dart';
import 'package:firebasedemo/src/user_functionality/ui/views/login/login_screen.dart';
import 'package:provider/provider.dart';
import '../../../../core/helpers/dark_light_helper.dart';
import '../../../services/dependency_assembler_education.dart';
import '../../widgets/default_profile_view.dart';
import '../file_upload/file_upload_screen.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ProfileViewModel _profileViewModel =
      dependencyAssembler<ProfileViewModel>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _profileViewModel.getProfileData();
  }

  @override
  Widget build(BuildContext context) {
    var themeSwitcher = ThemeSwitcher(
      builder: (context) {
        return AnimatedCrossFade(
          duration: const Duration(milliseconds: 200),
          crossFadeState:
              ThemeModelInheritedNotifier.of(context).theme.brightness ==
                      Brightness.dark
                  ? CrossFadeState.showFirst
                  : CrossFadeState.showSecond,
          firstChild: GestureDetector(
            onTap: () =>
                ThemeSwitcher.of(context).changeTheme(theme: kLightTheme),
            child: const Icon(
              LineAwesomeIcons.sun,
              size: 20,
            ),
          ),
          secondChild: GestureDetector(
            onTap: () =>
                ThemeSwitcher.of(context).changeTheme(theme: kDarkTheme),
            child: const Icon(
              LineAwesomeIcons.moon,
              size: 20,
            ),
          ),
        );
      },
    );

    var header = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const SizedBox(width: 20),
        ChangeNotifierProvider<ProfileViewModel>.value(
          value: _profileViewModel,
          child: Consumer<ProfileViewModel>(
              builder: (context, ProfileViewModel profileViewModel, child) {
            return Expanded(
              child: Column(
                children: <Widget>[
                  Container(
                    height: 100,
                    width: 100,
                    margin: const EdgeInsets.only(top: 20),
                    child: Stack(
                      children: <Widget>[
                        ClipRRect(
                          borderRadius: BorderRadius.circular(200),
                          child: CachedNetworkImage(
                            imageUrl:
                                profileViewModel.userData?.profileUrl ?? "",
                            imageBuilder:
                                (BuildContext context, imageProvider) {
                              return Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                      fit: BoxFit.cover, image: imageProvider),
                                ),
                              );
                            },
                            placeholder: (BuildContext context, _) =>
                                const DefaultProfilePicture(),
                            errorWidget: (BuildContext context, _, __) =>
                                const DefaultProfilePicture(),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            profileViewModel.onUpload(context);
                          },
                          child: Align(
                            alignment: Alignment.bottomRight,
                            child: Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                color: Theme.of(context).accentColor,
                                shape: BoxShape.circle,
                              ),
                              child: const Center(
                                heightFactor: 202,
                                widthFactor: 20,
                                child: Icon(
                                  LineAwesomeIcons.pen,
                                  color: AppColor.tileColor,
                                  size: 20,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    profileViewModel.userData?.name ?? "",
                    style: AppTextStyle().kTitleTextStyle,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    profileViewModel.userData?.email ?? "",
                    style: AppTextStyle().kCaptionTextStyle,
                  ),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const FileUploadScreen(),
                          ));
                    },
                    child: Container(
                      height: 50,
                      width: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Theme.of(context).accentColor,
                      ),
                      child: Center(
                        child: Text(
                          'Upload File',
                          style: AppTextStyle().kButtonTextStyle,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            );
          }),
        ),
        themeSwitcher,
        const SizedBox(width: 10),
      ],
    );

    return SafeArea(
      child: ThemeSwitchingArea(
        child: Builder(
          builder: (context) {
            return Scaffold(
              body: Column(
                children: <Widget>[
                  const SizedBox(height: 20),
                  header,
                  Expanded(
                    child: ListView(
                      children:  <Widget>[
                        const ProfileListItem(
                          icon: LineAwesomeIcons.user_shield,
                          text: 'Privacy',
                        ),
                        const ProfileListItem(
                          icon: LineAwesomeIcons.history,
                          text: 'Purchase History',
                        ),
                        const ProfileListItem(
                          icon: LineAwesomeIcons.question_circle,
                          text: 'Help & Support',
                        ),
                        const ProfileListItem(
                          icon: LineAwesomeIcons.cog,
                          text: 'Settings',
                        ),
                        ProfileListItem(
                          icon: LineAwesomeIcons.alternate_sign_out,
                          text: 'Logout',
                          onTap: () async {
                          await  _profileViewModel.logOutCurrentUser();
                          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                              LoginScreen()), (Route<dynamic> route) => false);

                          },
                          hasNavigation: false,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
