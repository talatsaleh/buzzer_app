import '../entities/cart_item.dart';

abstract class CartRepository {
  Future<void> addItemToCart(CartItem item);
  Future<void> removeItemFromCart(String itemId);
  List<CartItem> getCartItems();
  Future<void> clearAllItems();
}