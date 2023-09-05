import 'package:flutter/material.dart';
import 'package:big_burger_ua/models/burger.dart';
import 'package:provider/provider.dart';
import '../services/basket_provider.dart';

class BurgerDialog {
  static void productDialog(Burger burger, BuildContext context) {
    BasketProvider basketProvider = context.read<BasketProvider>();
    basketProvider.resetTmpQuantity();
    showDialog(
      context: context,
      builder: (_) => ChangeNotifierProvider<BasketProvider>.value(
        value: basketProvider,
        child: AlertDialog(
          title: Text(burger.title),
          content: SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            height: MediaQuery.of(context).size.height * 0.3,
            child: Column(
              children: [
                Row(
                  children: [
                    Image.network(
                      burger.imageUrl,
                      width: 50,
                      height: 50,
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(
                          Icons.broken_image,
                          color: Colors.grey,
                          size: 50,
                        );
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 12.0, right: 8.0),
                      child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.45,
                          child: Text(
                            burger.description,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 8,
                          )),
                    ),
                  ],
                ),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(burger.priceToEurStr()),
                  ],
                ),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: const CircleBorder(),
                        ),
                        onPressed: () {
                          context.read<BasketProvider>().removeTmpQuantity();
                        },
                        child: const Text("-")),
                    Consumer<BasketProvider>(
                      builder: (context, basketProvider, child) {
                        return Text(
                          basketProvider.tmpQuantity.toString(),
                          style: const TextStyle(fontSize: 20),
                        );
                      },
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: const CircleBorder(),
                        ),
                        onPressed: () {
                          context.read<BasketProvider>().addTmpQuantity();
                        },
                        child: const Text("+")),
                  ],
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Fermer"),
            ),
            TextButton(
              onPressed: () {
                context.read<BasketProvider>().addBurger(burger);
                Navigator.pop(context);
              },
              child: const Text("Ajouter au Panier"),
            ),
          ],
        ),
      ),
    );
  }
}

