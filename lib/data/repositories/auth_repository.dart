import 'package:contact_list/utils/email_session.dart';

import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_local_datasource.dart';
import '../models/user_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthLocalDataSource localDataSource;

  AuthRepositoryImpl(this.localDataSource);

  @override
  Future<void> register(User user) async {
    final existUser = await localDataSource.getUserByEmail(user.email);
    if (existUser != null) {
      throw Exception('Email đã tồn tại');
    }
    final model = UserModel(
      id: user.id,
      username: user.username,
      email: user.email,
      password: user.password,
    );
    await localDataSource.insertUser(model);
  }

  @override
  Future<User> login(String email, String password) async {
    final userModel = await localDataSource.getUserByEmail(email);
    if (userModel == null) throw Exception('Email chưa đăng ký');
    if (userModel.password != password) throw Exception('Sai mật khẩu');
    await LocalStorage.saveEmail(userModel.email);
    return User(
      id: userModel.id,
      username: userModel.username,
      email: userModel.email,
      password: userModel.password,
    );
  }
  
   @override
  Future<void> logout() async {
    await LocalStorage.clearEmail();
  }

  @override
  Future<User?> getCurrentUser() async {
    final email = await LocalStorage.getEmail();
    if (email == null) return null;
    final user = await localDataSource.getUserByEmail(email);
    return user;
  }
}
