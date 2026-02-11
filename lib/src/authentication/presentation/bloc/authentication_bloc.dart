import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tdd_tutorial/src/authentication/domain/entities/user.dart';
import 'package:tdd_tutorial/src/authentication/domain/usecases/create_user.dart';
import 'package:tdd_tutorial/src/authentication/domain/usecases/get_users.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc({
    required CreateUser createUser,
    required GetUsers getUsers,
  }) : _createUser = createUser,
       _getUsers = getUsers,
       super(AuthenticationInitial()) {
    // on<AuthenticationEvent>((event, emit) {
    //on this event, emit state
    // });
    //these auths depend on usecases
    on<CreateUserEvent>(_createUserHandler);
    on<GetUsersEvent>(_getUsersHandler);
  }
  final CreateUser _createUser;
  final GetUsers _getUsers;

  Future<void> _createUserHandler(
    CreateUserEvent event,
    Emitter<AuthenticationState> emit,
  ) async {
    //will always be void, returning nothing
    //will emit loading state
    emit(const CreatingUser());
    final result = await _createUser(
      CreateUserParams(
        createdAt: event.createdAt,
        name: event.name,
        avatar: event.avatar,
      ),
    );
    result.fold(
      //will either emit the failure or the userCreated on success
      (failure) => emit(
        AuthenticationError(failure.errorMessage),
      ),
      (_) => emit(const UserCreated()),
    );
  }

  Future<void> _getUsersHandler(
    GetUsersEvent event,
    Emitter<AuthenticationState> emit,
  ) async {
    emit(GettingUsers());
    final result = await _getUsers();
    result.fold(
      (f) => emit(AuthenticationError(f.errorMessage)),
      (users) => emit(UsersLoaded(users)),
    );
  }
}
