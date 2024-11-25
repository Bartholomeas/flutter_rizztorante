import 'package:flutter/material.dart';
import 'package:flutter_restaurant/data/network/api_provider.dart';
import 'package:flutter_restaurant/ui/menu/models/menu_model.dart';

class MenuViewModel extends ChangeNotifier {
  final _apiProvider = ApiProvider();

  List<MenuModel> menus = [];

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
}
