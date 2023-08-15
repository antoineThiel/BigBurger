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
    print("builded");
    return RefreshIndicator(
      onRefresh: () {
        return context.read<BurgerListProvider>().getBurgers();
      },
      child: ListView.builder(
          itemCount: widget.burgers.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(widget.burgers[index].title),
              subtitle: Text(widget.burgers[index].description),
              trailing: Text(widget.burgers[index].price.toString()),
            );
          }),
    );
  }
}
