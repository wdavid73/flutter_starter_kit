/// This barrel file exports all repository contracts.
///
/// These repositories define the data access layer, providing
/// an abstraction over different data sources (e.g., API, local storage).
///
/// By importing this file, all repository interfaces become available
/// for use in the domain layer.

// ? REPOSITORY INTERFACES
export 'auth_repository.dart'; // Defines authentication-related operations
export 'products_repository.dart'; // Defines operations related to product management
export 'sign_in_google_repository.dart'; // Defines Google Sign-In related operations