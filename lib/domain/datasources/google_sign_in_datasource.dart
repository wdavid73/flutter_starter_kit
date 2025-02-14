import 'package:firebase_auth/firebase_auth.dart';
import 'package:front_scaffold_flutter_v2/api/api.dart';

/// Defines the contract for data sources handling Google Sign-In operations.
///
/// Implementations of this class are responsible for interacting with external
/// authentication services such as Firebase Authentication to handle Google login.
abstract class GoogleSignInDataSource {
  /// Signs in a user using Google authentication.
  ///
  /// This method communicates with the authentication provider (e.g., Firebase)
  /// to authenticate the user using their Google account.
  ///
  /// Returns:
  ///   - [ResponseSuccess] if authentication is successful.
  ///   - [ResponseFailed] if authentication fails.
  Future<ResponseState> signInGoogle();

  /// Signs out the currently authenticated Google user.
  ///
  /// This method handles the logout process by revoking the user's session
  /// from the authentication provider.
  ///
  /// Returns:
  ///   - [ResponseSuccess] if sign-out is successful.
  ///   - [ResponseFailed] if sign-out fails.
  Future<ResponseState> signOutGoogle();

  /// Retrieves the authentication token of the signed-in Google user.
  ///
  /// This token is typically used for backend authentication or session management.
  ///
  /// Returns:
  ///   - A [Future] that resolves to the authentication token as a [String].
  Future<String> getToken();

  /// Retrieves the currently authenticated Google user.
  ///
  /// Returns:
  ///   - A [Future] that resolves to a [User] object if a user is signed in.
  ///   - `null` if no user is authenticated.
  Future<User?> get user;
}