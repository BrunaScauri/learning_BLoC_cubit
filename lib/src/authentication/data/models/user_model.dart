import 'dart:convert';

import 'package:tdd_tutorial/core/utils/typedef.dart';
import 'package:tdd_tutorial/src/authentication/domain/entities/user.dart';

class UserModel extends User{
  const UserModel({
    required super.id,
    required super.name,
    required super.createdAt,
    required super.avatar
  });

  const UserModel.empty() : this(
    id: '1',
    name: '_empty.name',
    createdAt: '_empty.createdAt',
    avatar: '_empty.avatar' 
  );

  factory UserModel.fromJson(String source) => UserModel.fromMap(jsonDecode(source) as DataMap);

  UserModel.fromMap(DataMap map) : this(
    id: map['id'] as String,
    name: map['name'] as String,
    createdAt: map['createdAt'] as String,
    avatar: map['avatar'] as String,
  );

  UserModel copyWith({ //method to update user, fields are nullable bc user might update only one
    String? id,
    String? name,
    String? avatar,
    String? createdAt,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      avatar: avatar ?? this.avatar,
      createdAt: createdAt ?? this.createdAt
    );
  }

  DataMap toMap() => {
    'id' : id,
    'name': name,
    'createdAt': createdAt,
    'avatar': avatar
  };

  String toJson() => jsonEncode(toMap());
}