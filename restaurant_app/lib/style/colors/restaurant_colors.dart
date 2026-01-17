import 'package:flutter/material.dart';

enum RestaurantColors {
  blue("Blue", Color.fromARGB(255, 19, 197, 167));

  const RestaurantColors(this.name, this.color);

  final String name;
  final Color color;
}
