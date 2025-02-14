import 'package:firebase_auth/firebase_auth.dart';
import 'package:front_scaffold_flutter_v2/api/api.dart';

/// Defines the contract for Google Sign-In related operations.
///
/// Implementations of this class are responsible for handling authentication
/// using Google, including signing in, signing out, and retrieving user data.
abstract class GoogleSignInRepository {
  /// Signs in a user using Google authentication.
  ///
  /// Returns:
  ///   - [ResponseSuccess] if authentication is successful.
  ///   - [ResponseFailed] if authentication fails.
  Future<ResponseState> signInGoogle();

  /// Signs out the currently authenticated Google user.
  ///
  /// Returns:
  ///   - [ResponseSuccess] if sign-out is successful.
  ///   - [ResponseFailed] if sign-out fails.
  Future<ResponseState> signOutGoogle();

  /// Retrieves the authentication token of the signed-in Google user.
  ///
  /// This token can be used for backend authentication or session management.
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