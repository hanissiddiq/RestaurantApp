import 'package:flutter/material.dart';
import 'package:restaurant_app/data/api/api_services.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/utils/result_state.dart';

class RestaurantDetailProvider extends ChangeNotifier {
  final ApiServices apiService;
  final String restaurantId;

  RestaurantDetailProvider({
    required this.apiService,
    required this.restaurantId,
  }) {
    fetchRestaurantDetail();
  }

  late ResultState _state;
  ResultState get state => _state;

  late Restaurant _restaurant;
  Restaurant get restaurant => _restaurant;

  String _message = '';
  String get message => _message;

  Future<void> fetchRestaurantDetail() async {
    try {
      _state = ResultState.loading;
      notifyListeners();

      final result = await apiService.getRestaurantDetail(restaurantId);

      _state = ResultState.hasData;
      _restaurant = result.restaurant;
    } catch (e) {
      _state = ResultState.error;
      _message = e.toString();
    }
    notifyListeners();
  }
}
