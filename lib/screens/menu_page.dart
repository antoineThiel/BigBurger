import 'package:big_burger_ua/models/burger.dart';
import 'package:big_burger_ua/services/api_service.dart';
import 'package:big_burger_ua/services/burger_list_provider.dart';
import 'package:big_burger_ua/widgets/burger_list.dart';
import 'package:big_burger_ua/widgets/error_fetched.dart';
import 'package:flutter/material.dart';
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
    context.read<BurgerListProvider>().getBurgers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("BIG BURGER"),
      ),
      body: SafeArea(
        child: Consumer<BurgerListProvider>(
          builder: (context, burgerListProvider, child) {
            if (burgerListProvider.loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return const Center(
              child: Text("Hello"),
            );
            // if (burgerListProvider.hasException) {
            //   return const Center(
            //     child: ErrorFetched(),
            //   );
            // }
            // else {
            //   return BurgerList(burgers: burgerListProvider.burgers);
            // }
          },
        ),
      ),
    );
  }
}
