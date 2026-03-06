import 'package:restaurant_app/data/model/category.dart';
import 'package:restaurant_app/data/model/menus.dart';
import 'package:restaurant_app/data/model/customer_review.dart';


class Restaurant {
  final String id;
  final String name;
  final String description;
  final String pictureId;
  final String city;
  final double rating;
  final Menus? menus;
  final String? address;
  final List<CustomerReview> customerReviews;

  Restaurant({
    required this.id,
    required this.name,
    required this.description,
    required this.pictureId,
    required this.city,
    required this.rating,
    this.menus,
    this.address,
    this.customerReviews = const [],
  });

  factory Restaurant.fromJson(Map<String, dynamic> json) {
    return Restaurant(
      id: json["id"] ?? '',
      name: json["name"] ?? '',
      description: json["description"] ?? '',
      pictureId: json["pictureId"] ?? '',
      city: json["city"] ?? '',
      address: json["address"],
      rating: (json["rating"] as num?)?.toDouble() ?? 0.0,
      menus: json["menus"] != null ? Menus.fromJson(json["menus"]) : null,
    );
  }

  

  /// ✅ KHUSUS SQLITE & SHARED_PREFERENCES
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'pictureId': pictureId,
      'city': city,
      'address': address,
      'rating': rating,
    };
  }



}