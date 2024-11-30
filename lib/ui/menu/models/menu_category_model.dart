import 'package:flutter_restaurant/ui/menu/models/menu_position_model.dart';

class MenuCategoryModel {
  final String id;
  final String name;
  final String? description;
  final List<MenuPositionModel>? positions;

  MenuCategoryModel({
    required this.id,
    required this.name,
    this.description,
    required this.positions,
  });

  factory MenuCategoryModel.fromJson(Map<String, dynamic> json) {
    return MenuCategoryModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      positions: (json['positions'] as List?)
              ?.map((e) => MenuPositionModel.fromJson(e))
              .toList() ??
          [],
    );
  }
}
