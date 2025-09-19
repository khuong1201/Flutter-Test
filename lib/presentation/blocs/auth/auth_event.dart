
import 'package:contact_list/domain/entities/user.dart';

abstract class AuthEvent {}



class AuthRegisterEvent extends AuthEvent {
  final User user;
  AuthRegisterEvent(this.user);
}

class AuthLoginEvent extends AuthEvent {
  final String email;
  final String password;
  AuthLoginEvent(this.email, this.password);
}
class AuthLogoutEvent extends AuthEvent {}
class AuthCheckEvent extends AuthEvent {} 
