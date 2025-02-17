part of 'auth_bloc.dart';

/// Represents the possible authentication states of the application.
enum AuthStatus {
  /// Indicates that the authentication status is currently being checked.
  checking,

  /// Indicates that the user is authenticated.
  authenticated,

  /// Indicates that the user is not authenticated.
  notAuthenticated,
}

/// Represents the state of the authentication process.
///
/// This class holds the current [authStatus], the authenticated [user] (if any),
/// and any [errorMessage] that may have occurred during the authentication
/// process.
class AuthState extends Equatable {
  /// The current authentication status.
  final AuthStatus authStatus;

  /// The authenticated user, or null if not authenticated.
  final UserModel? user;

  /// An error message, if any, that occurred during authentication.
  final String errorMessage;

  /// The loading state of the Google sign-in process.
  final bool googleSignInLoading;

  /// Creates an [AuthState] instance.
  ///
  /// Parameters:
  ///   - [authStatus]: The current authentication status. Defaults to [AuthStatus.checking].
  ///   - [user]: The authenticated user, or null if not authenticated.
  ///   - [errorMessage]: An error message, if any. Defaults to an empty string.
  ///   - [googleSignInLoading]: The loading state of the Google sign-in process. Defaults to false.
  const AuthState({
    this.authStatus = AuthStatus.checking,
    this.user,
    this.errorMessage = '',
    this.googleSignInLoading = false,
  });

  @override
  List<Object?> get props =>
      [user, errorMessage, authStatus, googleSignInLoading];

  /// Creates a new [AuthState] instance with some properties changed.
  ///
  /// This method is useful for creating a new state based on the current one,
  /// with only a few properties modified.
  ///
  /// Parameters:
  ///   - [authStatus]: The new authentication status. If null, the current status is used.
  ///   - [user]: The new authenticated user. If null, the current user is used.
  ///   - [errorMessage]: The new error message. If null, the current error message is used.
  ///   - [googleSignInLoading]: The new loading state of the Google sign-in process.
  ///
  /// Returns:
  ///   - A new [AuthState] instance with the specified properties changed.
  AuthState copyWith({
    AuthStatus? authStatus,
    UserModel? user,
    String? errorMessage,
    bool? googleSignInLoading,
  }) {
    return AuthState(
      authStatus: authStatus ?? this.authStatus,
      user: user ?? this.user,
      errorMessage: errorMessage ?? this.errorMessage,
      googleSignInLoading: googleSignInLoading ?? this.googleSignInLoading,
    );
  }
}