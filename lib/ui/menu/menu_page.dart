import 'package:flutter/material.dart';
import 'package:flutter_restaurant/ui/menu/components/menu_list_item.dart';
import 'package:flutter_restaurant/ui/menu/menu_view_model.dart';
import 'package:provider/provider.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => context.read<MenuViewModel>().getMenu(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MenuViewModel(),
      child: initView(context),
    );
  }
}

Widget initView(BuildContext context) {
  MenuViewModel menuViewModel = Provider.of<MenuViewModel>(context);
  return Scaffold(
    appBar: AppBar(title: const Text("Wybierz pozycje z menu")),
    body: Builder(builder: (context) {
      return ListView.builder(
        itemCount: menuViewModel.menus.length,
        itemBuilder: (context, index) {
          final menu = menuViewModel.menus[index];
          return MenuListItem(menu: menu);
        },
      );
    }),
  );
}
