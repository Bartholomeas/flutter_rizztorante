import 'package:flutter/material.dart';
import 'package:flutter_restaurant/ui/checkout/models/cart_view_model.dart';
import 'package:flutter_restaurant/ui/menu/models/menu_position_model.dart';
import 'package:provider/provider.dart';
import 'package:flutter_restaurant/ui/menu/pages/menu_position_details_page.dart';

class MenuPosition extends StatelessWidget {
  final MenuPositionModel menuPosition;

  const MenuPosition({super.key, required this.menuPosition});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (menuPosition.coreImage?.url != null)
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                menuPosition.coreImage!.url,
                width: 60,
                height: 60,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: 60,
                    height: 60,
                    color: Colors.grey[200],
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.image_not_supported,
                            size: 24, color: Colors.grey),
                        Text(
                          'Brak zdjęcia',
                          style: TextStyle(
                            fontSize: 8,
                            color: Colors.grey[600],
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  );
                },
              ),
            )
          else
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.restaurant, color: Colors.grey),
            ),
          const SizedBox(width: 12),

          // Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title and Price Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        menuPosition.name,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Text(
                      '${(menuPosition.price / 100).toStringAsFixed(2)} PLN',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                if (menuPosition.description != null) ...[
                  const SizedBox(height: 4),
                  Text(
                    menuPosition.description!,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
                const SizedBox(height: 8),

                Row(
                  children: [
                    Expanded(
                      child: Wrap(
                        spacing: 8,
                        children: [
                          if (menuPosition.isVegetarian)
                            _buildTag('Wege', Colors.green),
                          if (menuPosition.isGlutenFree)
                            _buildTag('Bezglutenowe', Colors.blue),
                          if (menuPosition.isVegan)
                            _buildTag('Vegan', Colors.green[700]!),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MenuPositionDetailsPage(
                                  positionId: menuPosition.id,
                                ),
                              ),
                            );
                          },
                          child: const Text('Szczegóły'),
                        ),
                        const SizedBox(width: 8),
                        ElevatedButton.icon(
                          onPressed: () {
                            context
                                .read<CartViewModel>()
                                .addToCart(menuPosition);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                    "Dodano ${menuPosition.name} do koszyka"),
                              ),
                            );
                          },
                          icon: const Icon(
                            Icons.add_shopping_cart,
                            size: 14,
                            color: Colors.white,
                          ),
                          label: const Text(
                            'Dodaj do koszyka',
                            style: TextStyle(color: Colors.white),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Theme.of(context).primaryColor,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            textStyle: const TextStyle(fontSize: 10),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTag(String text, Color color) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        border: Border.all(color: color),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontSize: 10,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
