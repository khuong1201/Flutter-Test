import 'package:contact_list/data/datasources/auth_local_datasource.dart';
import 'package:contact_list/domain/repositories/auth_repository.dart';
import 'package:contact_list/domain/repositories/contact_repository.dart';
import 'package:get_it/get_it.dart';
import 'data/datasources/contact_local_datasource.dart';
import 'data/repositories/contact_repository.dart';
import 'data/repositories/auth_repository.dart';
import 'presentation/blocs/contact/contact_bloc.dart';
import 'presentation/blocs/auth/auth_bloc.dart';

final getIt = GetIt.instance;

Future<void> initInjection() async {
  // Data sources
  getIt.registerLazySingleton<ContactLocalDataSource>(
    () => ContactLocalDataSource(),
  );

  // Repositories
  getIt.registerLazySingleton<ContactRepository>(
    () => ContactRepositoryImpl(getIt<ContactLocalDataSource>()),
  );

  getIt.registerLazySingleton<AuthLocalDataSource>(() => AuthLocalDataSource());

  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(getIt<AuthLocalDataSource>()),
  );

  // Blocs
  getIt.registerFactory<ContactBloc>(
    () => ContactBloc(getIt<ContactRepository>()),
  );

  getIt.registerFactory<AuthBloc>(() => AuthBloc(getIt<AuthRepository>()));
}
