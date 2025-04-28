import 'package:buzzer_app/features/restaurant/data/datasources/restaurant_remote_data_source.dart';
import 'package:buzzer_app/features/restaurant/domain/entities/menuItem.dart';
import 'package:buzzer_app/features/restaurant/domain/entities/restaurant.dart';
import 'package:buzzer_app/features/restaurant/domain/repositories/restaurant_repository.dart';

class RestaurantRepositoryImpl implements RestaurantRepository {
  final RestaurantDataSource restaurantDataSource;

  RestaurantRepositoryImpl(this.restaurantDataSource);

  @override
  Future<List<Restaurant>> getAllRestaurants() {
    return restaurantDataSource.getAllRestaurants();
  }

  @override
  Future<List<MenuItem>> getRestaurantDetails(String restaurantId) {
    return restaurantDataSource.getRestaurantDetails(restaurantId);
  }

  @override
  Future<List<Restaurant>> searchRestaurants(String query) {
    return restaurantDataSource.searchRestaurants(query);
  }
}
