/// This barrel file exports all the necessary data sources, mappers, models,
/// and repository implementations.
///
/// By importing this file, you gain access to all the key components of
/// the data layer, simplifying imports across the project.
///
library;

/// ? DATA SOURCES IMPLEMENTATION
export 'datasources/api_products_datasource_impl.dart';
export 'datasources/api_auth_datasource_impl.dart';
export 'datasources/google_sign_in_datasource_impl.dart';

// ? MAPPERS
export 'mappers/product_mapper.dart';
export 'mappers/user_mapper.dart';

// ? MODELS
export 'models/product.dart';
export 'models/user.dart';
export 'models/auth_response.dart';

// ? REPOSITORIES IMPLEMENTATION
export 'repositories/products_repository_impl.dart';
export 'repositories/auth_repository_impl.dart';
export 'repositories/sign_in_google_repository_impl.dart';