import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:front_scaffold_flutter_v2/domain/infrastructure.dart';
import 'package:front_scaffold_flutter_v2/ui/blocs/blocs.dart';
import 'package:front_scaffold_flutter_v2/ui/shared/service/service.dart';

List<BlocProvider> buildBlocs() {
  return [
    BlocProvider<AuthBloc>(
      create: (context) => AuthBloc(
        context.read<AuthUseCase>(),
        KeyValueStorageServiceImpl(),
      ),
    ),
    BlocProvider<SignInFormCubit>(
      create: (context) => SignInFormCubit(
        authBloc: context.read<AuthBloc>(),
      ),
    ),
    // EXAMPLE BLOC
    BlocProvider<ProductsBloc>(
      create: (context) => ProductsBloc(
        context.read(),
      ),
    ),
  ];
}