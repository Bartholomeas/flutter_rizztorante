class CartResponse {
  final List<CartItemResponse> items;
  final double total;

  CartResponse({
    required this.items,
    required this.total,
  });

  factory CartResponse.fromJson(Map<String, dynamic> json) {
    return CartResponse(
      items: (json['items'] as List)
          .map((item) => CartItemResponse.fromJson(item))
          .toList(),
      total: json['total'].toDouble(),
    );
  }
}

class CartItemResponse {
  final String id;
  final String menuPositionId;
  final String name;
  final int price;
  final int quantity;
  final String? imageUrl;

  CartItemResponse({
    required this.id,
    required this.menuPositionId,
    required this.name,
    required this.price,
    required this.quantity,
    this.imageUrl,
  });

  factory CartItemResponse.fromJson(Map<String, dynamic> json) {
    return CartItemResponse(
      id: json['id'],
      menuPositionId: json['menuPositionId'],
      name: json['name'],
      price: json['price'],
      quantity: json['quantity'],
      imageUrl: json['imageUrl'],
    );
  }
}
