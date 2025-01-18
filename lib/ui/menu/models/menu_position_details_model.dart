import 'package:flutter_restaurant/ui/menu/models/menu_position_model.dart';

class NutritionalInfo {
  final int? protein;
  final int? carbs;
  final int? fat;

  NutritionalInfo({
    this.protein,
    this.carbs,
    this.fat,
  });

  factory NutritionalInfo.fromJson(Map<String, dynamic> json) {
    return NutritionalInfo(
      protein: json['protein'] as int?,
      carbs: json['carbs'] as int?,
      fat: json['fat'] as int?,
    );
  }
}

class MenuPositionDetails {
  final String id;
  final String? longDescription;
  final int? calories;
  final List<String> allergens;
  final NutritionalInfo? nutritionalInfo;
  final MenuPositionModel menuPosition;
  final List<String> images;

  MenuPositionDetails({
    required this.id,
    this.longDescription,
    this.calories,
    required this.allergens,
    this.nutritionalInfo,
    required this.menuPosition,
    required this.images,
  });

  factory MenuPositionDetails.fromJson(Map<String, dynamic> json) {
    return MenuPositionDetails(
      id: json['id'] as String,
      longDescription: json['longDescription'] as String?,
      calories: json['calories'] as int?,
      allergens: (json['allergens'] as List?)?.cast<String>() ?? [],
      nutritionalInfo: json['nutritionalInfo'] != null
          ? NutritionalInfo.fromJson(json['nutritionalInfo'])
          : null,
      menuPosition: MenuPositionModel.fromJson(json['menuPosition']),
      images: (json['images'] as List?)?.cast<String>() ?? [],
    );
  }
}
