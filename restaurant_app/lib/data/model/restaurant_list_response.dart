// todo-01-setup-02: create a api response
import 'package:restaurant_app/data/model/restaurant.dart';
// import 'package:restaurant_app/data/model/tourism.dart';

class RestaurantListResponse {
  final bool error;
  final String message;
  final int count;
  final List<Restaurant> restaurants;

  RestaurantListResponse({
    required this.error,
    required this.message,
    required this.count,
    required this.restaurants,
  });

  // todo-01-setup-03: dont forget to add map converter
  factory RestaurantListResponse.fromJson(Map<String, dynamic> json) {
    return RestaurantListResponse(
      error: json["error"],
      message: json["message"],
      count: json["count"],
      restaurants: json["restaurants"] != null
          ? List<Restaurant>.from(
              json["restaurants"].map((x) => Restaurant.fromJson(x)))
          : [],
    );
  }
}
