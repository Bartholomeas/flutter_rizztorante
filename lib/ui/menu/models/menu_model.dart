class MenuModel {
  final String id;
  final String name;
  final String slug;
  final String description;

  MenuModel({
    required this.id,
    required this.name,
    required this.slug,
    required this.description,
  });

  factory MenuModel.fromJson(Map<String, dynamic> json) {
    return MenuModel(
      id: json['id'],
      name: json['name'],
      slug: json['slug'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'slug': slug,
      'description': description,
    };
  }
}
