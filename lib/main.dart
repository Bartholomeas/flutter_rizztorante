import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_restaurant/ui/checkout/models/cart_view_model.dart';
import 'package:flutter_restaurant/ui/login/login_page.dart';
import 'package:flutter_restaurant/ui/login/login_view_model.dart';
import 'package:flutter_restaurant/ui/menu/menu_view_model.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

void main() async {
  addProviderToList();
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(const MyApp());
}

List<SingleChildWidget> providerList = [];
void addProviderToList() {
  providerList
      .add(ChangeNotifierProvider(create: (context) => LoginViewModel()));
  providerList
      .add(ChangeNotifierProvider(create: (context) => MenuViewModel()));
  providerList
      .add(ChangeNotifierProvider(create: (context) => CartViewModel()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: providerList,
        child: MaterialApp(
          title: "Rizztorante",
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              primarySwatch: Colors.amber,
              visualDensity: VisualDensity.adaptivePlatformDensity),
          home: const LoginPage(),
        ));
  }
}
