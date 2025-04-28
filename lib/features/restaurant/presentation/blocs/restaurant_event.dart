import 'package:buzzer_app/features/restaurant/domain/entities/menuItem.dart';
import 'package:buzzer_app/features/restaurant/domain/entities/restaurant.dart';
import 'package:equatable/equatable.dart';

abstract class RestaurantEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetAllRestaurantsEvent extends RestaurantEvent {}

class SearchRestaurantsEvent extends RestaurantEvent {
  final String query;

  SearchRestaurantsEvent(this.query);

  @override
  List<Object?> get props => [query];
}

class GetRestaurantDetailEvent extends RestaurantEvent {
  final String restaurantId;

  GetRestaurantDetailEvent(this.restaurantId);
}

