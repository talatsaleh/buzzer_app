
import 'package:buzzer_app/features/restaurant/domain/entities/menuItem.dart';
import 'package:buzzer_app/features/restaurant/domain/entities/restaurant.dart';
import 'package:buzzer_app/features/restaurant/domain/repositories/restaurant_repository.dart';

class GetAllRestaurantsUseCase {
  final RestaurantRepository repository;

  GetAllRestaurantsUseCase(this.repository);

  Future<List<Restaurant>> call() {
    return repository.getAllRestaurants();
  }
}

class GetRestaurantDetailsUseCase {
  final RestaurantRepository repository;

  GetRestaurantDetailsUseCase(this.repository);

  Future<List<MenuItem>> call(String restaurantId) {
    return repository.getRestaurantDetails(restaurantId);
  }
}

class SearchRestaurantsUseCase {
  final RestaurantRepository repository;

  SearchRestaurantsUseCase(this.repository);

  Future<List<Restaurant>> call(String query) {
    return repository.searchRestaurants(query);
  }
}


