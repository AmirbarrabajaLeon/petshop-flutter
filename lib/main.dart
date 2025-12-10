import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:upc_pre_202520_1acc0238_eb_u202310680/features/auth/data/datasources/auth_service.dart';
import 'package:upc_pre_202520_1acc0238_eb_u202310680/features/auth/data/repositories/login_repository_impl.dart';
import 'package:upc_pre_202520_1acc0238_eb_u202310680/features/auth/domain/repositories/login_repository.dart';
import 'package:upc_pre_202520_1acc0238_eb_u202310680/features/auth/presentation/blocs/auth_bloc.dart';
import 'package:upc_pre_202520_1acc0238_eb_u202310680/features/auth/presentation/pages/login_page.dart';
import 'package:upc_pre_202520_1acc0238_eb_u202310680/features/cart/presentation/blocs/cart_bloc.dart';
import 'package:upc_pre_202520_1acc0238_eb_u202310680/features/favorites/data/local/favorites_dao.dart';
import 'package:upc_pre_202520_1acc0238_eb_u202310680/features/favorites/data/repositories/favorites_repository_impl.dart';
import 'package:upc_pre_202520_1acc0238_eb_u202310680/features/favorites/domain/repositories/favorites_repository.dart';
import 'package:upc_pre_202520_1acc0238_eb_u202310680/features/favorites/presentation/blocs/favorites_bloc.dart';
import 'package:upc_pre_202520_1acc0238_eb_u202310680/features/favorites/presentation/blocs/favorites_event.dart';
import 'package:upc_pre_202520_1acc0238_eb_u202310680/features/products/data/datasources/product_service.dart';
import 'package:upc_pre_202520_1acc0238_eb_u202310680/features/products/data/repositories/product_repository_impl.dart';
import 'package:upc_pre_202520_1acc0238_eb_u202310680/features/products/domain/repositories/product_repository.dart';
import 'package:upc_pre_202520_1acc0238_eb_u202310680/features/products/presentation/blocs/products_bloc.dart';
import 'package:upc_pre_202520_1acc0238_eb_u202310680/features/products/presentation/blocs/products_event.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final dio = Dio();

  // 1. Inicializar BD Local (Prompt 2 la creará)
  final favoritesDao = FavoritesDao(); // Inicializa el DAO

  // 2. Data Sources / Services
  final authService = AuthService(dio);
  final productService = ProductService(dio);

  // 3. Repositorios
  final loginRepo = LoginRepositoryImpl(authService);
  final productRepo = ProductRepositoryImpl(productService, favoritesDao);
  final favoritesRepo = FavoritesRepositoryImpl(favoritesDao);

  runApp(
    MainApp(
      loginRepo: loginRepo,
      productRepo: productRepo,
      favoritesRepo: favoritesRepo,
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({
    super.key,
    required this.loginRepo,
    required this.productRepo,
    required this.favoritesRepo,
  });

  final LoginRepository loginRepo;
  final ProductRepository productRepo;
  final FavoritesRepository favoritesRepo;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: loginRepo),
        RepositoryProvider.value(value: productRepo),
        RepositoryProvider.value(value: favoritesRepo),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => AuthBloc(loginRepo)),
          BlocProvider(create: (_) => CartBloc()),
          BlocProvider(
            create: (_) => ProductsBloc(
              productRepository: productRepo,
              favoritesRepository: favoritesRepo,
            )..add(LoadProducts()),
          ),
          BlocProvider(
            create: (_) => FavoritesBloc(favoritesRepo)..add(LoadFavorites()),
          ),
        ],
        child: MaterialApp(
          title: 'Petshop',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.blue),
          home: const LoginPage(),
        ),
      ),
    );
  }
}
