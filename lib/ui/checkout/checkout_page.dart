import 'package:flutter/material.dart';
import 'package:flutter_restaurant/ui/checkout/models/cart_view_model.dart';
import 'package:provider/provider.dart';

class CheckoutPage extends StatelessWidget {
  const CheckoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CartViewModel>(
      builder: (context, cartViewModel, child) {
        if (cartViewModel.items.isEmpty) {
          return const Center(child: Text("Koszyk jest pusty"));
        }

        return Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: cartViewModel.items.length,
                itemBuilder: (context, index) {
                  final item = cartViewModel.items[index];
                  return ListTile(
                    leading: item.menuPosition.coreImage?.url != null
                        ? Image.network(
                            item.menuPosition.coreImage!.url,
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                width: 50,
                                height: 50,
                                color: Colors.grey[200],
                                child: const Icon(Icons.image_not_supported,
                                    color: Colors.grey),
                              );
                            },
                          )
                        : Container(
                            width: 50,
                            height: 50,
                            color: Colors.grey[200],
                            child: const Icon(Icons.restaurant,
                                color: Colors.grey),
                          ),
                    title: Text(item.menuPosition.name),
                    subtitle: Text("${item.total.toStringAsFixed(2)} PLN"),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.remove),
                          onPressed: () => cartViewModel.updateQuantity(
                              item.menuPosition.id, item.quantity - 1),
                        ),
                        Text("${item.quantity}"),
                        IconButton(
                          icon: const Icon(Icons.add),
                          onPressed: () => cartViewModel.updateQuantity(
                              item.menuPosition.id, item.quantity + 1),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: const Offset(0, -3),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Suma: ${cartViewModel.total.toStringAsFixed(2)} PLN',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // TODO: Implement checkout
                    },
                    child: const Text('Zamów'),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
