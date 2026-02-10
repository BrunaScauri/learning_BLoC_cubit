import 'package:equatable/equatable.dart';

class User extends Equatable{
  const User({
    required this.id,
    required this.createdAt,
    required this.name,
    required this.avatar,
  });

  const User.empty() :
    this(id: '_empty.string', createdAt: '_empty.string', name: '_empty.string', avatar: '_empty.string');

  final String id;
  final String createdAt;
  final String name;
  final String avatar;

  @override
  List<Object?> get props => [id, name, avatar];
}