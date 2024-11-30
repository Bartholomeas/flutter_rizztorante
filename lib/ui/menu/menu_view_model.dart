import 'package:flutter/material.dart';
import 'package:flutter_restaurant/data/network/api_provider.dart';
import 'package:flutter_restaurant/ui/menu/models/menu_category_model.dart';
import 'package:flutter_restaurant/ui/menu/models/menu_model.dart';

class MenuViewModel extends ChangeNotifier {
  final _apiProvider = ApiProvider();

  List<MenuModel> menus = [];
  Map<String, List<MenuCategoryModel>> menuCategories = {};

  Future<List<MenuModel>> getMenu() async {
    try {
      var response = await _apiProvider.getMenus();
      menus = response.map((json) => MenuModel.fromJson(json)).toList();

      notifyListeners();
      return menus;
    } catch (err) {
      notifyListeners();
      rethrow;
    }
  }

  Future<List<MenuCategoryModel>> getMenuCategory(String menuId) async {
    try {
      if (menuCategories.containsKey(menuId)) {
        return menuCategories[menuId]!;
      }

      notifyListeners();

      var response = await _apiProvider.getMenuCategory(menuId);
      final categories =
          response.map((json) => MenuCategoryModel.fromJson(json)).toList();

      menuCategories[menuId] = categories;

      notifyListeners();

      return categories;
    } catch (err) {
      notifyListeners();
      rethrow;
    }
  }
}
