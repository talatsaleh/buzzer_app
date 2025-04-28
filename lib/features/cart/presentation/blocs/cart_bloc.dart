import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/cart_usecases.dart';
import 'cart_events.dart';
import 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final AddItemToCartUseCase addToCartUseCase;
  final RemoveItemFromCartUseCase removeFromCartUseCase;
  final GetCartItemsUseCase getCartItemsUseCase;
  final ClearAllItemsUseCase clearAllItemsUseCase;

  CartBloc(
    this.addToCartUseCase,
    this.removeFromCartUseCase,
    this.getCartItemsUseCase,
    this.clearAllItemsUseCase,
  ) : super(CartInitial()) {
    on<GetCartItemsEvent>(_getCartItems);
    on<AddCartItemEvent>(_addCartItem);
    on<RemoveCartItemEvent>(_removeCartItem);
    on<ClearCartEvent>(_clearCart);
  }

  void _getCartItems(GetCartItemsEvent event, Emitter<CartState> emit) async {
    emit(CartLoading());
    try {
      final items = getCartItemsUseCase();
      emit(CartLoaded(items));
    } catch (e) {
      emit(CartError('Failed to load cart items'));
    }
  }

  Future<void> _addCartItem(
      AddCartItemEvent event, Emitter<CartState> emit) async {
    try {
      emit(CartLoading());
      await addToCartUseCase(event.item);
      final items = getCartItemsUseCase();
      emit(CartLoaded(items));
    } catch (e) {
      emit(CartError('Failed to add item to cart'));
    }
  }

  Future<void> _removeCartItem(
      RemoveCartItemEvent event, Emitter<CartState> emit) async {
    try {
      await removeFromCartUseCase(event.itemId);
      final items = getCartItemsUseCase();
      emit(CartLoaded(items));
    } catch (e) {
      emit(CartError('Failed to remove item from cart'));
    }
  }

  Future<void> _clearCart(ClearCartEvent event, Emitter<CartState> emit) async {
    try {
      await clearAllItemsUseCase();
      final items = getCartItemsUseCase();
      emit(CartLoaded(items));
    } catch (e) {
      emit(CartError('Failed to remove item from cart'));
    }
  }
}
