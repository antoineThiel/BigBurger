import 'package:big_burger_ua/services/burger_list_provider.dart';
import 'package:big_burger_ua/widgets/burger_list.dart';
import 'package:big_burger_ua/widgets/error_fetched.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Provider.of<BurgerListProvider>(context, listen: false)
          .getBurgers();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("BIG BURGER"),
        actions: [
          IconButton(
            onPressed: () {
              context.go('/basket');
            },
            icon: const Icon(Icons.shopping_cart),
          ),
        ],
      ),
      body: SafeArea(
        child: Consumer<BurgerListProvider>(
          builder: (context, burgerListProvider, child) {
            if (burgerListProvider.loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (burgerListProvider.hasException) {
              return const Center(
                child: ErrorFetched(),
              );
            } else {
              return BurgerList(burgers: burgerListProvider.burgers);
            }
          },
        ),
      ),
    );
  }
}
