import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/models/cart_item.dart';
import 'cart_event.dart';
import 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartState()) {
    on<AddToCart>(_onAddToCart);
    on<RemoveFromCart>(_onRemoveFromCart);
    on<IncrementQuantity>(_onIncrementQuantity);
    on<DecrementQuantity>(_onDecrementQuantity);
  }

  void _onAddToCart(AddToCart event, Emitter<CartState> emit) {
    final existingIndex = state.items.indexWhere(
      (i) => i.product.id == event.product.id,
    );
    if (existingIndex != -1) {
      final updatedItems = List<CartItem>.from(state.items);
      final item = updatedItems[existingIndex];
      updatedItems[existingIndex] = item.copyWith(quantity: item.quantity + 1);
      emit(CartState(items: updatedItems));
    } else {
      final updatedItems = List<CartItem>.from(state.items)
        ..add(CartItem(product: event.product));
      emit(CartState(items: updatedItems));
    }
  }

  void _onRemoveFromCart(RemoveFromCart event, Emitter<CartState> emit) {
    final updatedItems = state.items
        .where((i) => i.product.id != event.product.id)
        .toList();
    emit(CartState(items: updatedItems));
  }

  void _onIncrementQuantity(IncrementQuantity event, Emitter<CartState> emit) {
    final index = state.items.indexWhere(
      (i) => i.product.id == event.product.id,
    );
    if (index != -1) {
      final updatedItems = List<CartItem>.from(state.items);
      updatedItems[index] = updatedItems[index].copyWith(
        quantity: updatedItems[index].quantity + 1,
      );
      emit(CartState(items: updatedItems));
    }
  }

  void _onDecrementQuantity(DecrementQuantity event, Emitter<CartState> emit) {
    final index = state.items.indexWhere(
      (i) => i.product.id == event.product.id,
    );
    if (index != -1) {
      final item = state.items[index];
      if (item.quantity > 1) {
        final updatedItems = List<CartItem>.from(state.items);
        updatedItems[index] = item.copyWith(quantity: item.quantity - 1);
        emit(CartState(items: updatedItems));
      } else {
        // Option: Remove if quantity goes to 0, but usually decrement stops at 1 or removes.
        // Prompt implies just "Decrement", I'll remove if it goes to 0 or keep at 1?
        // Usually UI prevents going below 1, or decrement removes.
        // I will implement "remove if 1->0" logic or just decrement. For now, valid > 0.
        // Let's assume removing if it hits 0 for better UX default.
        final updatedItems = List<CartItem>.from(state.items);
        updatedItems.removeAt(index);
        emit(CartState(items: updatedItems));
      }
    }
  }
}
