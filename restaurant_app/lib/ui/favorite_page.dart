import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:restaurant_app/provider/favorite_provider.dart';
import 'package:restaurant_app/provider/detail/bookmark_list_provider.dart';
import 'package:restaurant_app/screen/detail/detail_screen.dart';

class FavoritePage extends StatefulWidget {
  static const routeName = '/favorite';

  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  void initState() {
    Future.microtask(() {
      context.read<FavoriteProvider>().loadFavorites();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Favorite Restaurant')),
      body: Consumer2<FavoriteProvider, BookmarkListProvider>(
        builder: (context, favoriteProvider, bookmarkProvider, _) {
          final favorites = favoriteProvider.favorites;
          
          if (favorites.isEmpty) {
            return const Center(child: Text('Belum ada favorit'));
          }

          return ListView.builder(
            itemCount: favorites.length,
            itemBuilder: (context, index) {
              final restaurant = favorites[index];
              return Card(
                child: ListTile(
                  leading: Image.network(
                    'https://restaurant-api.dicoding.dev/images/small/${restaurant.pictureId}',
                    width: 80,
                    fit: BoxFit.cover,
                  ),
                  title: Text(restaurant.name),
                  subtitle: Text(
                      '${restaurant.city} • ⭐ ${restaurant.rating}'),
                  trailing: IconButton(
                    icon: const Icon(Icons.favorite, color: Colors.red),
                    onPressed: () async {
                      await favoriteProvider.removeFavorite(restaurant.id);
                      bookmarkProvider.removeBookmark(restaurant);
                    },
                  ),
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      DetailScreen.routeName,
                      arguments: restaurant.id,
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
