import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../features/cart/presentation/pages/cart_page.dart';
import '../../../../features/favorites/presentation/pages/favorites_page.dart';
import '../../../../features/products/presentation/pages/products_page.dart';
import '../../../../features/home/presentation/blocs/home_cubit.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeCubit(),
      child: const _MainPageView(),
    );
  }
}

class _MainPageView extends StatelessWidget {
  const _MainPageView();

  @override
  Widget build(BuildContext context) {
    final selectedTab = context.select((HomeCubit cubit) => cubit.state);

    return Scaffold(
      body: IndexedStack(
        index: selectedTab,
        children: const [ProductsPage(), FavoritesPage(), CartPage()],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedTab,
        onTap: (index) => context.read<HomeCubit>().setTab(index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Products'),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
        ],
      ),
    );
  }
}
