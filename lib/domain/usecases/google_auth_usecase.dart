import 'package:firebase_auth/firebase_auth.dart';
import 'package:front_scaffold_flutter_v2/api/api.dart';
import 'package:front_scaffold_flutter_v2/domain/repositories/sign_in_google_repository.dart';

/// Handles Google authentication-related use cases.
///
/// This class acts as an intermediary between the UI and the [GoogleSignInRepository],
/// providing methods for signing in, signing out, and retrieving user data.
class GoogleAuthUseCase {
  /// The repository responsible for handling Google authentication operations.
  final GoogleSignInRepository repository;

  /// Creates an instance of [GoogleAuthUseCase] with the required [repository].
  GoogleAuthUseCase(this.repository);

  /// Signs in a user using Google authentication.
  ///
  /// This method delegates the sign-in process to [GoogleSignInRepository].
  ///
  /// Returns:
  ///   - [ResponseSuccess]: If authentication is successful, containing user data.
  ///   - [ResponseFailed]: If authentication fails, containing an error message.
  Future<ResponseState> signInWithGoogle() async {
    return repository.signInGoogle();
  }

  /// Signs out the currently authenticated Google user.
  ///
  /// Logs the user out from Google authentication and clears any stored session data.
  ///
  /// Returns:
  ///   - [ResponseSuccess]: If sign-out is successful.
  ///   - [ResponseFailed]: If sign-out fails.
  Future<ResponseState> signOutGoogle() async {
    return repository.signOutGoogle();
  }

  /// Retrieves the authentication token of the signed-in Google user.
  ///
  /// This token can be used for backend authentication or session management.
  ///
  /// Returns:
  ///   - A [Future] that resolves to the authentication token as a [String].
  Future<String> getToken() async {
    return repository.getToken();
  }

  /// Retrieves the currently authenticated Google user.
  ///
  /// Returns:
  ///   - A [Future] that resolves to a [User] object if a user is signed in.
  ///   - `null` if no user is authenticated.
  Future<User?> getUser() async {
    return repository.user;
  }
}