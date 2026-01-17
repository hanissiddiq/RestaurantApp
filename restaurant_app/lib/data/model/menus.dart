import 'package:restaurant_app/data/model/drink.dart';
import 'package:restaurant_app/data/model/food.dart';

class Menus {
  final List<Food> foods;
  final List<Drink> drinks;

  Menus({
    required this.foods,
    required this.drinks,
  });

  factory Menus.fromJson(Map<String, dynamic> json) {
    return Menus(
      foods:
          (json["foods"] as List).map((e) => Food.fromJson(e)).toList(),
      drinks:
          (json["drinks"] as List).map((e) => Drink.fromJson(e)).toList(),
    );
  }
}
