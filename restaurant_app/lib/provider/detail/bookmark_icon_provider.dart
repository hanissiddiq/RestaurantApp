import 'package:flutter/widgets.dart';
import 'package:restaurant_app/data/db/database_helper.dart';
import 'package:restaurant_app/data/model/restaurant.dart';

class BookmarkIconProvider extends ChangeNotifier {
  bool _isBookmarked = false;
  final DatabaseHelper databaseHelper = DatabaseHelper();

  bool get isBookmarked => _isBookmarked;

  set isBookmarked(bool value) {
    _isBookmarked = value;
    notifyListeners();
  }

  Future<void> toggleBookmark(Restaurant restaurant) async {
    final isFav = await databaseHelper.isFavorite(restaurant.id);

    if (isFav) {
      await databaseHelper.removeFavorite(restaurant.id);
    } else {
      await databaseHelper.insertFavorite(restaurant);
    }

    notifyListeners();
  }
}
