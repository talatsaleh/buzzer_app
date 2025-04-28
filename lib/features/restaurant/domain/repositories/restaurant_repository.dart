import '../entities/menuItem.dart';
import '../entities/restaurant.dart';

abstract class RestaurantRepository {
  Future<List<Restaurant>> getAllRestaurants();
  Future<List<MenuItem>> getRestaurantDetails(String restaurantId);
  Future<List<Restaurant>> searchRestaurants(String query);
}
