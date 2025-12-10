import '../../domain/entities/user.dart';

class UserDto extends User {
  UserDto({
    required super.firstName,
    required super.lastName,
    required super.email,
    required super.token,
  });

  factory UserDto.fromJson(Map<String, dynamic> json) {
    return UserDto(
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      email: json['email'] as String,
      token: json['token'] as String,
    );
  }
}
