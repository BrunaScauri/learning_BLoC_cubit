import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tdd_tutorial/src/authentication/presentation/cubit/authentication_cubit.dart';

class AddUserDialog extends StatelessWidget {
  const AddUserDialog({super.key, required this.nameController});

  final TextEditingController nameController;

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Center(
        child: Container(
          padding: const EdgeInsets.all(20),
          margin: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: InputDecoration(labelText: 'username'),
                controller: nameController,
              ),
              ElevatedButton(
                onPressed: () {
                  final name = nameController.text.trim();
                  final avatar = 'https://cdn.jsdelivr.net/gh/faker-js/assets-person-portrait/male/512/26.jpg';
                  context.read<AuthenticationCubit>().createUser(
                    createdAt: DateTime.now().toString(),
                    name: name,
                    avatar: avatar,
                  );
                  Navigator.of(context).pop();
                },
                child: Text('Create user'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
