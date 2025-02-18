import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:front_scaffold_flutter_v2/api/api.dart';
import 'package:front_scaffold_flutter_v2/data/data.dart';
import 'package:front_scaffold_flutter_v2/domain/repositories/repositories.dart';
import 'package:front_scaffold_flutter_v2/domain/usecases/usecases.dart';

/// Builds and provides a list of `RepositoryProvider` instances.
///
/// This function initializes all repositories and use cases required for the app,
/// ensuring that they are available for dependency injection via `RepositoryProvider`.
///
/// Returns:
///   - A `List<RepositoryProvider>` containing all repositories and use cases.
List<RepositoryProvider> buildRepositories() {
  return [
    /// Provides the [AuthRepository] and its corresponding [AuthUseCase].
    ///
    /// The [AuthRepository] is implemented by [AuthRepositoryImpl] and
    /// depends on [ApiAuthDataSource] for data access.
    /// The [AuthUseCase] depends on the [AuthRepository] for its logic.
    RepositoryProvider<AuthRepository>(
      create: (_) => AuthRepositoryImpl(
        ApiAuthDataSource(ApiClient.instance),
      ),
    ),

    /// Provides `AuthUseCase`, which contains authentication-related business logic.
    RepositoryProvider<AuthUseCase>(
      create: (context) => AuthUseCase(
        context.read<AuthRepository>(),
      ),
    ),

    /// Provides `ProductsRepository`, which handles product-related operations.
    RepositoryProvider<ProductsRepository>(
      create: (_) => ProductsRepositoryImpl(
        ApiProductDataSource(ApiClient.instance),
      ),
    ),

    /// Provides `ProductsUseCase`, which contains business logic for managing products.
    RepositoryProvider<ProductsUseCase>(
      create: (context) => ProductsUseCase(
        context.read(),
      ),
    ),
  ];
}
