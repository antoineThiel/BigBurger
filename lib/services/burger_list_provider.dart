import 'package:big_burger_ua/models/burger.dart';
import 'package:big_burger_ua/services/api_service.dart';
import 'package:flutter/material.dart';

class BurgerListProvider extends ChangeNotifier {
  List<Burger> burgers = [];
  bool loading = true;
  ApiService apiService = ApiService();
  bool hasException = false;

  Future<void> getBurgers() async {
    loading = true;
    notifyListeners();

    try {
      burgers = await apiService.getBurgers();
      hasException = false;
    } catch (e) {
      hasException = true;
    }

    loading = false;
    notifyListeners();
  }
}
