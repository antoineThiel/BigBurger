import 'package:big_burger_ua/screens/basket_page.dart';
import 'package:big_burger_ua/services/basket_provider.dart';
import 'package:big_burger_ua/services/burger_list_provider.dart';
import 'package:flutter/material.dart';
import 'package:big_burger_ua/screens/menu_page.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}


final GoRouter _router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const MenuPage();
      },
      routes: <RouteBase>[
        GoRoute(
          path: 'basket',
          builder: (BuildContext context, GoRouterState state) {
            return const BasketPage();
          },
        ),
      ],
    ),
  ],
);

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
    providers: [
          ChangeNotifierProvider(
            create: (context) => BurgerListProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => BasketProvider(),
          ),
        ],
    child: MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'BigBurger UA',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routerConfig: _router,
    ),
    );
  }
}
