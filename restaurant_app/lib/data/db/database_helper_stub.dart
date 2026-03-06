import '../model/restaurant.dart';

/// Interface/Contract untuk DatabaseHelper
/// Implementasi berbeda untuk native dan web
abstract class DatabaseHelper {
  factory DatabaseHelper() {
    throw UnsupportedError('Platform tidak didukung');
  }

  Future<void> insertFavorite(Restaurant restaurant);
  
  Future<void> removeFavorite(String id);
  
  Future<List<Restaurant>> getFavorites();
  
  Future<bool> isFavorite(String id);
}
