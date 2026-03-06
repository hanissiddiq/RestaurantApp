import 'package:flutter/foundation.dart';

import '../data/db/database_helper.dart';
import '../data/model/restaurant.dart';

class FavoriteProvider extends ChangeNotifier {
  final DatabaseHelper dbHelper = DatabaseHelper();

  List<Restaurant> _favorites = [];
  List<Restaurant> get favorites => _favorites;

  Future<void> loadFavorites() async {
    _favorites = await dbHelper.getFavorites();
    notifyListeners();
  }

  Future<void> addFavorite(Restaurant restaurant) async {
    await dbHelper.insertFavorite(restaurant);
    loadFavorites();
  }

  Future<void> removeFavorite(String id) async {
    await dbHelper.removeFavorite(id);
    loadFavorites();
  }
}
