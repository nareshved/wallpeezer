import 'package:wallpeezer/data/bloc/user_register/register_events.dart';
import 'package:wallpeezer/data/bloc/user_register/register_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallpeezer/data/firebase/firebase_provider.dart';

class RegisterUserBloc extends Bloc<RegisterUserEvents, RegisterUserStates> {
  FirebaseHelper firebaseHelper;
  RegisterUserBloc({required this.firebaseHelper}) : super(UserInitialState()) {
    on<CreateUserEvent>(
      (event, emit) async {
        emit(UserLoadingState());

        try {
          await firebaseHelper.createUser(
              userModel: event.userModel, password: event.password);

          emit(UserLoadedState());
        } catch (e) {
          emit(UserErrorState(errorMsg: e.toString()));
        }
      },
    );

    on<LoginUserEvent>(
      (event, emit) async {
        emit(UserLoadingState());

        try {
          await firebaseHelper.authenticateUser(
              userEmail: event.userEmail, userPass: event.userPassword);

          emit(UserLoadedState());
        } catch (e) {
          emit(UserErrorState(errorMsg: e.toString()));
        }
      },
    );

    on<LogOutUserEvent>(
      (event, emit) async {
        emit(UserLoadingState());

        try {
          await firebaseHelper.logOutMe();
        } catch (e) {
          emit(UserErrorState(errorMsg: e.toString()));
        }
      },
    );
  }
}
