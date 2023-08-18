import 'package:big_burger_ua/models/burger.dart';
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
            return ListTile(
              leading: SizedBox(
                width: 50,
                height: 50,
                child: Image.network(
                  widget.burgers[index].imageUrl,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(
                      Icons.broken_image,
                      color: Colors.grey,
                      size: 50,
                    );
                  },
                ),
              ),
              title: Text(widget.burgers[index].title),
              subtitle: Text(
                widget.burgers[index].description,
                overflow: TextOverflow.ellipsis,
              ),
              trailing: Text(widget.burgers[index].priceToEurStr()),
            );
          }),
    );
  }
}
