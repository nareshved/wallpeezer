abstract class RegisterUserStates {}

class UserInitialState extends RegisterUserStates {}

class UserLoadingState extends RegisterUserStates {}

class UserLoadedState extends RegisterUserStates {}

class UserErrorState extends RegisterUserStates {
  final String errorMsg;

  UserErrorState({required this.errorMsg});
}
