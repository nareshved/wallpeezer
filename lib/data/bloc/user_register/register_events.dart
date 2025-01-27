import 'package:wallpeezer/domain/models/register/user_model.dart';

abstract class RegisterUserEvents {}

class CreateUserEvent extends RegisterUserEvents {
  UserModel userModel;
  String password;

  CreateUserEvent({required this.password, required this.userModel});
}

class LoginUserEvent extends RegisterUserEvents {
  String userEmail, userPassword;

  LoginUserEvent({required this.userEmail, required this.userPassword});
}

class LogOutUserEvent extends RegisterUserEvents {
// logout from firebase and prefs
}
