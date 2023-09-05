import 'package:big_burger_ua/models/burger.dart';
import 'package:flutter/material.dart';

class BasketProvider extends ChangeNotifier {
  List<Burger> burgers = [];
  double totalPrice = 0;
  int tmpQuantity = 1;

  void addBurger(Burger burger) {
    for (int i = 0; i < tmpQuantity; i++) {
      burgers.add(burger);
      totalPrice += burger.priceToEur();
    }
    notifyListeners();
    print(burgers.length);
    print(totalPrice);
  }

  void removeBurger(Burger burger) {
    burgers.remove(burger);
    totalPrice -= burger.price;
    notifyListeners();
  }

  void clearBasket() {
    burgers.clear();
    totalPrice = 0;
    notifyListeners();
  }

  int getBurgerCount() {
    return burgers.length;
  }

  bool isBurgerInBasket(Burger burger) {
    return burgers.contains(burger);
  }

  bool isBasketEmpty() {
    return burgers.isEmpty;
  }

  String getTotalPriceStr() {
    return totalPrice.toStringAsFixed(2);
  }

  String getTotalPriceToEurStr() {
    return totalPrice.toStringAsFixed(2) + " €";
  }

  void addTmpQuantity() {
    tmpQuantity++;
    notifyListeners();
  }

  void removeTmpQuantity() {
    if (tmpQuantity > 1) {
      tmpQuantity--;
    }
    notifyListeners();
  }

  void resetTmpQuantity() {
    tmpQuantity = 1;
    notifyListeners();
  }

  List<Map<Burger, int>> getFilteredBurgers() {
    List<Map<Burger, int>> filteredBurgers = [];
    for (Burger burger in burgers) {
      bool found = false;
      for (Map<Burger, int> filteredBurger in filteredBurgers) {
        if (filteredBurger.containsKey(burger)) {
          filteredBurger[burger] = filteredBurger[burger]! + 1;
          found = true;
          break;
        }
      }
      if (!found) {
        filteredBurgers.add({burger: 1});
      }
    }
    return filteredBurgers;
  }
}
