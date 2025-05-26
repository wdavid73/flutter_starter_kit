import 'package:front_scaffold_flutter_v2/api/api.dart';
import 'package:front_scaffold_flutter_v2/data/data.dart';
import 'package:front_scaffold_flutter_v2/domain/repositories/repositories.dart';
import 'package:front_scaffold_flutter_v2/domain/usecases/usecases.dart';
import 'package:front_scaffold_flutter_v2/ui/blocs/blocs.dart';
import 'package:front_scaffold_flutter_v2/ui/cubits/cubits.dart';
import 'package:front_scaffold_flutter_v2/ui/shared/service/service.dart';
import 'package:get_it/get_it.dart';

final GetIt getIt = GetIt.instance;

class AppDependencyInjection {
  static void init() {
    /// Repositories
    getIt.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(
        ApiAuthDataSource(ApiClient.instance),
      ),
    );

    getIt.registerLazySingleton<ProductsRepository>(
      () => ProductsRepositoryImpl(
        ApiProductDataSource(ApiClient.instance),
      ),
    );

    /// UseCases
    getIt.registerLazySingleton<AuthUseCase>(
      () => AuthUseCase(getIt<AuthRepository>()),
    );

    getIt.registerLazySingleton<ProductsUseCase>(
      () => ProductsUseCase(getIt<ProductsRepository>()),
    );

    /// Services
    getIt.registerLazySingleton<KeyValueStorageService>(
      () => KeyValueStorageServiceImpl(),
    );

    ///  Cubits and BLoCs

    // Singleton
    getIt.registerLazySingleton<ThemeModeCubit>(() => ThemeModeCubit());

    getIt.registerLazySingleton<IntroductionCubit>(
      () => IntroductionCubit(getIt.get<KeyValueStorageService>()),
    );

    getIt.registerLazySingleton<AuthBloc>(
      () => AuthBloc(
        getIt<AuthUseCase>(),
        getIt<KeyValueStorageService>(),
      ),
    );

    getIt.registerLazySingleton<ProductsBloc>(
      () => ProductsBloc(
        getIt.get<ProductsUseCase>(),
      ),
    );

    // Factory

    getIt.registerFactory<SignInFormCubit>(
      () => SignInFormCubit(
        authBloc: getIt<AuthBloc>(),
      ),
    );

    getIt.registerFactory<RegisterFormCubit>(
      () => RegisterFormCubit(
        authBloc: getIt<AuthBloc>(),
      ),
    );
  }
}
