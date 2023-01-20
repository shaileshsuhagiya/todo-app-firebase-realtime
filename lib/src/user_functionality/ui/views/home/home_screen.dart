import 'package:firebasedemo/src/configs/app_colors.dart';
import 'package:firebasedemo/src/configs/app_strings.dart';
import 'package:firebasedemo/src/user_functionality/ui/views/home/widget/category_tile.dart';
import 'package:firebasedemo/src/user_functionality/ui/views/task/task_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../../../constant/asset.dart';
import '../../../business_logic/models/category_model.dart';
import '../../../business_logic/view_models/home_view_model.dart';
import '../../../business_logic/view_models/task_view_model.dart';
import '../../../services/dependency_assembler_education.dart';
import '../add_new_thing/add_new_thing_screen.dart';
import '../login/login_screen.dart';
import 'widget/ripple_floating_button.dart';
import 'widget/round_container.dart';

class HomeScreen extends StatelessWidget {
  final HomeViewModel _homeViewModel = dependencyAssembler<HomeViewModel>();
  final TaskViewModel _taskViewModel = dependencyAssembler<TaskViewModel>();
  HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leadingWidth: 40,
        leading: Padding(
          padding: const EdgeInsets.only(left: 15),
          child: Image.asset(Asset.menu, color: AppColor.skyTextColor),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: IconButton(
              icon: Image.asset(Asset.logout, color: AppColor.skyTextColor),
              onPressed: () async {
                await _homeViewModel.logOutCurrentUser();
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                    (Route<dynamic> route) => false);
              },
            ),
          ),
        ],
      ),
      body: ChangeNotifierProvider.value(
        value: _homeViewModel,
        child: Consumer<HomeViewModel>(builder: (context, value, child) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    height: 235,
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                      image: AssetImage(Asset.skyBackground),
                      fit: BoxFit.fill,
                    )),
                  ),
                  Container(
                    height: 235,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.black45,
                    child: SafeArea(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 25),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 70,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        AppStrings.yourThings,
                                        style: TextStyle(
                                          fontSize: 26,
                                          color: AppColor.skyTextColor,
                                        ),
                                      ),
                                      const Spacer(),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Text(
                                              _homeViewModel
                                                  .getCategoryCount(1)
                                                  .toString(),
                                              style: const TextStyle(
                                                  fontSize: 20,
                                                  color: AppColor.skyTextColor,
                                                  fontWeight: FontWeight.w500)),
                                          Text(AppStrings.personal,
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: AppColor.textWhiteColor,
                                              )),
                                        ],
                                      ),
                                      const SizedBox(width: 10),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Text(
                                              _homeViewModel
                                                  .getCategoryCount(2)
                                                  .toString(),
                                              style: const TextStyle(
                                                  fontSize: 20,
                                                  color: AppColor.skyTextColor,
                                                  fontWeight: FontWeight.w500)),
                                          Text(AppStrings.business,
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: AppColor.textWhiteColor,
                                              )),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 45),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                        DateFormat('MMMM dd,yyyy')
                                            .format(DateTime.now())
                                            .toString(),
                                        style: const TextStyle(
                                          fontSize: 12,
                                          color: AppColor.textColor,
                                        )),
                                    Text(
                                        '${_homeViewModel.getTodayPercentage()}% done',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: AppColor.textWhiteColor,
                                        )),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Spacer(),
                          Container(
                            width: MediaQuery.of(context).size.width *
                                (_homeViewModel.getTodayPercentage() / 100),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Colors.blue.withOpacity(0.5),
                                  Colors.blue.withOpacity(0.6),
                                  Colors.blue.withOpacity(0.7),
                                ],
                                stops: const [
                                  0.1,
                                  0.4,
                                  0.5,
                                ],
                              ),
                            ),
                            child: const SizedBox(
                              height: 5.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    right: 0,
                    child: Container(
                      height: 235,
                      width: 150,
                      color: Colors.black12,
                    ),
                  )
                ],
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(20, 25, 20, 5),
                child: Text(
                  AppStrings.inbox,
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                      fontWeight: FontWeight.w500),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 20, 20),
                    child: Column(
                      children: [
                        AnimationLimiter(
                          child: ListView.separated(
                            padding: const EdgeInsets.only(
                                top: 5, left: 8, right: 8),
                            separatorBuilder: (context, index) =>
                                Container(height: 1, color: Colors.grey[200]),
                            shrinkWrap: true,
                            itemCount: _homeViewModel.category.length,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              CategoryModel category =
                                  _homeViewModel.category[index];
                              return CategoryTile(category, index);
                            },
                          ),
                        ),
                        const SizedBox(height: 5),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => TaskListScreen(
                                      taskCategory: "", taskCategoryId: 0),
                                ));
                          },
                          child: Hero(
                            tag: 0,
                            child: Row(
                              children: [
                                const Text(
                                  AppStrings.completed,
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500),
                                ),
                                const SizedBox(width: 5),
                                RoundContainer(
                                  text: _homeViewModel.taskList
                                      .where((element) => element.isCompleted)
                                      .toList()
                                      .length
                                      .toString(),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        }),
      ),
      floatingActionButton: RippleFloatingButton(
        color: AppColor.skyBackgroundTextColor,
        repeat: true,
        child: InkWell(
          borderRadius: BorderRadius.circular(50),
          onTap: () {
            _taskViewModel.clearData();
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => AddNewThingScreen(),
            ));
          },
          child: Hero(
            tag: AppStrings.floatingTag,
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColor.skyBackgroundTextColor,
                boxShadow: [
                  BoxShadow(
                    color: AppColor.btnColor.withOpacity(0.3),
                    spreadRadius: 7,
                    blurRadius: 7,
                    offset: const Offset(3, 5),
                  ),
                ],
              ),
              child: const Icon(Icons.add, color: AppColor.tileColor, size: 35),
            ),
          ),
        ),
      ),
    );
  }
}
