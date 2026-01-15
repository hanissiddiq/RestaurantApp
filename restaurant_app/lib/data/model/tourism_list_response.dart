// todo-01-setup-02: create a api response
import 'package:restaurant_app/data/model/restaurant.dart';
// import 'package:restaurant_app/data/model/tourism.dart';

class RestaurantListResponse {
  final bool error;
  final String message;
  final int count;
  final List<Restaurant> places;

  RestaurantListResponse({
    required this.error,
    required this.message,
    required this.count,
    required this.places,
  });

  // todo-01-setup-03: dont forget to add map converter
  factory RestaurantListResponse.fromJson(Map<String, dynamic> json) {
    return RestaurantListResponse(
      error: json["error"],
      message: json["message"],
      count: json["count"],
      places: json["places"] != null
          ? List<Restaurant>.from(json["places"]!.map((x) => Restaurant.fromJson(x)))
          : <Restaurant>[],
    );
  }
}
