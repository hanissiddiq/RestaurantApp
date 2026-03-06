import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../model/restaurant.dart';

class DatabaseHelper {
  static DatabaseHelper? _instance;
  static SharedPreferences? _prefs;

  DatabaseHelper._internal();

  factory DatabaseHelper() => _instance ??= DatabaseHelper._internal();

  Future<void> _initPrefs() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  Future<void> insertFavorite(Restaurant restaurant) async {
    await _initPrefs();
    final favorites = await getFavorites();
    
    // Cek apakah sudah ada
    final exists = favorites.any((r) => r.id == restaurant.id);
    if (!exists) {
      favorites.add(restaurant);
      await _saveFavorites(favorites);
    }
  }

  Future<void> removeFavorite(String id) async {
    await _initPrefs();
    final favorites = await getFavorites();
    favorites.removeWhere((r) => r.id == id);
    await _saveFavorites(favorites);
  }

  Future<List<Restaurant>> getFavorites() async {
    await _initPrefs();
    final jsonString = _prefs?.getString('favorites') ?? '[]';
    final jsonList = jsonDecode(jsonString) as List;
    return jsonList.map((e) => Restaurant.fromJson(e as Map<String, dynamic>)).toList();
  }

  Future<bool> isFavorite(String id) async {
    final favorites = await getFavorites();
    return favorites.any((r) => r.id == id);
  }

  Future<void> _saveFavorites(List<Restaurant> favorites) async {
    await _initPrefs();
    final jsonList = favorites.map((r) => r.toMap()).toList();
    await _prefs?.setString('favorites', jsonEncode(jsonList));
  }
}
