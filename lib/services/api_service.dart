import 'dart:convert';

import 'package:big_burger_ua/models/burger.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class ApiService {
  String baseUrl = "https://uad.io";

  Future<List<Burger>> getBurgers() async {
    Response response = await http.get(Uri.parse("$baseUrl/bigburger"));
    if (response.statusCode == 200) {
      var burgers = jsonDecode(response.body) as List;
      return burgers.map((burger) => Burger.fromJson(burger)).toList();
    } else {
      throw Exception("Failed to load burgers");
    }
  }
}
