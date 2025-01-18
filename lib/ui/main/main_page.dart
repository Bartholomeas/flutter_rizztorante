import 'package:flutter/material.dart';
import 'package:flutter_restaurant/ui/checkout/checkout_page.dart';
import 'package:flutter_restaurant/ui/menu/menu_content.dart';
import 'package:flutter_restaurant/ui/menu/menu_view_model.dart';
import 'package:provider/provider.dart';
import 'package:flutter_restaurant/data/network/api_provider.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;
  final _apiProvider = ApiProvider();

  final List<Widget> _pages = [
    const MenuContent(),
    const CheckoutPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Future<void> _handleLogout() async {
    try {
      await _apiProvider.logout();
    } finally {
      if (mounted) {
        Navigator.of(context)
            .pushNamedAndRemoveUntil('/login', (route) => false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_selectedIndex == 0 ? "Wybierz pozycję z menu" : "Koszyk"),
        actions: [
          if (_selectedIndex == 0)
            IconButton(
              onPressed: () => context.read<MenuViewModel>().getMenu(),
              icon: const Icon(Icons.refresh),
            )
        ],
      ),
      body: IndexedStack(index: _selectedIndex, children: _pages),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.restaurant),
            label: "Menu",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: "Koszyk",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.logout),
            label: "Wyloguj się",
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Theme.of(context).primaryColor,
        onTap: (index) {
          if (index == 2) {
            _handleLogout();
          } else {
            _onItemTapped(index);
          }
        },
      ),
    );
  }
}
