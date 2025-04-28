import 'package:buzzer_app/core/utils/firebase_config.dart';
import 'package:buzzer_app/features/restaurant/domain/entities/menuItem.dart';

import '../../domain/entities/restaurant.dart';

abstract class RestaurantDataSource {
  Future<List<Restaurant>> getAllRestaurants();

  Future<List<MenuItem>> getRestaurantDetails(String restaurantId);

  Future<List<Restaurant>> searchRestaurants(String query);
}

class RestaurantDataSourceImpl implements RestaurantDataSource {
  @override
  Future<List<Restaurant>> getAllRestaurants() async {
    try {
      final data = await FirebaseConfig.restaurantCollection.get();
      return data.docs
          .map(
            (e) => Restaurant.fromMap(e.data() as Map<String, dynamic>, e.id),
          )
          .toList();
    } catch (e, s) {
      throw Exception([e.toString(), s]);
    }
  }

  @override
  Future<List<MenuItem>> getRestaurantDetails(String restaurantId) async {
    try {
      final data = await FirebaseConfig.restaurantCollection
          .doc(restaurantId)
          .collection('menuItem')
          .get();
      return data.docs
          .map(
            (e) => MenuItem.fromMap(e.data(), e.id),
          )
          .toList();
    } catch (e, s) {
      throw Exception([e.toString(), s]);
    }
  }

  @override
  Future<List<Restaurant>> searchRestaurants(String query) async {
    try {
      final querySnapshot = await FirebaseConfig.restaurantCollection
          .orderBy('name')
          .startAt([query]).endAt(['$query\uf8ff']).get();
      return querySnapshot.docs
          .map(
            (e) => Restaurant.fromMap(e.data() as Map<String, dynamic>, e.id),
          )
          .toList();
    } catch (e, s) {
      throw Exception([e, s]);
    }
  }
}
