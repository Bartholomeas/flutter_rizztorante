class CoreImage {
  final String id;
  final String url;
  final String? alt;
  final String? caption;

  CoreImage({
    required this.id,
    required this.url,
    this.alt,
    this.caption,
  });

  factory CoreImage.fromJson(Map<String, dynamic> json) {
    return CoreImage(
      id: json['id'] as String,
      url: json['url'] as String,
      alt: json['alt'] as String?,
      caption: json['caption'] as String?,
    );
  }
}

class MenuPositionModel {
  final String id;
  final String name;
  final int price;
  final String? description;
  final bool isVegetarian;
  final bool isVegan;
  final bool isGlutenFree;
  final CoreImage? coreImage;

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
      coreImage: json['coreImage'] != null
          ? CoreImage.fromJson(json['coreImage'] as Map<String, dynamic>)
          : null,
    );
  }
}
