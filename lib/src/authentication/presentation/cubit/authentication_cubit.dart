import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tdd_tutorial/src/authentication/domain/entities/user.dart';
import 'package:tdd_tutorial/src/authentication/domain/usecases/create_user.dart';
import 'package:tdd_tutorial/src/authentication/domain/usecases/get_users.dart';

part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  AuthenticationCubit({
    required CreateUser createUser,
    required GetUsers getUsers,
  }) : _createUser = createUser,
       _getUsers = getUsers,
       super(AuthenticationInitial());

  final CreateUser _createUser;
  final GetUsers _getUsers;

  Future<void> createUser({
    //instead of calling the event on bloc, we just pass it
    required String createdAt,
    required String name,
    required String avatar,
  }) async {
    emit(const CreatingUser());
    final result = await _createUser(
      CreateUserParams(createdAt: createdAt, name: name, avatar: avatar),
    );
    result.fold(
      (f) => emit(AuthenticationError(f.errorMessage)),
      (_) => emit(const UserCreated()),
    );
  }

  Future<void> getUsers() async {
    emit(const GettingUsers());
    final result = await _getUsers();
    result.fold(
      (f) => emit(AuthenticationError(f.errorMessage)),
      (users) => emit(UsersLoaded(users)),
    );
  }
}

// 6.04 TESTING OF CUBIT
// 6.31.26 START OF D.I