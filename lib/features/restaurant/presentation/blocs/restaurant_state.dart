import 'package:buzzer_app/features/restaurant/domain/entities/menuItem.dart';
import 'package:buzzer_app/features/restaurant/domain/entities/restaurant.dart';
import 'package:equatable/equatable.dart';

class RestaurantState extends Equatable {
  @override
  List<Object?> get props => [];
}

class RestaurantInitial extends RestaurantState {}

class RestaurantLoading extends RestaurantState {}

class RestaurantsLoaded extends RestaurantState {
  final List<Restaurant> restaurants;

  RestaurantsLoaded(this.restaurants);

  @override
  List<Object?> get props => [restaurants];
}

class RestaurantItemLoaded extends RestaurantState {
  final List<MenuItem> menuItem;

  RestaurantItemLoaded(this.menuItem);

  @override
  List<Object?> get props => [menuItem];
}

class RestaurantError extends RestaurantState {
  final String message;
  final StackTrace stackTrace;

  RestaurantError(this.message, this.stackTrace);

  @override
  List<Object?> get props => [message, stackTrace];
}
