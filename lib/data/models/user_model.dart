import '../../domain/entities/user.dart';

class UserModel extends User {
  UserModel({
    super.id,
    required super.email,
    required super.avatar,
    required super.password,
    required super.username,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] as int?,
      username: map['username'] ?? '',
      email: map['email'] ?? '',      
      avatar: map['avatar'] ?? '',    
      password: map['password'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'avatar': avatar,
      'password': password,
    };
  }
}
