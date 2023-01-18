import 'package:firebasedemo/src/constant/asset.dart';

import '../models/base_model.dart';
import '../models/category_model.dart';

class HomeViewModel extends BaseModel {
  List<CategoryModel> category = [
    CategoryModel(
        categoryId: 1,
        categoryImage: Asset.personalCategory,
        categoryName: 'Personal'),
    CategoryModel(
        categoryId: 2,
        categoryImage: Asset.businessCategory,
        categoryName: 'Business'),
    CategoryModel(
        categoryId: 3,
        categoryImage: Asset.shoppingCategory,
        categoryName: 'Shopping'),
    CategoryModel(
        categoryId: 4,
        categoryImage: Asset.wishListCategory,
        categoryName: 'Wishlist'),
  ];
}
