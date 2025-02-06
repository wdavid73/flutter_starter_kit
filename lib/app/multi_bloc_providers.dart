import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:front_scaffold_flutter_v2/ui/blocs/blocs.dart';

List<BlocProvider> buildBlocs() {
  return [
    BlocProvider<ProductsBloc>(
      create: (context) => ProductsBloc(
        context.read(),
      ),
    ),
  ];
}