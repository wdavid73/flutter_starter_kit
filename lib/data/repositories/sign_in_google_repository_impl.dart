import 'package:firebase_auth/firebase_auth.dart';
import 'package:front_scaffold_flutter_v2/api/response.dart';
import 'package:front_scaffold_flutter_v2/domain/datasources/google_sign_in_datasource.dart';
import 'package:front_scaffold_flutter_v2/domain/repositories/sign_in_google_repository.dart';

/// Implementation of [GoogleSignInRepository].
///
/// This class acts as an intermediary between the domain layer and the
/// [GoogleSignInDataSource], delegating authentication operations to it.
class GoogleSignInRepositoryImpl extends GoogleSignInRepository {
  /// The data source responsible for handling Google Sign-In operations.
  final GoogleSignInDataSource datasource;

  /// Creates an instance of [GoogleSignInRepositoryImpl] with the required [datasource].
  GoogleSignInRepositoryImpl(this.datasource);

  /// Signs in a user using Google authentication.
  ///
  /// Delegates the sign-in process to the [GoogleSignInDataSource].
  ///
  /// Returns:
  ///   - [ResponseSuccess] if authentication is successful.
  ///   - [ResponseFailed] if authentication fails.
  @override
  Future<ResponseState> signInGoogle() {
    return datasource.signInGoogle();
  }

  /// Signs out the currently authenticated Google user.
  ///
  /// Delegates the sign-out process to the [GoogleSignInDataSource].
  ///
  /// Returns:
  ///   - [ResponseSuccess] if sign-out is successful.
  ///   - [ResponseFailed] if sign-out fails.
  @override
  Future<ResponseState> signOutGoogle() {
    return datasource.signOutGoogle();
  }

  /// Retrieves the authentication token of the signed-in Google user.
  ///
  /// This token can be used for backend authentication or session management.
  ///
  /// Returns:
  ///   - A [Future] that resolves to the authentication token as a [String].
  @override
  Future<String> getToken() {
    return datasource.getToken();
  }

  /// Retrieves the currently authenticated Google user.
  ///
  /// Returns:
  ///   - A [Future] that resolves to a [User] object if a user is signed in.
  ///   - `null` if no user is authenticated.
  @override
  Future<User?> get user => datasource.user;
}