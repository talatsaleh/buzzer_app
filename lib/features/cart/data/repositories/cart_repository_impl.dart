import 'package:buzzer_app/features/cart/domain/entities/cart_item.dart';

import '../../domain/repositories/cart_repository.dart';
import '../datasources/cart_local_data_source.dart';

class CartRepositoryImpl implements CartRepository {
  final CartDataSource dataSource;

  CartRepositoryImpl(this.dataSource);

  @override
  Future<void> addItemToCart(CartItem item) async {
    await dataSource.addItemToCart(item);
  }

  @override
  Future<void> removeItemFromCart(String itemId) async {
    await dataSource.removeItemFromCart(itemId);
  }

  @override
  List<CartItem> getCartItems() {
    return dataSource.getCartItems();
  }

  @override
  Future<void> clearAllItems() {
    return dataSource.clearCart();
  }
}
