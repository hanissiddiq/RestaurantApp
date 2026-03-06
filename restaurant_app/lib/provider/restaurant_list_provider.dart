import 'package:flutter/material.dart';
import 'package:restaurant_app/data/api/api_services.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/utils/result_state.dart';

class RestaurantListProvider extends ChangeNotifier {
  final ApiServices apiService;

  RestaurantListProvider(this.apiService) {
    fetchRestaurantList();
  }

  ResultState _state = ResultState.loading;
  ResultState get state => _state;

  List<Restaurant> _restaurants = [];
  List<Restaurant> get restaurants => _restaurants;

  String _message = '';
  String get message => _message;

  Future<void> fetchRestaurantList() async {
    try {
      _state = ResultState.loading;
      notifyListeners();

      final result = await apiService.getRestaurantList();

      if (result.restaurants.isEmpty) {
        _state = ResultState.noData;
        _message = 'Data tidak ditemukan';
      } else {
        _state = ResultState.hasData;
        _restaurants = result.restaurants;
      }
    } catch (e) {
      _state = ResultState.error;
      _message = e.toString();
    }
    notifyListeners();
  }
}
