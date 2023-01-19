import '../../services/dependency_assembler_education.dart';
import '../models/base_model.dart';
import 'home_view_model.dart';

class AddNewThingsModel extends BaseModel {
  void updateNotifierState() {
    notifyListeners();
  }

  String selectedCategory = 'Personal';
  int selectedCategoryId = 1;
  void onChangeCategoryValue(String value) {
    final HomeViewModel homeViewModel = dependencyAssembler<HomeViewModel>();
    selectedCategory = value;
    selectedCategoryId = homeViewModel.category
        .firstWhere((element) => element.categoryName == selectedCategory)
        .categoryId;
    notifyListeners();
  }
}
