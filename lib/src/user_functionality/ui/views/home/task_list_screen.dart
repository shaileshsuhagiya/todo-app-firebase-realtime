import 'package:firebasedemo/src/configs/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../business_logic/view_models/home_view_model.dart';
import '../../../services/dependency_assembler_education.dart';

class taskListScreen extends StatelessWidget {
  final HomeViewModel _homeViewModel = dependencyAssembler<HomeViewModel>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          title: const Text(
            'Task List',
            style: TextStyle(
                color: AppColor.backGroundColor,
                fontSize: 20,
                fontWeight: FontWeight.w700),
          ),
          leading: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.arrow_back,
                color: AppColor.backGroundColor, size: 25),
          )),
      body: Column(
        children: [
          ChangeNotifierProvider.value(
            value: _homeViewModel,
            child: Consumer<HomeViewModel>(
              builder: (context, value, child) => ListView.builder(
                shrinkWrap: true,
                itemCount: _homeViewModel.taskList.length,
                padding: EdgeInsets.only(top: 10),
                itemBuilder: (context, index) {
                  return Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    margin:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 7),
                    decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Row(
                      children: [
                        Transform.scale(
                          scale: 1.5,
                          child: Checkbox(
                            visualDensity:
                                VisualDensity(horizontal: -4, vertical: 0),
                            checkColor: Colors.white,
                            side: BorderSide(
                                color: Colors.grey[400]!, width: 1.4),
                            activeColor:
                                _homeViewModel.taskList[index].isChecked
                                    ? Colors.grey[300]
                                    : Colors.transparent,
                            value: _homeViewModel.taskList[index].isChecked,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            onChanged: (bool? value) {
                              _homeViewModel.taskList[index].isChecked = value!;
                              _homeViewModel.updateNotifierState();
                            },
                          ),
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              _homeViewModel.taskList[index].taskName,
                              style: const TextStyle(
                                  color: AppColor.kDarkPrimaryColor,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w500),
                            ),
                            SizedBox(height: 5),
                            Text(
                              _homeViewModel.taskList[index].date,
                              style: const TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w300,
                                  color: AppColor.textColor),
                            )
                          ],
                        ),
                        Spacer(),
                        IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.outlined_flag,
                              color: Colors.grey[300],
                              size: 25,
                            ))
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
