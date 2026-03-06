// ignore: depend_on_referenced_packages
import 'package:flutter_test/flutter_test.dart';
// ignore: depend_on_referenced_packages
import 'package:mockito/annotations.dart';
// ignore: depend_on_referenced_packages
import 'package:mockito/mockito.dart';
// import 'restaurant_provider_test.mocks.dart';

import 'package:restaurant_app/provider/restaurant_list_provider.dart';
import 'package:restaurant_app/data/api/api_services.dart';
import 'package:restaurant_app/data/model/restaurant_list_response.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/utils/result_state.dart';

import 'restaurant_provider_test.mocks.dart';

// Generate mock dengan mockito untuk type safety
@GenerateMocks([ApiServices])
void main() {
  late MockApiServices mockApiService;

  setUp(() {
    mockApiService = MockApiServices();
  });

  /// TEST 1: API sukses mengembalikan data
  test('API sukses mengembalikan daftar restoran', () async {
    final mockResponse = RestaurantListResponse(
      error: false,
      message: 'success',
      count: 1,
      restaurants: [
        Restaurant(
          id: '1',
          name: 'Resto Test',
          description: 'Test Description',
          pictureId: 'pic1',
          city: 'Jakarta',
          rating: 4.5,
        )
      ],
    );

    // Setup mock dengan doAnswer
    when(mockApiService.getRestaurantList())
        .thenAnswer((_) => Future.value(mockResponse));

    final provider = RestaurantListProvider(mockApiService);

    // Wait untuk fetchRestaurantList() selesai
    await Future.delayed(const Duration(milliseconds: 300));

    expect(provider.state, ResultState.hasData);
    expect(provider.restaurants.length, 1);
    expect(provider.restaurants[0].name, 'Resto Test');
  });

  /// TEST 2: API gagal mengembalikan error
  test('API gagal mengembalikan error', () async {
    // Setup mock dengan thenThrow
    when(mockApiService.getRestaurantList())
        .thenAnswer((_) => Future.error(Exception('Failed to load')));

    final provider = RestaurantListProvider(mockApiService);

    // Wait untuk fetchRestaurantList() selesai
    await Future.delayed(const Duration(milliseconds: 300));

    expect(provider.state, ResultState.error);
    expect(provider.message.isNotEmpty, true);
  });
}
