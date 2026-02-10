import 'package:dartz/dartz.dart';
import 'package:tdd_tutorial/core/errors/failure.dart';
import 'package:tdd_tutorial/core/utils/typedef.dart';
import 'package:tdd_tutorial/src/authentication/domain/entities/user.dart';
import 'package:tdd_tutorial/src/authentication/domain/repositories/authentication_repository.dart';

import '../datasources/authentication_remote_data_source.dart';

class AuthenticationRepositoryImplementation implements AuthenticationRepository {

  const AuthenticationRepositoryImplementation(this._remoteDataSource);
  final AuthenticationRemoteDataSource _remoteDataSource;
  
  @override
  ResultVoid createUser({
    required String createdAt,
    required String name,
    required String avatar,
  }) async {
    //call the remote data source
    //check if the method returns the proper data
    //mke sure that it returns the proper data it there is no exception
    //check if when the remoteDataSrc throws an exception we return a failure
    try{
      await _remoteDataSource.createUser(avatar: avatar, name: name, createdAt: createdAt);
      return const Right(null);
    } on ApiFailure catch(e) {
      return Left(ApiFailure.fromException(e));
    }
  }

  @override
  ResultFuture<List<User>> getUsers() async{
    try{
      final result = await _remoteDataSource.getUsers();
      return Right(result); 
    } on ApiFailure catch(e) {
      return Left(ApiFailure.fromException(e));
    }
  }
}
