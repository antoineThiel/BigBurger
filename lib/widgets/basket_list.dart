import 'package:big_burger_ua/models/burger.dart';
import 'package:big_burger_ua/services/basket_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BasketList extends StatefulWidget {
  const BasketList({super.key});

  @override
  State<BasketList> createState() => _BasketListState();
}

class _BasketListState extends State<BasketList> {
  @override
  Widget build(BuildContext context) {
    List<Map<Burger, int>> burgers =
        context.read<BasketProvider>().getFilteredBurgers();

    return ListView.builder(
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        itemCount: burgers.length,
        itemBuilder: (context, index) {
          Burger burger = burgers[index].keys.first;
          int burgerCount = burgers[index].values.first;
          return ListTile(
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
            title: Text(burger.title + " x" + burgerCount.toString()),
            subtitle: Text(
              burger.description,
              overflow: TextOverflow.ellipsis,
            ),
            trailing:
                Text(burger.priceToEurStr() + " x" + burgerCount.toString()),
            onTap: () => () {},
          );
        });
  }
}
