import 'package:contact_list/presentation/pages/root_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'injection.dart';
import 'presentation/blocs/contact/contact_bloc.dart';
import 'presentation/blocs/contact/contact_event.dart';
import 'presentation/blocs/auth/auth_bloc.dart';
import 'domain/repositories/contact_repository.dart';
import 'domain/repositories/auth_repository.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initInjection();
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final contactRepo = getIt<ContactRepository>();
    final authRepo = getIt<AuthRepository>();

    return MultiBlocProvider(
      providers: [
        BlocProvider<ContactBloc>(
          create: (_) {
            final bloc = ContactBloc(contactRepo);
            bloc.add(LoadContactsEvent());
            return bloc;
          },
        ),
        BlocProvider<AuthBloc>(
          create: (_) => AuthBloc(authRepo),
        ),
      ],
      child: MaterialApp(
        title: 'Contact List',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
        home: const RootPage(),
      ),
    );
  }
}
