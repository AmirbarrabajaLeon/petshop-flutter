import 'package:dio/dio.dart';
import 'package:upc_pre_202520_1acc0238_eb_u202310680/core/constants/api_constants.dart';
import '../models/product_dto.dart';

class ProductService {
  final Dio dio;

  ProductService(this.dio);

  Future<List<ProductDto>> getProducts() async {
    try {
      final response = await dio.get(
        ApiConstants.baseUrl + ApiConstants.productsEndpoint,
      );

      if (response.statusCode == 200) {
        final data = response.data;
        if (data is Map<String, dynamic> && data.containsKey('results')) {
          final List<dynamic> results = data['results'];
          return results.map((json) => ProductDto.fromJson(json)).toList();
        } else {
          return Future.error('Invalid response format');
        }
      } else {
        return Future.error('Failed to load products');
      }
    } catch (e) {
      return Future.error(e);
    }
  }
}
