import 'package:big_burger_ua/services/basket_provider.dart';
import 'package:big_burger_ua/widgets/basket_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BasketPage extends StatefulWidget {
  const BasketPage({super.key});

  @override
  State<BasketPage> createState() => _BasketPageState();
}

class _BasketPageState extends State<BasketPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Votre Panier"),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            BasketList(),
            InkWell(
              onTap: () {},
              child: Container(
                height: 50,
                width: MediaQuery.of(context).size.width,
                color: Colors.green,
                child: Center(
                  child: Text(
                    "Commander pour ${context.read<BasketProvider>().getTotalPriceToEurStr()}",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
