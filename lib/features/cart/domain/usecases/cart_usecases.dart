import 'package:buzzer_app/features/cart/domain/repositories/cart_repository.dart';

import '../entities/cart_item.dart';

class AddItemToCartUseCase {
  final CartRepository cartRepository;

  AddItemToCartUseCase(this.cartRepository);

  Future<void> call(CartItem item) {
    return cartRepository.addItemToCart(item);
  }
}

class RemoveItemFromCartUseCase {
  final CartRepository cartRepository;

  RemoveItemFromCartUseCase(this.cartRepository);

  Future<void> call(String itemId) {
    return cartRepository.removeItemFromCart(itemId);
  }
}

class GetCartItemsUseCase {
  final CartRepository cartRepository;

  GetCartItemsUseCase(this.cartRepository);

  List<CartItem> call() {
    return cartRepository.getCartItems();
  }
}

class ClearAllItemsUseCase {
  final CartRepository cartRepository;

  ClearAllItemsUseCase(this.cartRepository);

  Future<void> call() {
    return cartRepository.clearAllItems();
  }
}
