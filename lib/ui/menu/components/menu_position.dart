import 'package:flutter/material.dart';
import 'package:flutter_restaurant/ui/menu/models/menu_position_model.dart';

class MenuPosition extends StatelessWidget {
  final MenuPositionModel menuPosition;

  const MenuPosition({super.key, required this.menuPosition});

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: const EdgeInsets.all(8.0),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(menuPosition.name,
                    style: Theme.of(context).textTheme.titleLarge),
                Text("${menuPosition.price} PLN",
                    style: Theme.of(context).textTheme.titleMedium)
              ],
            ),
            if (menuPosition.description != null)
              Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(menuPosition.description!,
                      style: Theme.of(context).textTheme.bodyMedium)),
            Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Wrap(spacing: 8.0, children: [
                  if (menuPosition.isVegetarian)
                    const Chip(label: Text("Wege")),
                  if (menuPosition.isVegan)
                    const Chip(label: Text("Wegańskie")),
                  if (menuPosition.isGlutenFree)
                    const Chip(label: Text("Bezglutenowe"))
                ]))
          ]),
        ));
  }
}
