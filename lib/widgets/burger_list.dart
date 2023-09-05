import 'package:big_burger_ua/models/burger.dart';
import 'package:big_burger_ua/services/basket_provider.dart';
import 'package:big_burger_ua/services/burger_list_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BurgerList extends StatefulWidget {
  final List<Burger> burgers;
  const BurgerList({super.key, required this.burgers});

  @override
  State<BurgerList> createState() => _BurgerListState();
}

class _BurgerListState extends State<BurgerList> {
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () {
        return context.read<BurgerListProvider>().getBurgers();
      },
      child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: widget.burgers.length,
          itemBuilder: (context, index) {
            Burger burger = widget.burgers[index];
            return Column(
              children: [
                ListTile(
                  leading: SizedBox(
                    width: 50,
                    height: 50,
                    child: Image.network(
                      burger.imageUrl,
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(
                          Icons.broken_image,
                          color: Colors.grey,
                          size: 50,
                        );
                      },
                    ),
                  ),
                  title: Text(burger.title),
                  subtitle: Text(
                    burger.description,
                    overflow: TextOverflow.ellipsis,
                  ),
                  trailing: Text(burger.priceToEurStr()),
                  onTap: () => productDialog(burger),
                ),
                const Divider(
                  thickness: 1,
                ),
              ],
            );
          }),
    );
  }

  void productDialog(Burger burger) {
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
