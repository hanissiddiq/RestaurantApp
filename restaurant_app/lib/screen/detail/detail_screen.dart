import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/api/api_services.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/data/model/restaurant_detail_response.dart';
import 'package:restaurant_app/provider/detail/bookmark_icon_provider.dart';
import 'package:restaurant_app/screen/detail/body_of_detail_screen_widget.dart';
import 'package:restaurant_app/screen/detail/bookmark_icon_widget.dart';

// todo-04-detail-05: make this widget StatefulWidget
class DetailScreen extends StatefulWidget {
  // todo-04-detail-04: you can change this parameter into int value
  final String restaurantId;

  const DetailScreen({
    super.key,
    required this.restaurantId,
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  // todo-04-detail-06: create a local variable for late tourism and Future
  final Completer<Restaurant> _completerRestaurant = Completer<Restaurant>();
  late Future<RestaurantDetailResponse> _futureRestaurantDetail;
  bool _isCompleterCompleted = false;

  // todo-04-detail-07: initialize a Future in initState
  @override
  void initState() {
    super.initState();

    _futureRestaurantDetail = ApiServices().getRestaurantDetail(widget.restaurantId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Restaurant Detail"),
        actions: [
          ChangeNotifierProvider(
            create: (context) => BookmarkIconProvider(),
            // todo-04-detail-11: change this widget using FutureBuilder
            child: FutureBuilder(
                future: _completerRestaurant.future,
                builder: (context, snapshot) {
                  return switch (snapshot.connectionState) {
                    ConnectionState.done =>
                      BookmarkIconWidget(restaurant: snapshot.data!),
                    _ => const SizedBox(),
                  };
                }),
          ),
        ],
      ),
      // todo-04-detail-08: to make it easy, create a new widget below
      // todo-04-detail-09: create a FutureBuilder
      body: FutureBuilder<RestaurantDetailResponse>(
  future: _futureRestaurantDetail,
  builder: (context, snapshot) {
    switch (snapshot.connectionState) {
      case ConnectionState.waiting:
        return const Center(
          child: CircularProgressIndicator(),
        );
      case ConnectionState.done:
        if (snapshot.hasError) {
          return Center(
            child: Text(snapshot.error.toString()),
          );
        }

        if (!snapshot.hasData) {
          return const Center(
            child: Text('Data restoran tidak ditemukan'),
          );
        }

        final restaurantData = snapshot.data!.restaurant;

        if (!_isCompleterCompleted) {
          _completerRestaurant.complete(restaurantData);
          _isCompleterCompleted = true;
        }

        return BodyOfDetailScreenWidget(
          restaurant: restaurantData,
        );
      default:
        return const SizedBox();
    }
  },
),

    );
  }
}
