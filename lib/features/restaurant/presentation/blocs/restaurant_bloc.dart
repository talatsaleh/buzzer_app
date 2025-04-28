import 'package:buzzer_app/features/restaurant/domain/usecases/restaurants_usecases.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'restaurant_event.dart';
import 'restaurant_state.dart';

class RestaurantBloc extends Bloc<RestaurantEvent, RestaurantState> {
  final GetAllRestaurantsUseCase getAllRestaurantsUseCase;
  final GetRestaurantDetailsUseCase getRestaurantDetailsUseCase;
  final SearchRestaurantsUseCase searchRestaurantsUseCase;

  RestaurantBloc(
    this.getAllRestaurantsUseCase,
    this.getRestaurantDetailsUseCase,
    this.searchRestaurantsUseCase,
  ) : super(RestaurantInitial()) {
    on<GetAllRestaurantsEvent>(_getAllRestaurantsEvent);
    on<SearchRestaurantsEvent>(_searchRestaurantsEvent);
    on<GetRestaurantDetailEvent>(_getRestaurantDetailEvent);
  }

  Future<void> _getRestaurantDetailEvent(
      GetRestaurantDetailEvent event, Emitter<RestaurantState> emit) async {
    emit(RestaurantLoading());
    try {
      final restaurantDetails =
          await getRestaurantDetailsUseCase(event.restaurantId);
      emit(RestaurantItemLoaded(restaurantDetails));
    } catch (e, s) {
      emit(RestaurantError(e.toString(), s));
    }
  }

  Future<void> _getAllRestaurantsEvent(
      GetAllRestaurantsEvent event, Emitter<RestaurantState> emit) async {
    emit(RestaurantLoading());
    try {
      final restaurants = await getAllRestaurantsUseCase();
      emit(RestaurantsLoaded(restaurants));
    } catch (e, s) {
      emit(RestaurantError(e.toString(), s));
    }
  }

  Future<void> _searchRestaurantsEvent(
      SearchRestaurantsEvent event, Emitter<RestaurantState> emit) async {
    emit(RestaurantLoading());
    try {
      final restaurants = await searchRestaurantsUseCase(event.query);
      emit(RestaurantsLoaded(restaurants));
    } catch (e, s) {
      emit(RestaurantError(e.toString(), s));
    }
  }
}
