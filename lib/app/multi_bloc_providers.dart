import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:front_scaffold_flutter_v2/domain/usecases/usecases.dart';
import 'package:front_scaffold_flutter_v2/ui/blocs/blocs.dart';
import 'package:front_scaffold_flutter_v2/ui/cubits/cubits.dart';
import 'package:front_scaffold_flutter_v2/ui/shared/service/service.dart';

/// Builds and provides a list of `BlocProvider` instances.
///
/// This function initializes all the necessary BLoCs and Cubits used in the app,
/// ensuring they are available for dependency injection via the `BlocProvider` widget.
///
/// Returns:
///   - A `List<BlocProvider>` containing all the required blocs and cubits.
List<BlocProvider> buildBlocs() {
  return [
    /// Provides the `AuthBloc`, responsible for handling authentication logic.
    BlocProvider<AuthBloc>(
      create: (context) => AuthBloc(
        useCase: context.read<AuthUseCase>(),
        googleAuthUseCase: context.read<GoogleAuthUseCase>(),
        keyValueStorageService: KeyValueStorageServiceImpl(),
      ),
    ),

    /// Provides the `SignInFormCubit`, which manages the state of the sign-in form.
    BlocProvider<SignInFormCubit>(
      create: (context) => SignInFormCubit(
        authBloc: context.read<AuthBloc>(),
      ),
    ),

    /// Provides the `ProductsBloc`, which manages product-related state.
    BlocProvider<ProductsBloc>(
      create: (context) => ProductsBloc(
        context.read(), // Injects required dependencies automatically.
      ),
    ),
  ];