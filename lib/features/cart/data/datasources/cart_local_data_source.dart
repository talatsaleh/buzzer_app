import 'package:buzzer_app/core/utils/sharedPreferencesManager.dart';
import 'package:buzzer_app/features/cart/domain/entities/cart_item.dart';
import 'dart:convert' as json;

abstract class CartDataSource {
  Future<void> addItemToCart(CartItem item);

  Future<void> removeItemFromCart(String itemId);

  List<CartItem> getCartItems();

  Future<void> clearCart();
}

class CartDataSourceImpl implements CartDataSource {
  final SharedPreferencesManager sharedPreferencesManager;

  CartDataSourceImpl(this.sharedPreferencesManager);

  final String key = 'CartItems';

  @override
  Future<void> addItemToCart(CartItem item) async {
    try {
      final cartItems = getCartItems();
      if (cartItems.isEmpty) {
        await sharedPreferencesManager
            .saveStringList(key, [json.jsonEncode(item)]);
      } else {
        cartItems.add(item);
        await sharedPreferencesManager.saveStringList(
            key,
            cartItems
                .map(
                  (e) => json.jsonEncode(e.toMap()),
                )
                .toList());
      }
    } catch (e, s) {
      throw Exception([e, s]);
    }
  }

  @override
  List<CartItem> getCartItems() {
    final cartItems = sharedPreferencesManager
        .getStringList(key)
        ?.map(
          (e) => CartItem.fromJson(json.jsonDecode(e)),
        )
        .toList();
    if (cartItems == null) {
      return [];
    } else {
      return cartItems;
    }
  }

  @override
  Future<void> removeItemFromCart(String itemId) async {
    final cartItems = getCartItems();
    if (cartItems.isEmpty) {
      return;
    } else {
      cartItems.removeWhere(
        (element) => element.id == itemId,
      );
      sharedPreferencesManager.saveStringList(
          key,
          cartItems
              .map(
                (e) => json.jsonEncode(e.toMap()),
              )
              .toList());
    }
  }

  @override
  Future<void> clearCart() {
    return sharedPreferencesManager.remove(key);
  }
}
