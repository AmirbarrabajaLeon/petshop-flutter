import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../favorites/domain/repositories/favorites_repository.dart';
import '../../domain/repositories/product_repository.dart';
import 'products_event.dart';
import 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  final ProductRepository productRepository;
  final FavoritesRepository favoritesRepository;

  ProductsBloc({
    required this.productRepository,
    required this.favoritesRepository,
  }) : super(ProductsInitial()) {
    on<LoadProducts>(_onLoadProducts);
    on<ToggleFavorite>(_onToggleFavorite);
  }

  Future<void> _onLoadProducts(
    LoadProducts event,
    Emitter<ProductsState> emit,
  ) async {
    emit(ProductsLoading());
    try {
      final products = await productRepository.getProducts();
      emit(ProductsLoaded(products));
    } catch (e) {
      emit(ProductsError(e.toString()));
    }
  }

  Future<void> _onToggleFavorite(
    ToggleFavorite event,
    Emitter<ProductsState> emit,
  ) async {
    if (state is ProductsLoaded) {
      final currentState = state as ProductsLoaded;
      final updatedProducts = currentState.products.map((product) {
        if (product.id == event.product.id) {
          final isFavorite = !product.isFavorite;
          // Update Repository
          if (isFavorite) {
            favoritesRepository.addFavorite(product);
          } else {
            favoritesRepository.removeFavorite(product.id);
          }
          return product.copyWith(isFavorite: isFavorite);
        }
        return product;
      }).toList();
      emit(ProductsLoaded(updatedProducts));
    }
  }
}
