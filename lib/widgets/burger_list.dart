import 'package:big_burger_ua/models/burger.dart';
import 'package:big_burger_ua/services/basket_provider.dart';
import 'package:big_burger_ua/services/burger_list_provider.dart';
import 'package:big_burger_ua/widgets/burger_dialog.dart';
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
                  onTap: () => BurgerDialog.productDialog(burger, context),
                ),
                const Divider(
                  thickness: 1,
                ),
              ],
            );
          }),
    );
  }

}
