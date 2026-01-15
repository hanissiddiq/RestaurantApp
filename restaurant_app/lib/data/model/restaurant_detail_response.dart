// todo-04-detail-01: create a class for api response
import 'package:restaurant_app/data/model/tourism.dart';
import 'package:restaurant_app/data/model/restaurant.dart';

class RestaurantDetailResponse {
  final bool error;
  final String message;
  final Restaurant restaurant;

  RestaurantDetailResponse({
    required this.error,
    required this.message,
    required this.restaurant,
  });

  // todo-04-detail-02: dont forget to add map converter
  factory RestaurantDetailResponse.fromJson(Map<String, dynamic> json) {
    return RestaurantDetailResponse(
      error: json["error"],
      message: json["message"],
      restaurant: Restaurant.fromJson(json["restaurant"]),
    );
  }
}
