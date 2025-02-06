import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:front_scaffold_flutter_v2/api/api.dart';
import 'package:front_scaffold_flutter_v2/data/data.dart';
import 'package:front_scaffold_flutter_v2/domain/infrastructure.dart';

List<RepositoryProvider> buildRepositories() {
  return [
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