import 'package:flutter/material.dart';
import 'package:restaurant_app/data/api/api_services.dart';
import 'package:restaurant_app/data/model/restaurant_list_response.dart';
import 'package:restaurant_app/screen/home/food_card_widget.dart';
import 'package:restaurant_app/static/navigation_route.dart';

// todo-03-home-01: make this widget StatefulWidget
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // todo-03-home-02: add a local state that containt a Future
  late final Future<RestaurantListResponse> _futureRestaurantResponse;

  // todo-03-home-03: initialize a state from initState function
  @override
  void initState() {
    super.initState();
    _futureRestaurantResponse = ApiServices().getRestaurantList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Restaurant List"),
      ),
      // todo-03-home-04: comment the ListView widget first, we take it later
      // todo-03-home-05: create a FutureBuilder
      body: FutureBuilder(
        future: _futureRestaurantResponse,
        builder: (context, snapshot) {
          // todo-03-home-06: define a widget based on state
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return const Center(
                child: CircularProgressIndicator(),
              );
            case ConnectionState.done:
              // todo-03-home-07: define a widget base on error or has data
              if (snapshot.hasError) {
                return Center(
                  child: Text(snapshot.error.toString()),
                );
              }

              final listOfRestaurant = snapshot.data!.places;
              return ListView.builder(
                itemCount: listOfRestaurant.length,
                itemBuilder: (context, index) {
                  final restaurant = listOfRestaurant[index];

                  return RestaurantCard(
                    restaurant: restaurant,
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        NavigationRoute.detailRoute.name,
                        // todo-04-detail-13: dont forget to change the value too
                        arguments: restaurant.id,
                      );
                    },
                  );
                },
              );
            default:
              return const SizedBox();
          }
        },
      ),
    );
  }
}
