/// This barrel file exports all use case implementations.
///
/// Use cases contain the business logic of the application, acting as an
/// intermediary between repositories and the presentation layer.
///
/// Importing this file provides access to all use cases in the domain layer.
library;

// ? USE CASES
export 'auth_usecase.dart'; // Handles authentication logic (login, register, etc.)
export 'google_auth_usecase.dart'; // Handles Google authentication logic
export 'products_usecase.dart'; // Handles product-related business logic