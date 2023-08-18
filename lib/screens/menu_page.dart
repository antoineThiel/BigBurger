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
      ),
      body: SafeArea(
        child: Consumer<BurgerListProvider>(
          builder: (context, burgerListProvider, child) {
            print(burgerListProvider.burgers.length);
            if (burgerListProvider.loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (burgerListProvider.hasException) {
              return const Center(
                child: ErrorFetched(),
              );
            }
            else {
              return BurgerList(burgers: burgerListProvider.burgers);
            }
          },
        ),
      ),
    );
  }
}
