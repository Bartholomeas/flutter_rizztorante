import 'package:flutter/material.dart';
import 'package:flutter_restaurant/ui/menu/models/menu_position_model.dart';

class CartItem {
  final String id;
  final MenuPositionModel menuPosition;
  int quantity;

  CartItem({
    required this.id,
    required this.menuPosition,
    this.quantity = 1,
  });

  double get total => menuPosition.price * quantity / 100;
}

class CartViewModel extends ChangeNotifier {
  final Map<String, CartItem> _items = {};
  
  List<CartItem> get items => _items.values.toList();
  
  double get total => items.fold(0, (sum, item) => sum + item.total);

  void addToCart(MenuPositionModel menuPosition) {
    if (_items.containsKey(menuPosition.id)) {
      _items[menuPosition.id]!.quantity++;
    } else {
      _items[menuPosition.id] = CartItem(
        id: DateTime.now().toString(),
        menuPosition: menuPosition,
      );
    }
    notifyListeners();
  }

  void removeFromCart(String menuPositionId) {
    _items.remove(menuPositionId);
    notifyListeners();
  }

  void updateQuantity(String menuPositionId, int quantity) {
    if (_items.containsKey(menuPositionId)) {
      if (quantity <= 0) {
        _items.remove(menuPositionId);
      } else {
        _items[menuPositionId]!.quantity = quantity;
      }
      notifyListeners();
    }
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }
}
