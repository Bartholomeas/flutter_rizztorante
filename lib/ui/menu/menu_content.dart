import 'package:flutter/material.dart';
import 'package:flutter_restaurant/ui/menu/components/menu_list_item.dart';
import 'package:flutter_restaurant/ui/menu/menu_view_model.dart';
import 'package:provider/provider.dart';

class MenuContent extends StatefulWidget {
  const MenuContent({super.key});

  @override
  State<MenuContent> createState() => _MenuContentState();
}

class _MenuContentState extends State<MenuContent> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => context.read<MenuViewModel>().getMenu(),
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return ChangeNotifierProvider(
  //     create: (context) => MenuViewModel(),
  //     child: initView(context),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Consumer<MenuViewModel>(builder: (context, menuViewModel, child) {
      // if (menuViewModel.apiState == ApiState.loading &&
      //     menuViewModel.menus.isEmpty) {
      //   return const Center(child: CircularProgressIndicator());
      // }

      return ListView.builder(
        itemCount: menuViewModel.menus.length,
        itemBuilder: (context, index) {
          final menu = menuViewModel.menus[index];
          return MenuListItem(menu: menu);
        },
      );
    });
  }
}
