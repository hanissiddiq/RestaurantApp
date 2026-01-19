import 'dart:async';

import 'package:flutter/material.dart';
import 'package:restaurant_app/data/api/api_services.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/data/model/restaurant_detail_response.dart';
import 'package:restaurant_app/provider/detail/bookmark_icon_provider.dart';
import 'package:restaurant_app/screen/detail/body_of_detail_screen_widget.dart';
import 'package:restaurant_app/screen/detail/bookmark_icon_widget.dart';

import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/restaurant_detail_provider.dart';
import 'package:restaurant_app/screen/detail/body_of_detail_screen_widget.dart';
import 'package:restaurant_app/utils/result_state.dart';

// todo-04-detail-05: make this widget StatefulWidget
class DetailScreen extends StatelessWidget {
  static const routeName = '/detail';

  final String restaurantId;

  const DetailScreen({super.key, required this.restaurantId});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => RestaurantDetailProvider(
        apiService: ApiServices(),
        restaurantId: restaurantId,
      ),
      child: Scaffold(
        appBar: AppBar(),
        body: Consumer<RestaurantDetailProvider>(
          builder: (context, state, _) {
            if (state.state == ResultState.loading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state.state == ResultState.hasData) {
              return BodyOfDetailScreenWidget(
                restaurant: state.restaurant,
              );
            } else {
              return Center(child: Text(state.message));
            }
          },
        ),
      ),
    );
  }
}
