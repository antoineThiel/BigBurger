import 'package:big_burger_ua/services/basket_provider.dart';
import 'package:big_burger_ua/services/burger_list_provider.dart';
import 'package:flutter/material.dart';
import 'package:big_burger_ua/screens/menu_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => BurgerListProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => BasketProvider(),
          ),
        ],
        child: const MenuPage(),
      ),
    );
  }
}
