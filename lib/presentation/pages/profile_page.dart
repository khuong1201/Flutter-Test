import 'package:contact_list/presentation/blocs/auth/auth_bloc.dart';
import 'package:contact_list/presentation/blocs/auth/auth_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../domain/entities/user.dart';
import 'login_page.dart';

class ProfilePage extends StatelessWidget {
  final User user;

  const ProfilePage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(FontAwesomeIcons.rightFromBracket),
            onPressed: () {
              context.read<AuthBloc>().add(AuthLogoutEvent());
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (_) => const LoginPage()),
                (route) => false,
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            CircleAvatar(
              radius: 50,
              child: Image.network(user.avatar),
            ),
            const SizedBox(height: 16),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text("Username"),
              subtitle: Text(user.username),
            ),
            ListTile(
              leading: const Icon(Icons.email),
              title: const Text("Email"),
              subtitle: Text(user.email),
            ),
            ListTile(
              leading: const Icon(Icons.lock),
              title: const Text("Password"),
              subtitle: Text("*" * user.password.length),
            ),
            const SizedBox(height: 20),
            TextButton.icon(
              onPressed: () {
                context.read<AuthBloc>().add(AuthLogoutEvent());
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (_) => const LoginPage()),
                  (route) => false,
                );
              },
              icon: const Icon(FontAwesomeIcons.rightFromBracket),
              label: const Text("Logout"),
              style: TextButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
