import 'package:contact_list/presentation/blocs/auth/auth_bloc.dart';
import 'package:contact_list/presentation/blocs/auth/auth_event.dart';
import 'package:contact_list/presentation/blocs/auth/auth_state.dart';
import 'package:contact_list/presentation/pages/contact_page.dart';
import 'package:contact_list/presentation/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RootPage extends StatelessWidget {
  const RootPage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<AuthBloc>().add(AuthCheckEvent());
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state.isLoading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (state.user != null) {
          return const ContactPage();
        } else {
          return const LoginPage();
        }
      },
    );
  }
}