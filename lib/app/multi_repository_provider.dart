import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:front_scaffold_flutter_v2/api/api.dart';
import 'package:front_scaffold_flutter_v2/data/data.dart';
import 'package:front_scaffold_flutter_v2/domain/repositories/repositories.dart';
import 'package:front_scaffold_flutter_v2/domain/usecases/usecases.dart';

List<RepositoryProvider> buildRepositories() {
  return [
    // * AUTH REPOSITORY AND DATASOURCE
    RepositoryProvider<AuthRepository>(
      create: (_) => AuthRepositoryImpl(
        ApiAuthDataSource(ApiClient.instance),
      ),
    ),
    RepositoryProvider<AuthUseCase>(
      create: (context) => AuthUseCase(
        context.read<AuthRepository>(),
      ),
    ),

    // EXAMPLE REPOSITORY AND DATASOURCE
    RepositoryProvider<ProductsRepository>(
      create: (_) => ProductsRepositoryImpl(
        ApiProductDataSource(ApiClient.instance),
      ),
    ),
    RepositoryProvider<ProductsUseCase>(
      create: (context) => ProductsUseCase(
        context.read(),
      ),
    ),
  ];
}