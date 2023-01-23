import 'package:firebasedemo/src/user_functionality/business_logic/models/category_model.dart';
import 'package:firebasedemo/src/user_functionality/ui/views/home/widget/round_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import '../../../../business_logic/view_models/home_view_model.dart';
import '../../../../services/dependency_assembler_education.dart';
import '../../task/task_list_screen.dart';

class CategoryTile extends StatelessWidget {
  final CategoryModel category;
  final int index;
  final HomeViewModel _homeViewModel = dependencyAssembler<HomeViewModel>();
  CategoryTile(this.category, this.index, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimationConfiguration.staggeredList(
      position: index,
      child: SlideAnimation(
        verticalOffset: 50.0,
        child: Hero(
          tag: category.categoryId,
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(vertical: 10),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TaskListScreen(
                      taskCategory: category.categoryName,
                      taskCategoryId: category.categoryId,
                    ),
                  ));
            },
            leading: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.grey[200]!,
                  )),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Image.asset(
                  category.categoryImage,
                  fit: BoxFit.contain,
                  height: 20,
                  width: 20,
                ),
              ),
            ),
            title: Text(
              category.categoryName,
              style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[900],
                  fontWeight: FontWeight.w500),
            ),
            subtitle: _homeViewModel.getCategorySubTitle(category.categoryId) != null?Text(
              _homeViewModel.getCategorySubTitle(category.categoryId),
              style: const TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
            ): null,
            trailing: RoundContainer(
                text: _homeViewModel.taskList
                    .where((element) =>
                        element.categoryType == category.categoryId)
                    .toList()
                    .length
                    .toString()),
          ),
        ),
      ),
    );
  }
}
