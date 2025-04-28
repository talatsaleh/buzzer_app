import '../../domain/entities/cart_item.dart';

abstract class CartEvent {}

class AddCartItemEvent extends CartEvent {
  final CartItem item;

  AddCartItemEvent(this.item);
}

class RemoveCartItemEvent extends CartEvent {
  final String itemId;

  RemoveCartItemEvent(this.itemId);
}

class GetCartItemsEvent extends CartEvent {}

class ClearCartEvent extends CartEvent{}