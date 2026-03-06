// // ignore: depend_on_referenced_packages
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/mockito.dart';

// import 'package:restaurant_app/provider/restaurant_list_provider.dart';
// import 'package:restaurant_app/data/api/api_services.dart';
// import 'package:restaurant_app/data/model/restaurant_list_response.dart';
// import 'package:restaurant_app/data/model/restaurant.dart';
// import 'package:restaurant_app/utils/result_state.dart';

// class MockApiService extends Mock implements ApiServices {}

// void main() {
//   late RestaurantListProvider provider;
//   late MockApiService mockApi;

//   setUp(() {
//     mockApi = MockApiService();
//     provider = RestaurantListProvider(mockApi);
//   });

//   test('Mengembalikan data ketika API sukses', () async {
//     when(mockApi.getRestaurantList()).thenAnswer((_) async =>
//         RestaurantListResponse(
//             error: false,
//             message: '',
//             count: 1,
//             restaurants: [
//           Restaurant(
//               id: '1',
//               name: 'Resto',
//               description: 'desc',
//               pictureId: 'pic',
//               city: 'City',
//               rating: 4.5)
//         ]));

//     await provider.fetchRestaurantList();

//     expect(provider.state, ResultState.hasData);
//   });

//   test('Mengembalikan error ketika API gagal', () async {
//     when(mockApi.getRestaurantList()).thenThrow(Exception('Error'));

//     await provider.fetchRestaurantList();

//     expect(provider.state, ResultState.error);
//   });
// }

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:restaurant_app/provider/restaurant_list_provider.dart';
import 'package:restaurant_app/data/api/api_services.dart';
import 'package:restaurant_app/data/model/restaurant_list_response.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/utils/result_state.dart';

class MockApiService extends Mock implements ApiServices {}

void main() {
  late RestaurantListProvider provider;
  late MockApiService mockApi;

  setUp(() {
    mockApi = MockApiService();
  });

  test('Mengembalikan data ketika API sukses', () async {
    when(mockApi.getRestaurantList()).thenAnswer((_) async =>
        RestaurantListResponse(
          error: false,
          message: '',
          count: 1,
          restaurants: [
            Restaurant(
              id: '1',
              name: 'Resto',
              description: 'desc',
              pictureId: 'pic',
              city: 'City',
              rating: 4.5,
            )
          ],
        ));

    provider = RestaurantListProvider(mockApi);

    await provider.fetchRestaurantList();

    expect(provider.state, ResultState.hasData);
  });

  test('Mengembalikan error ketika API gagal', () async {
    when(mockApi.getRestaurantList()).thenThrow(Exception('Error'));

    provider = RestaurantListProvider(mockApi);

    await provider.fetchRestaurantList();

    expect(provider.state, ResultState.error);
  });
}