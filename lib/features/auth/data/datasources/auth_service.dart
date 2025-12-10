import 'package:dio/dio.dart';
import 'package:upc_pre_202520_1acc0238_eb_u202310680/core/constants/api_constants.dart';
import '../models/user_dto.dart';

class AuthService {
  final Dio dio;

  AuthService(this.dio);

  Future<UserDto> login(String email, String password) async {
    try {
      final response = await dio.post(
        ApiConstants.baseUrl + ApiConstants.loginEndpoint,
        data: {'email': email, 'password': password},
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return UserDto.fromJson(response.data);
      } else {
        return Future.error('Login failed');
      }
    } catch (e) {
      return Future.error(e);
    }
  }
}
