import 'package:flutter/material.dart';
import 'package:flutter_restaurant/ui/menu/components/menu_position.dart';
import 'package:flutter_restaurant/ui/menu/menu_view_model.dart';
import 'package:flutter_restaurant/ui/menu/models/menu_model.dart';
import 'package:provider/provider.dart';

class MenuListItem extends StatefulWidget {
  final MenuModel menu;

  const MenuListItem({super.key, required this.menu});

  @override
  State<MenuListItem> createState() => _MenuListItemState();
}

class _MenuListItemState extends State<MenuListItem> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: const EdgeInsets.all(8.0),
        child: Column(children: [
          ListTile(
              title: Text(widget.menu.name),
              subtitle: Text(widget.menu.description),
              trailing:
                  Icon(_isExpanded ? Icons.expand_less : Icons.expand_more),
              onTap: () {
                setState(() {
                  _isExpanded = !_isExpanded;
                  if (_isExpanded) {
                    Provider.of<MenuViewModel>(context, listen: false)
                        .getMenuCategory(widget.menu.id);
                  }
                });
              }),
          if (_isExpanded)
            Consumer<MenuViewModel>(builder: (context, viewModel, child) {
              final categories = viewModel.menuCategories[widget.menu.id];
              print("categories: $categories");
              if (categories == null || categories.isEmpty) {
                return const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text("Brak dostępnych pozycji"));
              }

              return ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final category = categories[index];

                  return ExpansionTile(
                      title: Text(category.name),
                      subtitle: category.description != null
                          ? Text(category.description!)
                          : null,
                      children: category.positions?.map((position) {
                            return MenuPosition(menuPosition: position);
                          }).toList() ??
                          []);
                },
              );

              // return FutureBuilder(
              //   future: categories,
              //   builder: (context, snapshot) {
              //     if (snapshot.hasData) {
              //       return Column(
              //         children: snapshot.data!.map((category) {
              //           return ExpansionTile(title: Text(category.name));
              //         }).toList(),
              //       );
              //     } else if (snapshot.hasError) {
              //       return const Center(child: Text("Error"));
              //     } else {
              //       return const Center(child: CircularProgressIndicator());
              //     }
              //   },
              // );
            })
        ]));
  }
}
