
import 'package:buzzer_app/features/cart/domain/entities/cart_item.dart';

abstract class CartState {}

class CartInitial extends CartState {}

class CartLoading extends CartState {}

class CartLoaded extends CartState {
  final List<CartItem> items;

  CartLoaded(this.items);

  double get totalPrice =>
      items.fold(0, (total, item) => total + item.total);
}

class CartError extends CartState {
  final String message;

  CartError(this.message);
}
