class MenuPositionModel {
  final String id;
  final String name;
  final int price;
  final String? description;
  final bool isVegetarian;
  final bool isVegan;
  final bool isGlutenFree;
  final String? coreImage;

  MenuPositionModel({
    required this.id,
    required this.name,
    required this.price,
    this.description,
    required this.isVegetarian,
    required this.isVegan,
    required this.isGlutenFree,
    this.coreImage,
  });

  factory MenuPositionModel.fromJson(Map<String, dynamic> json) {
    return MenuPositionModel(
      id: json['id'],
      name: json['name'],
      price: json['price'],
      description: json['description'],
      isVegetarian: json['isVegetarian'],
      isVegan: json['isVegan'],
      isGlutenFree: json['isGlutenFree'],
      coreImage: json['coreImage'],
    );
  }
}
