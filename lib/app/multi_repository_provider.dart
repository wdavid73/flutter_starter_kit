import 'package:firebase_auth/firebase_auth.dart';
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
    // * AUTH REPOSITORY AND DATASOURCE
    /// Provides `AuthRepository`, which handles authentication operations.
    RepositoryProvider<AuthRepository>(
      create: (_) => AuthRepositoryImpl(
        ApiAuthDataSource(ApiClient.instance),
      ),
    ),

    // * GOOGLE SIGN-IN REPOSITORY AND DATASOURCE
    /// Provides `GoogleSignInRepository`, which manages Google authentication.
    RepositoryProvider<GoogleSignInRepository>(
      create: (_) => GoogleSignInRepositoryImpl(
        GoogleSignInDataSourceImpl(
          FirebaseAuth.instance,
        ),
      ),
    ),

    // * AUTH USE CASE
    /// Provides `AuthUseCase`, which contains authentication-related business logic.
    RepositoryProvider<AuthUseCase>(
      create: (context) => AuthUseCase(
        context.read<AuthRepository>(),
      ),
    ),

    // * GOOGLE SIGN-IN USE CASE
    /// Provides `GoogleAuthUseCase`, which manages Google Sign-In logic.
    RepositoryProvider<GoogleAuthUseCase>(
      create: (context) => GoogleAuthUseCase(
        context.read<GoogleSignInRepository>(),
      ),
    ),

    // * PRODUCTS REPOSITORY AND DATASOURCE
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