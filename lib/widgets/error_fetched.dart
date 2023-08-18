import 'package:big_burger_ua/services/burger_list_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ErrorFetched extends StatefulWidget {
  const ErrorFetched({super.key});

  @override
  State<ErrorFetched> createState() => _ErrorFetchedState();
}

class _ErrorFetchedState extends State<ErrorFetched> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("An error occured while fetching data, please retry"),
        ElevatedButton(
          onPressed: () {
            context.read<BurgerListProvider>().getBurgers();
          },
          child: const Text("Retry"),
        ),
      ],
    );
  }
}
