import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tdd_tutorial/core/utils/constants.dart';
import 'package:tdd_tutorial/core/errors/failure.dart';
import 'package:tdd_tutorial/core/utils/typedef.dart';
import 'package:tdd_tutorial/src/authentication/data/models/user_model.dart';

abstract class AuthenticationRemoteDataSource {
  //get data from authRepo
  //throw an error if it exists
  //authRepoImpl will catch it

  //datasources will ALWAYS return models, not the actual entity
  Future<void> createUser({
    required String createdAt,
    required String name,
    required String avatar,
  });

  Future<List<UserModel>> getUsers();
}

const kCreateUserEndpoint = '/test-api/users';
const kGetUsersEndpoint = '/test-api/user';

class AuthRemoteDataSrcImpl implements AuthenticationRemoteDataSource {
  const AuthRemoteDataSrcImpl(this._client);
  final http.Client _client;

  @override
  Future<void> createUser({
    required String createdAt,
    required String name,
    required String avatar,
  }) async {
    //make sure it returns right data when the status code is 200 or the proper status code
    //check it throws a CUSTOM EXCEPTION with the right message when status code is a bad one
    try {
      final response = await _client.post(
        Uri.parse('$kBaseUrl$kCreateUserEndpoint'),
        body: jsonEncode({
          'createdAt': createdAt,
          'name': name,
          'avatar': avatar,
        }),
      );
      if (response.statusCode != 200 && response.statusCode != 201) {
        throw ApiFailure(
          message: response.body,
          statusCode: response.statusCode,
        );
      }
    } on ApiFailure {
      rethrow;
    } catch (e) {
      throw ApiFailure(message: e.toString(), statusCode: 505);
    }
  }

  @override
  Future<List<UserModel>> getUsers() async {
    try {
      final response = await _client.get(
        Uri.https(kBaseUrl, kGetUsersEndpoint),
      );
      if (response.statusCode != 200) {
        throw ApiFailure(
          message: response.body,
          statusCode: response.statusCode,
        );
      }
      return List<DataMap>.from(
        jsonDecode(response.body) as List,
      ).map((userData) => UserModel.fromMap(userData)).toList();
    } on ApiFailure {
      rethrow;
    } catch(e) {
      throw ApiFailure(message: e.toString(), statusCode: 505);
    }
  }
}
