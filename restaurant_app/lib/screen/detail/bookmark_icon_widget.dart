import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/provider/detail/bookmark_list_provider.dart';
import 'package:restaurant_app/provider/detail/bookmark_icon_provider.dart';
import 'package:restaurant_app/provider/favorite_provider.dart';

class BookmarkIconWidget extends StatefulWidget {
  final Restaurant restaurant;

  const BookmarkIconWidget({
    super.key,
    required this.restaurant,
  });

  @override
  State<BookmarkIconWidget> createState() => _BookmarkIconWidgetState();
}

class _BookmarkIconWidgetState extends State<BookmarkIconWidget> {
  @override
  void initState() {
    final bookmarkIconProvider = context.read<BookmarkIconProvider>();
    final favoriteProvider = context.read<FavoriteProvider>();

    Future.microtask(() async {
      final isFav = await bookmarkIconProvider.databaseHelper.isFavorite(widget.restaurant.id);
      bookmarkIconProvider.isBookmarked = isFav;
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer3<BookmarkIconProvider, BookmarkListProvider, FavoriteProvider>(
      builder: (context, iconProvider, listProvider, favoriteProvider, child) {
        final isFavorite = iconProvider.isBookmarked;

        return IconButton(
          icon: Icon(
            isFavorite ? Icons.favorite : Icons.favorite_border,
            color: Colors.red,
          ),
          onPressed: () async {
            final newFavoriteState = !isFavorite;
            
            await iconProvider.toggleBookmark(widget.restaurant);
            
            if (newFavoriteState) {
              listProvider.addBookmark(widget.restaurant);
            } else {
              listProvider.removeBookmark(widget.restaurant);
            }
            
            await favoriteProvider.loadFavorites();
            iconProvider.isBookmarked = newFavoriteState;
          },
        );
      },
    );
  }
}
