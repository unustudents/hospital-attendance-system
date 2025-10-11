import 'package:get_it/get_it.dart';

var dI = GetIt.instance;

void init() async {
  // Register your services here, for example:
  // dI.registerSingleton<YourService>(YourServiceImplementation());

  // /// FEATURE - [HOME]
  // // STATE MANAGEMENT
  // dI.registerFactory(() => SignupCubit(registerUserUseCase: dI()));
  // // USE CASE
  // dI.registerLazySingleton(() => RegisterUserUseCase(dI()));
  // dI.registerLazySingleton(() => CheckEmailAvailabilityUseCase(dI()));
  // // REPOSITORY
  // dI.registerLazySingleton<SignupRepository>(
  //   () => SignupRepositoryImpl(remoteDataSource: dI(), localDataSource: dI()),
  // );
  // // DATA SOURCE
  // dI.registerLazySingleton<SignupRemoteDataSource>(
  //   () => SignupRemoteDataSourceImpl(client: dI()),
  // );
  // dI.registerLazySingleton<SignupLocalDataSource>(
  //   () => SignupLocalDataSourceImpl(client: dI()),
  // );
}
