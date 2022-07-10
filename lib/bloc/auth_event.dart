import '../model/user.dart';

abstract class AuthEvent {}

class RegisterUser extends AuthEvent {
  String emailAddress;
  String password;

  RegisterUser({required this.emailAddress, required this.password});
}

class LoginUser extends AuthEvent {
  String emailAddress;
  String password;

  LoginUser({required this.emailAddress, required this.password});
}

class LoginAnonymousUser extends AuthEvent {}

class Logout extends AuthEvent {}

class AuthServerEvent extends AuthEvent {
  final UserModel? userModel;
  AuthServerEvent(this.userModel);
}
